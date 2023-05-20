import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/screens/starred_tasks.dart';
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
          bottom: TabBar(
            labelColor: kPrimaryColor,
            labelStyle: GoogleFonts.roboto(),
            unselectedLabelColor: kSecondaryTextColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.only(bottom: -12),
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
        body: Container(
          // height: double.infinity,
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: kBorder,
              ),
            ),
          ),
          child: Column(
            children: [
              const Expanded(
                child: TabBarView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    StarredTasksScreen(),
                    Center(
                      child: Text("Tasks Tab"),
                    ),
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
                        size: 32,
                      ),
                    ),
                    TouchableOpacity(
                      backgroundColor: kBackGroundColor,
                      child: Icon(
                        Icons.more_horiz_sharp,
                        color: kMuted,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
