import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/allowed_access.dart';

class HomeModule extends ConsumerWidget {
  final List<String> access;
  final String title;
  final IconData icon;
  final Color color;
  final List<IconButton> actions;
  const HomeModule({
    Key? key,
    this.access = const [],
    required this.title,
    required this.icon,
    required this.color,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.read(allowedAccessProvider.notifier).consultFor(access)) {
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
    } else {
      return const SizedBox();
    }
  }
}
