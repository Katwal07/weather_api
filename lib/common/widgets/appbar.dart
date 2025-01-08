import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? kCustomToolBarheight;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.kCustomToolBarheight,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kCustomToolBarheight == null ? kToolbarHeight : kCustomToolBarheight!);
}
