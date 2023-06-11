import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/status_model.dart';
import 'controller/providers.dart';

class StatusObj extends ConsumerWidget {
  final StatusModel model;
  final bool isSingleValue;

  const StatusObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final statusSelected = ref.watch(statusSelectedProvider);
    if (statusSelected.contains(model)) {
      color = Colors.green;
    }
    return Card(
      child: ListTile(
        title: Text('${model.name}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(statusSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
