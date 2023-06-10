import 'package:flutter/material.dart';

class HomeModule extends StatelessWidget {
  // final List<String> access;
  final String title;
  final IconData icon;
  final Color color;
  final List<IconButton> actions;
  const HomeModule({
    Key? key,
    // required this.access,
    required this.title,
    required this.icon,
    required this.color,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (GetModuleAllowedAccess.consultFor(access, context)) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                icon,
                size: 50,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
              Wrap(
                children: actions,
              )
            ],
          ),
        ),
      ),
    );
    // } else {
    //   return const SizedBox();
    // }
  }
}
