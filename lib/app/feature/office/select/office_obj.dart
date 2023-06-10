import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/office_model.dart';
import 'controller/providers.dart';

class OfficeObj extends ConsumerWidget {
  final OfficeModel model;
  final bool isSingleValue;

  const OfficeObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final officeSelected = ref.watch(officeSelectedProvider);
    if (officeSelected.contains(model)) {
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
            ref.watch(officeSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
