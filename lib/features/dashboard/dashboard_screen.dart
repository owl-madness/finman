import 'package:finman/app/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routesList = AppRoutes.tempRouteList();
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: ListView.builder(
        itemCount: routesList.length,
        // gridDelegate:
        //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(routesList[index]),
            onTap: () {
              context.push(routesList[index]);
            },
            // child: Container(
            //   padding: EdgeInsets.all(15),
            //   child: Text(routesList[index]),
            // ),
          );
        },
      ),
    );
  }
}
