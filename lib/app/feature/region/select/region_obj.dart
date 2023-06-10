import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/region_model.dart';
import 'controller/providers.dart';

class RegionObj extends ConsumerWidget {
  final RegionModel model;
  final bool isSingleValue;

  const RegionObj({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final regionSelected = ref.watch(regionSelectedProvider);
    if (regionSelected.contains(model)) {
      color = Colors.green;
    }
    return Card(
      child: ListTile(
        title: Text('${model.uf} - ${model.city} - ${model.name}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(regionSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
