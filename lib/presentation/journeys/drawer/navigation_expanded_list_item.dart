import 'package:flutter/material.dart';
import 'package:movieapp_bloc/common/flutter_screenutil/flutter_screenutil.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final List<String> children;
  final Function onPressed;

  const NavigationExpandedListItem({
    Key? key,
    required this.title,
    required this.children,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 2,
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        children: <Widget>[
          for (int i = 0; i < children.length; i++)
            NavigationSubListItem(
                title: children[i], onPressed: () => onPressed(i))
        ],
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const NavigationSubListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 2),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
