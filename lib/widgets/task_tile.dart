import 'package:flutter/material.dart';
import 'package:to_do/utils/colors.dart';
import 'package:to_do/widgets/touchable_opacity.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.description,
    required this.isStarred,
  });

  final String description;
  final bool isStarred;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      leading: TouchableOpacity(
        backgroundColor: Colors.transparent,
        width: 30,
        height: 30,
        onTap: () {},
        child: const Icon(
          Icons.circle_outlined,
          size: 30,
          color: kMuted,
        ),
      ),
      title: Text(
        description,
        style: const TextStyle(
          color: kPrimaryTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
      trailing: TouchableOpacity(
        backgroundColor: Colors.transparent,
        width: 30,
        height: 30,
        onTap: () {},
        child: Icon(
          isStarred ? Icons.star_outlined : Icons.star_outline,
          size: 30,
          color: isStarred ? kPrimaryColor : kMuted,
        ),
      ),
    );
  }
}
