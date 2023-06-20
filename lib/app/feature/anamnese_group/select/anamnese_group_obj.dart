import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/anamnese_group_model.dart';
import 'controller/providers.dart';

class AnamneseGroupObj extends ConsumerWidget {
  final AnamneseGroupModel model;
  final bool isSingleValue;

  const AnamneseGroupObj(
      {Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final anamneseGroupselected = ref.watch(anamneseGroupSelectedProvider);
    if (anamneseGroupselected.contains(model)) {
      color = Colors.green;
    }
    return Card(
      child: ListTile(
        title: Text(model.name),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(anamneseGroupSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
