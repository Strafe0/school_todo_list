import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_todo_list/presentation/task_list/task_list_notifier.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  final double expandedHeight;
  final double collapsedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppBar(
          scrolledUnderElevation: 4,
          shadowColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
        ),
        Positioned(
          bottom: (46 - shrinkOffset).clamp(16, 46),
          left: (60 - shrinkOffset).clamp(16, 60),
          child: Text(
            "Мои дела",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: (32 - shrinkOffset / 3).clamp(20, 32),
                ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 60,
              bottom: 16,
            ),
            child: Opacity(
              opacity: (1 - shrinkOffset / 20).clamp(0, 1),
              child: Text(
                "Выполнено - 10",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
            ),
          ),
        ),
        const Positioned(
          right: 12,
          bottom: 0,
          child: VisibilityButton(),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class VisibilityButton extends StatelessWidget {
  const VisibilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    TaskListNotifier notifier = Provider.of<TaskListNotifier>(context);

    return IconButton(
      onPressed: () {
        notifier.showCompleted = !notifier.showCompleted;
      },
      icon: Icon(
        notifier.showCompleted
            ? Icons.visibility_off
            : Icons.visibility,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
