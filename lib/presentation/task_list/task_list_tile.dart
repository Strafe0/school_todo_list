import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/importance.dart';
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
        contentPadding: const EdgeInsets.only(
          left: 8.0,
          right: 16.0,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.tasks[widget.index].isCompleted,
        onChanged: (bool? value) {
          setState(() {
            widget.tasks[widget.index].toggle();
          });
        },
        fillColor: WidgetStatePropertyAll(widget.tasks[widget.index].isCompleted
              ? Theme.of(context).colorScheme.secondary
              : null,
        ),
        checkColor: Theme.of(context).colorScheme.surfaceContainer,
        checkboxShape: checkboxShape(widget.tasks[widget.index]),
        side: BorderSide(color: Theme.of(context).dividerColor, width: 2),
        title: TaskTitle(task: widget.tasks[widget.index]),
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
        decoration: task.isCompleted
            ? TextDecoration.lineThrough
            : null,
        decorationColor: Theme.of(context).dividerColor,
      ),
      TextSpan(
        children: [
          if (task.importance == Importance.high)
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.priority_high,
                color: Colors.red,
              ),
            ),
          if (task.importance == Importance.low) 
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.arrow_downward,
                color: Colors.grey,
              ),
            ),
          TextSpan(text: task.title),
        ],
      ),
    );
  }
}