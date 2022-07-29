import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/TodoServices/landingController.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/constants/dimensions.dart';
import 'package:todoapp/screens/completed_screen.dart';
import 'package:todoapp/screens/incomplete_screen.dart';
import 'package:todoapp/screens/main_screen.dart';

class LandingPage extends StatelessWidget {
  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          child: BottomNavigationBar(
              backgroundColor: AppColors.mainColor,
              // fixedColor: AppColors.textColor2,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.textColor,
              unselectedItemColor: AppColors.textColor2,
              onTap: landingPageController.changeTabIndex,
              currentIndex: landingPageController.tabIndex.value,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                      color: AppColors.iconColor1,
                    ),
                    label: 'All'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle, color: AppColors.iconColor1),
                    label: 'Completed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle_outlined,
                        color: AppColors.iconColor1),
                    label: 'InComplete')
              ]),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              AllScreen(),
              CompletedScreen(),
              InCompletedScreen(),
            ],
          )),
    ));
  }
}
