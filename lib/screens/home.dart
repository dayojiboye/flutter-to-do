import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_tab_bar_indicator.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: TouchableOpacity(
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(bottom: 32),
          child: const TouchableOpacity(
            width: 70,
            height: 70,
            opacity: 1.0,
            decoration: BoxDecoration(
              color: kBackGroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 213, 212, 212),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              size: 45,
              color: kPrimaryColor,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: kBorder,
                  ),
                ),
              ),
              child: TabBar(
                labelColor: kPrimaryColor,
                labelStyle: GoogleFonts.roboto(),
                unselectedLabelColor: kSecondaryTextColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(bottom: -7),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.star, size: 30),
                  ),
                  Tab(
                    child: Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                indicator: TabBarIndicator(
                  color: kPrimaryColor,
                  radius: 4,
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Text("Starred Tasks Tab"),
                  Text("Tasks Tab"),
                ],
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              decoration: const BoxDecoration(
                color: kBackGroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 213, 212, 212),
                    blurRadius: 7,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TouchableOpacity(
                    backgroundColor: kBackGroundColor,
                    child: Icon(
                      Icons.menu_sharp,
                      color: kMuted,
                      size: 40,
                    ),
                  ),
                  TouchableOpacity(
                    backgroundColor: kBackGroundColor,
                    child: Icon(
                      Icons.more_horiz_sharp,
                      color: kMuted,
                      size: 40,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
