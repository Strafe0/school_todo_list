import 'package:flutter/material.dart';
import 'package:school_todo_list/navigation/navigation_state.dart';
import 'package:school_todo_list/navigation/routes.dart';

class MyRouterInformationParser extends RouteInformationParser<NavigationState> {
  @override
  Future<NavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    // "task"
    if (routeInformation.uri.pathSegments.length == 1) {
      final path = routeInformation.uri.pathSegments.first;
      if (path == Routes.taskUri.pathSegments.first) {
        return NavigationState.newTask();
      }
    }

    return NavigationState.root();
  }

  @override
  RouteInformation? restoreRouteInformation(NavigationState configuration) {
    if (configuration.isNewTaskScreen) {
      return RouteInformation(uri: Routes.taskUri);
    }

    return RouteInformation(uri: Routes.rootUri);
  }
}