import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/states.dart';

import 'controller/providers.dart';

class AccessMark extends ConsumerWidget {
  final String access;
  const AccessMark({
    super.key,
    required this.access,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            ref.watch(accessStateProvider).contains(access.toAccessStatus)
                ? const MaterialStatePropertyAll<Color>(Colors.black)
                : null,
      ),
      onPressed: () {
        ref.read(accessStateProvider.notifier).update(access.toAccessStatus);
      },
      child: Text(access),
    );
  }
}
