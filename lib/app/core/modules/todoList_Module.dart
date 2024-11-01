import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_project/app/core/modules/todoList_page.dart';


  abstract class TodolistModule {
    final Map<String,WidgetBuilder> _routers;

  final List<SingleChildWidget>? _bindings;

  TodolistModule({List<SingleChildWidget>? bindings, required Map<String,WidgetBuilder> routers})
      : _bindings = bindings,
        _routers = routers;

  Map<String,WidgetBuilder> get routers {
    return _routers.map((key, pageBuilder) => MapEntry(key, (_) =>TodolistPage(
      bindings: _bindings,
      page: pageBuilder,
    )));
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routers[path];
    if (widgetBuilder != null) {
      return TodolistPage(
        page: widgetBuilder,
      bindings: _bindings,
    );
    }
    throw Exception('No page found for path: $path');
  }

}