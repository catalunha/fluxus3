import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller/providers.dart';

import '../../../core/models/anamnese_group_model.dart';

class GroupMark extends ConsumerWidget {
  final AnamneseGroupModel model;
  const GroupMark({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupSelected = ref.watch(anamneseGroupSelectedProvider);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: groupSelected?.id == model.id
            ? const MaterialStatePropertyAll<Color>(Colors.black)
            : null,
      ),
      onPressed: () {
        ref.read(anamneseGroupSelectedProvider.notifier).set(model);
      },
      child: Text(model.name),
    );
  }
}
