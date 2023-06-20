import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/hour_model.dart';
import 'controller/providers.dart';

class HourObj2 extends ConsumerWidget {
  final HourModel model;
  final bool isSingleValue;

  const HourObj2({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final hourSelected = ref.watch(hourSelectedProvider);
    if (hourSelected.contains(model)) {
      color = Colors.green;
    }

    return ElevatedButton(
      onPressed: () {
        if (isSingleValue) {
          Navigator.of(context).pop(model);
        } else {
          ref.watch(hourSelectedProvider.notifier).toggle(model);
        }
      },
      child: Text('${model.start} às ${model.end}'),
    );
/*
    return Card(
      child: ListTile(
        title: Text('${model.name} das ${model.start} às ${model.end}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(hourSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
    */
  }
}