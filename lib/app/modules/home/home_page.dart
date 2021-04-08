import 'package:flutter/material.dart';
import 'package:insta_mass_agent/app/modules/controller/main_controller.dart';
import 'package:get/get.dart';
import '../drawer/drawer.dart';

class HomePage extends GetView {
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: true,
              // snap: false,
              elevation: 0,
              expandedHeight: Get.height * .5,
              actions: [],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 500,
                      color: Colors.red,
                    ),
                    Container(
                      child: Text("Hi"),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          height: Get.height * 2,
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor.withGreen(10),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              mainController.debug();
            },
            child: Text("debug button"),
          ),
        ),
      ),
    );
  }
}
