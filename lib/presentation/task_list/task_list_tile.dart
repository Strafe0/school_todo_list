import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/task.dart';
import 'package:school_todo_list/presentation/task_list/dismissible_backgrounds.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({super.key, required this.tasks, required this.index});

  final List<Task> tasks;
  final int index;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.tasks[widget.index]),
      direction: DismissDirection.horizontal,
      background: const DismissibleBackground(),
      secondaryBackground: const DismissibleSecondaryBackground(),
      onDismissed: (direction) {
        debugPrint("Dismissible direction: $direction");
      },
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          setState(() {
            widget.tasks[widget.index].toggle();
          });
        } else if (direction == DismissDirection.endToStart) {
          setState(() {
            widget.tasks.removeAt(widget.index);
          });
        }

        return Future.value(false);
      },
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.tasks[widget.index].isCompleted,
        onChanged: (bool? value) {
          setState(() {
            widget.tasks[widget.index].toggle();
          });
        },
        title: Text(
          widget.tasks[widget.index].title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            decoration: widget.tasks[widget.index].isCompleted
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        secondary: SizedBox(
          height: 24,
          width: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              debugPrint("info pressed");
            },
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.tertiary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
