import 'package:flutter/material.dart';

import 'package:new_halo_task/dashboard/appbar.dart';
import 'package:new_halo_task/models/task_models/task_builder.dart';
import 'package:new_halo_task/widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: TaskBuilder(),
      extendBody: true,
    );
  }
}