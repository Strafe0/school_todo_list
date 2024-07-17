import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/utils/snack_bar.dart';

class FastCreationTextField extends StatefulWidget {
  const FastCreationTextField({super.key});

  @override
  State<FastCreationTextField> createState() => _FastCreationTextFieldState();
}

class _FastCreationTextFieldState extends State<FastCreationTextField> {
  final _focusNode = FocusNode();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      controller: _textController,
      decoration: InputDecoration(
        labelText: context.loc.newTask,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
      ),
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      onTapOutside: (event) => _focusNode.unfocus(),
      textInputAction: TextInputAction.done,
      onEditingComplete: () async {
        logger.d("FastCreationTextField editing complete");
        _focusNode.unfocus();
        final taskListNotifier = Provider.of<TaskListNotifier>(
          context,
          listen: false,
        );

        bool isSuccess = await taskListNotifier.createTask(
          Task(title: _textController.text.trim()),
        );

        if (!isSuccess && context.mounted) {
          showSnackBar(context, context.loc.errorCreationTask);
        } else {
          _textController.text = '';
        }
      },
    );
  }
}
