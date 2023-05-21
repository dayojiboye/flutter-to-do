import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/screens/starred_tasks.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/app_bottom_sheet.dart';
import 'package:to_do/widgets/app_tab_bar_indicator.dart';
import 'package:to_do/widgets/tab_controller_tile.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          bottom: TabBar(
            controller: _controller,
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
          padding: const EdgeInsets.only(bottom: 20),
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
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    StarredTasksScreen(),
                    Center(
                      child: Text("Tasks Tab"),
                    ),
                  ],
                ),
              ),
              Container(
                height: 90,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TouchableOpacity(
                      onTap: () => AppBottomSheet(
                        context: context,
                        showDragHandle: false,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, right: 8.0),
                          child: Column(
                            children: [
                              TabControllerTile(
                                leading: const Icon(Icons.star, size: 25),
                                title: "Starred",
                                modalContext: context,
                                selected: _selectedIndex == 0,
                                onTap: () {
                                  if (_selectedIndex == 0) return;
                                  _controller.animateTo(_selectedIndex = 0);
                                },
                              ),
                              TabControllerTile(
                                leading: const SizedBox(),
                                title: "My Tasks",
                                modalContext: context,
                                selected: _selectedIndex == 1,
                                onTap: () {
                                  if (_selectedIndex == 1) return;
                                  _controller.animateTo(_selectedIndex = 1);
                                },
                              )
                            ],
                          ),
                        ),
                      ).open(),
                      backgroundColor: kBackGroundColor,
                      child: const Icon(
                        Icons.menu_sharp,
                        color: kMuted,
                        size: 30,
                      ),
                    ),
                    TouchableOpacity(
                      onTap: () => AppBottomSheet(
                        context: context,
                        showDragHandle: false,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, right: 8.0),
                          child: Column(
                            children: [
                              SwitchListTile.adaptive(
                                value: false,
                                title: const Text(
                                  "Switch to dark mode",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: kPrimaryTextColor,
                                  ),
                                ),
                                onChanged: (value) {},
                              )
                            ],
                          ),
                        ),
                      ).open(),
                      backgroundColor: kBackGroundColor,
                      child: const Icon(
                        Icons.more_horiz_sharp,
                        color: kMuted,
                        size: 30,
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
