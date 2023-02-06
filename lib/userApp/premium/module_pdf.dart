import 'package:flutter/material.dart';

import '../screens/home/MyProfile.dart';

class Module_pdf extends StatefulWidget {
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState();
}

class _SilverAppBarWithTabBarState extends State<Module_pdf>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

//hhhhh
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Text(''),
                snap: true,
                floating: true,
                expandedHeight: 130.0,
                flexibleSpace: FlexibleSpaceBar(),
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Videos'),
                    Tab(text: 'pdf'),
                  ],
                  controller: controller,
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 2,
            child: TabBarView(
              children: [MyProfile(), Text('ghchgcg')],
            ),
          )),
    );
  }
}
