import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/task_edit/task_edit_change_notifier.dart';
import 'package:school_todo_list/presentation/task_list/task_list_notifier.dart';
import 'package:school_todo_list/presentation/utils/date_format.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';
import 'package:school_todo_list/presentation/utils/text_with_importance_level.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen({
    super.key,
    this.taskForEdit,
  });

  final Task? taskForEdit;

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late final Task task;

  @override
  void initState() {
    super.initState();
    if (widget.taskForEdit != null) {
      task = widget.taskForEdit!;
    } else {
      task = Task(title: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => TaskEditNotifier(
          task: task,
          editMode: widget.taskForEdit != null,
        ),
        child: Scaffold(
          appBar: const TaskEditScreenAppBar(),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TaskTextField(),
                  const TaskImportanceField(),
                  const Divider(),
                  const TaskDeadlineField(),
                  const Divider(),
                  DeleteTaskButton(
                    deleteTask: widget.taskForEdit != null ? () {} : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskEditScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TaskEditScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        height: 24,
        width: 24,
        child: IconButton(
          onPressed: () {
            logger.d("TaskEditScreen close");
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _onSavePressed(context),
          child: Text("Сохранить".toUpperCase()),
        ),
      ],
      elevation: 0,
      scrolledUnderElevation: 4,
      shadowColor: Theme.of(context).colorScheme.surface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
        statusBarColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Future<void> _onSavePressed(BuildContext context) async {
    logger.d("Save pressed");
    final taskListNotifier = Provider.of<TaskListNotifier>(
      context,
      listen: false,
    );

    final notifier = Provider.of<TaskEditNotifier>(
      context,
      listen: false,
    );

    bool isSuccess;
    if (notifier.editMode) {
      isSuccess = await taskListNotifier.updateTask(notifier.task);
    } else {
      isSuccess = await taskListNotifier.createTask(notifier.task);
    }

    if (context.mounted) {
      if (isSuccess) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ошибка сохранения задачи"),
          ),
        );
      }
    }
  }
}

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key});

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  final _focusNode = FocusNode();
  late final TextEditingController _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textController.text =
        Provider.of<TaskEditNotifier>(context).taskTitle;
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TaskEditNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DecoratedBox(
        decoration: defaultBoxDecoration.copyWith(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: TextField(
          focusNode: _focusNode,
          controller: _textController,
          minLines: 4,
          maxLines: null,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          onTapOutside: (event) => _focusNode.unfocus(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainer,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            alignLabelWithHint: true,
            labelText: "Что нужно сделать...",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (String text) {
            notifier.taskTitle = text;
          },
        ),
      ),
    );
  }
}

class TaskImportanceField extends StatelessWidget {
  const TaskImportanceField({super.key});

  Color? getImportanceColor(BuildContext context, Importance importance) =>
      switch (importance) {
        Importance.high => Theme.of(context).colorScheme.error,
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TaskEditNotifier>(context);

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: Text(
            "Нет",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onPressed: () {
            logger.d("Selected Importance.none");
              notifier.importance = Importance.none;
          },
        ),
        MenuItemButton(
          child: Text.rich(
            style: Theme.of(context).textTheme.bodyLarge,
            createTextSpanWithImportance(
                importance: Importance.low, text: "Низкая"),
          ),
          onPressed: () {
            logger.d("Selected Importance.low");
              notifier.importance = Importance.low;
          },
        ),
        MenuItemButton(
          child: Text.rich(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            createTextSpanWithImportance(
                importance: Importance.high, text: "Высокая"),
          ),
          onPressed: () {
            logger.d("Selected Importance.high");
              notifier.importance = Importance.high;
          },
        ),
      ],
      builder: (context, controller, child) {
        return ListTile(
          title: const Text("Важность"),
          subtitle: Text.rich(
            style: TextStyle(
              color: getImportanceColor(
                context,
                notifier.taskImportance,
              ),
            ),
            createTextSpanWithImportance(
              importance: notifier.taskImportance,
              text: notifier.taskImportance.name,
            ),
          ),
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
    );
  }
}

class TaskDeadlineField extends StatefulWidget {
  const TaskDeadlineField({super.key});

  @override
  State<TaskDeadlineField> createState() => _TaskDeadlineFieldState();
}

class _TaskDeadlineFieldState extends State<TaskDeadlineField> {
  DateTime? pickedDateTime;

  @override
  Widget build(BuildContext context) {
    final Task task = Provider.of<TaskEditNotifier>(context).task;

    return SwitchListTile(
      title: const Text("Сделать до"),
      subtitle: getSubtitleWithDate(task.deadline),
      value: task.hasDeadline,
      onChanged: _onSwitchChanged,
      contentPadding: const EdgeInsets.only(left: 16, right: 0),
    );
  }

  void _onSwitchChanged(bool value) async {
    if (value) {
      pickedDateTime = await showDatePicker(
        context: context,
        initialDate: pickedDateTime ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
      );
    } else {
      pickedDateTime = null;
    }
    
    if (context.mounted) {
      Provider.of<TaskEditNotifier>(context, listen: false).deadline = pickedDateTime;
      logger.d("Selected deadline: $pickedDateTime");
    } else {
      logger.e("TaskDeadlineField: context not mounted");
    }
  }

  Text? getSubtitleWithDate(DateTime? date) {
    if (date != null) {
      return Text(
        convertDateTimeToString(date),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      );
    }
    return null;
  }
}

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({super.key, this.deleteTask});

  final void Function()? deleteTask;

  @override
  Widget build(BuildContext context) {
    final taskEditNotifier = Provider.of<TaskEditNotifier>(
      context,
      listen: false,
    );
    bool enabled = taskEditNotifier.editMode;

    return ListTile(
      enabled: enabled,
      horizontalTitleGap: 16,
      title: Text(
        "Удалить",
        style: TextStyle(
          color: enabled
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.tertiary,
        ),
      ),
      leading: Icon(
        Icons.delete,
        color: enabled
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.tertiary,
      ),
      onTap: () => _onDeletePressed(context, taskEditNotifier),
    );
  }

  Future<void> _onDeletePressed(
    BuildContext context,
    TaskEditNotifier taskEditNotifier,
  ) async {
    bool continueDeleting = await _showDeleteDialog(context);

    if (continueDeleting && context.mounted) {
      final taskListNotifier = Provider.of<TaskListNotifier>(
        context,
        listen: false,
      );
      bool isSuccess = await taskListNotifier.deleteTask(
        taskEditNotifier.task.id,
      );

      if (context.mounted) {
        if (!isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка удаления задачи")),
          );
        } else {
          Navigator.of(context).pop();
        }
      }
    }
  }

  Future<bool> _showDeleteDialog(BuildContext context) async {
    bool? userAnswer = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Удалить задачу?"),
          content: const Text(
            "После удаления задачу нельзя будет восстановить.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Отмена"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Удалить"),
            ),
          ],
        );
      },
    );
    return userAnswer ?? false;
  }
}
