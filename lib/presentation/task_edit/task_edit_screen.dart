import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
import 'package:school_todo_list/domain/entity/task.dart';
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
      child: Scaffold(
        appBar: const TaskEditScreenAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TaskTextField(task: task),
                TaskImportanceField(task: task),
                const Divider(),
                TaskDeadlineField(task: task),
                const Divider(),
                DeleteTaskButton(
                  deleteTask: widget.taskForEdit != null ? () {} : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskEditScreenAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TaskEditScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        height: 24,
        width: 24,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
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
  
  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text("Сохранить".toUpperCase()),
        ),
      ],
    );
  }
}

class TaskTextField extends StatefulWidget {
  const TaskTextField({super.key, required this.task});

  final Task task;

  @override
  State<TaskTextField> createState() => _TaskTextFieldState();
}

class _TaskTextFieldState extends State<TaskTextField> {
  final _focusNode = FocusNode();
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.task.title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: DecoratedBox(
        decoration: boxDecorationWithShadow(
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
        ),
      ),
    );
  }
}

class TaskImportanceField extends StatefulWidget {
  const TaskImportanceField({super.key, required this.task});

  final Task task;

  @override
  State<TaskImportanceField> createState() => _TaskImportanceFieldState();
}

class _TaskImportanceFieldState extends State<TaskImportanceField> {
  Color? getColor(BuildContext context) => switch(widget.task.importance) {
    Importance.high => Theme.of(context).colorScheme.error,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          child: Text(
            "Нет",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onPressed: () {
            setState(() {
              widget.task.importance = Importance.none;
            });
          },
        ),
        MenuItemButton(
          child: Text.rich(
            style: Theme.of(context).textTheme.bodyLarge,
            createTextSpanWithImportance(
                importance: Importance.low, text: "Низкая"),
          ),
          onPressed: () {
            setState(() {
              widget.task.importance = Importance.low;
            });
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
            setState(() {
              widget.task.importance = Importance.high;
            });
          },
        ),
      ],
      builder: (context, controller, child) {
        return ListTile(
          title: const Text("Важность"),
          subtitle: Text.rich(
            style: TextStyle(color: getColor(context)),
            createTextSpanWithImportance(
              importance: widget.task.importance,
              text: widget.task.importance.name,
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
  const TaskDeadlineField({super.key, required this.task});

  final Task task;

  @override
  State<TaskDeadlineField> createState() => _TaskDeadlineFieldState();
}

class _TaskDeadlineFieldState extends State<TaskDeadlineField> {
  bool hasDeadline = false;
  DateTime? pickedDateTime;

  @override
  void initState() {
    super.initState();
    hasDeadline = widget.task.hasDeadline;
    pickedDateTime = widget.task.deadline;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Сделать до"),
      subtitle: getSubtitle(pickedDateTime),
      value: hasDeadline,
      onChanged: (value) async {
        if (value) {
          pickedDateTime = await showDatePicker(
            context: context,
            initialDate: pickedDateTime,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );
        } else {
          pickedDateTime = null;
        }

        setState(() {
          hasDeadline = value;
        });
      },
      contentPadding: const EdgeInsets.only(left: 16, right: 0),
    );
  }

  Text? getSubtitle(DateTime? date) {
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
    bool enabled = deleteTask != null;

    return ListTile(
      enabled: enabled,
      horizontalTitleGap: 16,
      title: Text(
        "Удалить",
        style: TextStyle(
          color: enabled ? Colors.red : Theme.of(context).colorScheme.tertiary,
        ),
      ),
      leading: Icon(
        Icons.delete,
        color: enabled ? Colors.red : Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
