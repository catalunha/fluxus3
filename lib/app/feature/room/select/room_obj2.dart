import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/room_model.dart';
import 'controller/providers.dart';

class RoomObj2 extends ConsumerWidget {
  final RoomModel model;
  final bool isSingleValue;

  const RoomObj2({Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final roomSelected = ref.watch(roomSelectedProvider);
    if (roomSelected.contains(model)) {
      color = Colors.green;
    }
    return ElevatedButton(
      onPressed: () {
        if (isSingleValue) {
          Navigator.of(context).pop(model);
        } else {
          ref.watch(roomSelectedProvider.notifier).toggle(model);
        }
      },
      child: Text('${model.name}'),
    );
    /*
    return Card(
      child: ListTile(
        title: Text('${model.name}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(roomSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
    */
  }
}
