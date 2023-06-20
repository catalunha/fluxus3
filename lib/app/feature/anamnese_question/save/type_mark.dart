import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'controller/states.dart';

class TypeMark extends ConsumerWidget {
  final AnamneseQuestionTypeStatus type;
  const TypeMark({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: ref.watch(anamneseQuestionTypeProvider) == type
            ? const MaterialStatePropertyAll<Color>(Colors.black)
            : null,
      ),
      onPressed: () {
        ref.read(anamneseQuestionTypeProvider.notifier).set(type);
      },
      child: Text(type.name),
    );
  }
}
