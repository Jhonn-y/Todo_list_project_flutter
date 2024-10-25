import 'package:flutter/material.dart';
import 'package:todo_list_project/app/core/ui/themeExtentions.dart';
import 'package:todo_list_project/app/core/widgets/cardFilter.dart';

class HomeFilters extends StatefulWidget {

  const HomeFilters({ super.key });

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filtros",
          style: context.titleStyle,
        ), SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardFilter(),
            ],
          ),
        )
        ],
      );
  }
}