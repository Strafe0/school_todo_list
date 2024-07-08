import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/data/mappers/mappers.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/navigation/router_delegate.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/utils/dismissible_background.dart';
import 'package:school_todo_list/presentation/utils/date_format.dart';
import 'package:school_todo_list/presentation/utils/snack_bar.dart';
import 'package:school_todo_list/presentation/utils/text_with_importance_level.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.horizontal,
        background: DismissibleBackground(
          color: Theme.of(context).colorScheme.secondary,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24.0),
          icon: Icons.check,
          iconColor: Theme.of(context).colorScheme.onSecondary,
        ),
        secondaryBackground: DismissibleBackground(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          icon: Icons.delete,
          iconColor: Theme.of(context).colorScheme.onError,
        ),
        onDismissed: (direction) {
          logger.d("Dismissible action: $direction");
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            _completeTask(context);
          } else if (direction == DismissDirection.endToStart) {
            _deleteTask(context);
          }

          return Future.value(false);
        },
        child: _TaskListTile(
          task: task,
          completeTask: _completeTask,
        ),
      ),
    );
  }

  void _completeTask(BuildContext context) async {
    Task updatedTask = task.copyWith(done: !task.done);
    bool result = await Provider.of<TaskListNotifier>(
      context,
      listen: false,
    ).updateTask(updatedTask);
    
    if (result) {
      task.toggle();
    } else if (context.mounted) {
      showSnackBar(context, context.loc.errorUpdatingTask);
    }
  }

  void _deleteTask(BuildContext context) async {
    logger.i(
      "Deleting task (swipe) ${task.id}: "
      "${task.title}",
    );

    final taskListNotifier = Provider.of<TaskListNotifier>(
      context,
      listen: false,
    );
    bool isSuccess = await taskListNotifier.deleteTask(task.id);
    if (!isSuccess && context.mounted) {
      showSnackBar(context, context.loc.errorDeletingTask);
    }
  }
}

class _TaskListTile extends StatelessWidget {
  const _TaskListTile({required this.task, required this.completeTask});

  final Task task;
  final void Function(BuildContext context) completeTask;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.done,
        onChanged: (bool? value) {
          logger.d("Toggle task ${task.id}. New value: $value");
          completeTask(context);
        },
        fillColor: WidgetStatePropertyAll(
          task.done ? Theme.of(context).colorScheme.secondary : null,
        ),
        checkColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: checkboxShape(task),
        side: BorderSide(
          color: task.importance == Importance.high
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      title: _TaskTitle(task: task),
      subtitle: task.hasDeadline
          ? _TaskDeadline(
              deadline: task.deadline!,
              isCompleted: task.done,
            )
          : null,
      contentPadding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      trailing: _TaskInfoButton(task: task),
    );
  }

  OutlinedBorder checkboxShape(Task task) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    );
  }
}

class _TaskTitle extends StatelessWidget {
  const _TaskTitle({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: task.done
            ? Theme.of(context).dividerColor
            : Theme.of(context).colorScheme.onSurface,
        decoration: task.done ? TextDecoration.lineThrough : null,
        decorationColor: Theme.of(context).dividerColor,
      ),
      createTextSpanWithImportance(
        importance: task.importance,
        text: task.title,
      ),
    );
  }
}

class _TaskInfoButton extends StatelessWidget {
  const _TaskInfoButton({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        logger.d("Go to TaskEditScreen for editing");
        (Router.of(context).routerDelegate as MyRouterDelegate)
            .showEditTaskScreen(task);
      },
      icon: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.tertiary,
        size: 24,
      ),
    );
  }
}

class _TaskDeadline extends StatelessWidget {
  const _TaskDeadline({required this.deadline, required this.isCompleted});

  final DateTime deadline;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Text(
      convertDateTimeToString(deadline, Localizations.localeOf(context)),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).dividerColor,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).dividerColor,
          ),
    );
  }
}
