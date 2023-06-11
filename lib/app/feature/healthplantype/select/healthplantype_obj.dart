import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/healthplantype_model.dart';
import 'controller/providers.dart';

class HealthPlanTypeObj extends ConsumerWidget {
  final HealthPlanTypeModel model;
  final bool isSingleValue;

  const HealthPlanTypeObj(
      {Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final healthPlanTypeSelected = ref.watch(healthPlanTypeSelectedProvider);
    if (healthPlanTypeSelected.contains(model)) {
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
            ref.watch(healthPlanTypeSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
