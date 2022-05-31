import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/constanins.dart';
import 'package:tesla_animation/models/TyrePsi.dart';
import 'package:tesla_animation/screens/components/Battery_status.dart';
import 'package:tesla_animation/screens/components/bottom_navigation.dart';
import 'package:tesla_animation/screens/components/door_lock.dart';
import 'package:tesla_animation/screens/components/tyres.dart';
import 'package:tesla_animation/screens/home_controller.dart';

import 'components/temp_Details.dart';
import 'components/temp_button.dart';
import 'components/tyre_psi_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationbattery;
  late Animation<double> _animationbatterystatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  late AnimationController _tyreAnimationController;

  // We want to animate each tyre one by one
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;

  late List<Animation<double>> _tyreAnimations;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationbattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );
    _animationbatterystatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.7, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animationTyre1Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.34, 0.5));
    _animationTyre2Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.5, 0.66));
    _animationTyre3Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.66, 0.82));
    _animationTyre4Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.82, 1));
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi,
    ];
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations =
    [_animationTyre1Psi,
    _animationTyre2Psi,
    _animationTyre3Psi,
    _animationTyre4Psi];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
            //here we have added the navigation bar
            bottomNavigationBar: TeslaBottomNavigationBar(
              onTap: (index) {
                if (index == 1)
                  _batteryAnimationController.forward();
                else if (_controller.selectedBottomTab == 1 && index != 1)
                  _batteryAnimationController.reverse(from: 0.7);
                if (index == 2)
                  _tempAnimationController.forward();
                else if (_controller.selectedBottomTab == 2 && index != 2)
                  _tempAnimationController.reverse(from: 0.4);
                if(index == 3) _tyreAnimationController.forward();
                else if (_controller.selectedBottomTab == 3 && index != 3)
                  _tyreAnimationController.reverse();
                //here we have showed the tyres and call the method
                _controller.showTyreController(index);
                _controller.onBottonNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),

            //here we have added the layout
            body: LayoutBuilder(
              builder: (context, constrains) {
                return SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                      ),
                      Positioned(
                        left:
                            constrains.maxWidth / 2 * _animationCarShift.value,
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constrains.maxHeight * 0.1),
                          child: SvgPicture.asset(
                            "assets/icons/Car.svg",
                            width: double.infinity,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        right: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isRightDoorlock,
                            press: _controller.updateRightDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        left: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isLeftDoorlock,
                            press: _controller.updateLeftDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        top: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isBonnetDoorlock,
                            press: _controller.updateBonnetDoorLock,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: defaultDuration,
                        bottom: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaultDuration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                            isLock: _controller.isBackDoorlock,
                            press: _controller.updateBackDoorLock,
                          ),
                        ),
                      ),
                      //Battery
                      Opacity(
                        opacity: _animationbattery.value,
                        child: SvgPicture.asset(
                          "assets/icons/Battery.svg",
                          width: constrains.maxWidth * 0.4,
                        ),
                      ),
                      Opacity(
                        opacity: _animationbatterystatus.value,
                        child: BatteryStatus(
                          constraints: constrains,
                        ),
                      ),
                      Opacity(
                          opacity: _animationTempShowInfo.value,
                          child: tempDetails(controller: _controller)),
                      Positioned(
                        right: -180 * (1 - _animationCoolGlow.value),
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                "assets/images/Cool_glow_2.png",
                                key: UniqueKey(),
                                width: 200,
                              )
                            : Image.asset(
                                "assets/images/Hot_glow_4.png",
                                key: UniqueKey(),
                                width: 200,
                              ),
                      ),
                      //Tyres
                      if (_controller.isshowtyre) ...tyres(constrains),
                      GridView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: defaultPadding,
                                  crossAxisSpacing: defaultPadding,
                                  childAspectRatio: constrains.maxWidth /
                                      constrains.maxHeight),
                          itemBuilder: (context, index) => ScaleTransition(
                            scale: _tyreAnimations[index],
                            child: tyrepsi(
                                  isBottomTwoTyre: index > 1,
                                  tyrePsi: demoPsiList[index],
                                ),
                          ))
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
