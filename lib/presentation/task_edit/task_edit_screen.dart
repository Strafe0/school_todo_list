import 'package:flutter/material.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen({super.key});

  @override
  State<TaskEditScreen> createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ActionButtons(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: DecoratedBox(
                  decoration: boxDecorationWithShadow(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: SizedBox(
                    height: 104,
                    child: TextField(
                      focusNode: _focusNode,
                      expands: true,
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              const TaskImportanceField(),
              const Divider(),
              const TaskDeadlineField(),
              const Divider(),
              const DeleteTaskButton(),
            ],
          ),
        ),
      ),
    );
  }
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

class TaskImportanceField extends StatelessWidget {
  const TaskImportanceField({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text("Важность"),
      subtitle: Text("Нет"),
    );
  }
}

class TaskDeadlineField extends StatelessWidget {
  const TaskDeadlineField({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(title: Text("Сделать до"), value: false, onChanged: (value) {});
  }
}

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Удалить",
        style: TextStyle(color: Colors.red),
      ),
      trailing: Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
