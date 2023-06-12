import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';

class PatientObj extends ConsumerWidget {
  final PatientModel model;
  final bool isSingleValue;

  const PatientObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final patientSelected = ref.watch(patientSelectedProvider);
    if (patientSelected.contains(model)) {
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
            ref.watch(patientSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
