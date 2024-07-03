import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/logger.dart';
import 'package:school_todo_list/presentation/notifiers/task_list_notifier.dart';
import 'package:school_todo_list/presentation/utils/shadow_box_decoration.dart';

class OfflineLabel extends StatelessWidget {
  const OfflineLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<TaskListNotifier>(
        context,
        listen: false,
      ).connectionStream,
      builder: (context, snapshot) {
        logger.d("ConnectionStreamBuilder: ${snapshot.data}");
        if (snapshot.hasData && !snapshot.data!) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: DecoratedBox(
                decoration: defaultBoxDecoration.copyWith(
                  color: Colors.red,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Оффлайн режим"),
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
