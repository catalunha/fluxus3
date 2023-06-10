import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/procedure_model.dart';
import 'controller/providers.dart';

class ProcedureObj extends ConsumerWidget {
  final ProcedureModel model;
  final bool isSingleValue;

  const ProcedureObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final procedureSelected = ref.watch(procedureSelectedProvider);
    if (procedureSelected.contains(model)) {
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
            ref.watch(procedureSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
