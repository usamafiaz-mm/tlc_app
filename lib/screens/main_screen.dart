import 'package:flutter/material.dart';
import 'package:tlc_app/screens/form_screen.dart';
import 'package:tlc_app/screens/monitoring_screen.dart';
import 'package:tlc_app/screens/sync_screen.dart';
import 'package:tlc_app/utils/constants.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = "/main-screen";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: "Monitoring"),
              Tab(text: "Sync"),
            ],
          ),
        ),
        body: TabBarView(
          children: [MonitoringScreen(), SyncScreen()],
        ),
      ),
    );
  }
}
