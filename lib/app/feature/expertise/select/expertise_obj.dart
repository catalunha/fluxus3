import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/expertise_model.dart';
import 'controller/providers.dart';

class ExpertiseObj extends ConsumerWidget {
  final ExpertiseModel model;
  final bool isSingleValue;

  const ExpertiseObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final expertiseSelected = ref.watch(expertiseSelectedProvider);
    if (expertiseSelected.contains(model)) {
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
            ref.watch(expertiseSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
