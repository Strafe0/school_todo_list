import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_screen.dart';
import 'package:school_todo_list/presentation/utils/dismissible_backgrounds.dart';
import 'package:school_todo_list/presentation/utils/date_format.dart';
import 'package:school_todo_list/presentation/utils/text_with_importance_level.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile(
      {super.key,
      required this.task,
      required this.remove,
      required this.updateList});

  final Task task;
  final void Function(String id) remove;
  final void Function() updateList;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.task),
      direction: DismissDirection.horizontal,
      background: const DismissibleBackground(),
      secondaryBackground: const DismissibleSecondaryBackground(),
      onDismissed: (direction) {
        logger.d("Dismissible action: $direction");
      },
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            widget.task.toggle();
            widget.updateList();
          });
        } else if (direction == DismissDirection.endToStart) {
          setState(() {
            widget.remove(widget.task.id);
          });
        }

        return Future.value(false);
      },
      child: CheckboxListTile(
        title: TaskTitle(task: widget.task),
        subtitle: widget.task.hasDeadline
            ? TaskDeadline(
                deadline: widget.task.deadline!,
                isCompleted: widget.task.isCompleted,
              )
            : null,
        value: widget.task.isCompleted,
        onChanged: (bool? value) {
          logger.d("Toggle task ${widget.task.id}. New value: $value");
          setState(() {
            widget.task.toggle();
            widget.updateList();
          });
        },
        contentPadding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        fillColor: WidgetStatePropertyAll(
          widget.task.isCompleted
              ? Theme.of(context).colorScheme.secondary
              : null,
        ),
        checkColor: Theme.of(context).colorScheme.surfaceContainer,
        checkboxShape: checkboxShape(widget.task),
        side: BorderSide(
          color: widget.task.importance == Importance.high
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).dividerColor,
          width: 2,
        ),
        secondary: TaskInfoButton(task: widget.task),
      ),
    );
  }

  OutlinedBorder checkboxShape(Task task) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    );
  }
}

class TaskTitle extends StatelessWidget {
  const TaskTitle({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: task.isCompleted
            ? Theme.of(context).dividerColor
            : Theme.of(context).colorScheme.onSurface,
        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        decorationColor: Theme.of(context).dividerColor,
      ),
      createTextSpanWithImportance(
        importance: task.importance,
        text: task.title,
      ),
    );
  }
}

class TaskInfoButton extends StatelessWidget {
  const TaskInfoButton({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        logger.d("Go to TaskEditScreen for editing");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskEditScreen(taskForEdit: task),
          ),
        );
      },
      icon: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.tertiary,
        size: 24,
      ),
    );
  }
}

class TaskDeadline extends StatelessWidget {
  const TaskDeadline({
    super.key,
    required this.deadline,
    required this.isCompleted,
  });

  final DateTime deadline;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Text(
      convertDateTimeToString(deadline),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).dividerColor,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).dividerColor,
          ),
    );
  }
}
