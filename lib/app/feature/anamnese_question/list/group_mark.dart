import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/feature/anamnese_question/list/controller/providers.dart';

import '../../../core/models/anamnese_group_model.dart';

class GroupMark extends ConsumerWidget {
  final AnamneseGroupModel model;
  const GroupMark({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: ref.watch(anamnesesGroupSelectedProvider) == model
            ? const MaterialStatePropertyAll<Color>(Colors.black)
            : null,
      ),
      onPressed: () {
        ref.read(anamnesesGroupSelectedProvider.notifier).set(model);
      },
      child: Text(model.name),
    );
  }
}
