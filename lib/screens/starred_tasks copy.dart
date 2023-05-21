// DEPRECATED
// DO NOT DELETE! For future usage!

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/utils/colors.dart';

class StarredTasksScreen extends ConsumerWidget {
  const StarredTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator.adaptive(
      onRefresh: () {
        return Future(() => {});
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.minHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/star.png",
                        width: MediaQuery.of(context).size.width / 2,
                        height: 250,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "No starred tasks",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Mark important tasks with a star so that \n you can easily find them here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: kSecondaryTextColor,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
