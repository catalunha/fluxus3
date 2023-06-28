import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/anamnese_question_model.dart';
import '../../../routes.dart';
import 'anamnese_question_obj.dart';
import 'controller/providers.dart';
import 'group_mark.dart';

class AnamneseQuestionListPage extends ConsumerStatefulWidget {
  const AnamneseQuestionListPage({super.key});

  @override
  ConsumerState<AnamneseQuestionListPage> createState() =>
      _AnamneseQuestionListPageState();
}

class _AnamneseQuestionListPageState
    extends ConsumerState<AnamneseQuestionListPage> {
  @override
  Widget build(BuildContext context) {
    final listGroup = ref.watch(anamneseGroupsProvider);
    final list = ref.watch(anamneseQuestionsProvider);
    final questionsFiltered = ref.watch(questionsFilteredProvider);
    // ref.watch(anamneseGroupSelectedProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${list.asData?.value.length} perguntas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AppPage.anamneseQuestionSave.name, extra: null);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text('Filtre por grupo. ${questionsFiltered.length} neste grupo.'),
          listGroup.when(
            data: (data) {
              return Wrap(
                children: [
                  for (var group in data) GroupMark(model: group),
                ],
              );
            },
            error: (error, stackTrace) {
              return const Text('Erro na lista de grupos');
            },
            loading: () {
              return const Text('Carregando grupos...');
            },
          ),
          Flexible(
            child: ReorderableListView.builder(
              itemBuilder: (context, index) {
                final level = questionsFiltered[index];
                return AnamneseQuestionObj(
                  key: ValueKey(level.id),
                  model: level,
                );
              },
              itemCount: questionsFiltered.length,
              onReorder: _onReorder,
            ),
          ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    final List<AnamneseQuestionModel> classOrderTemp =
        ref.read(questionsFilteredProvider);
    final AnamneseQuestionModel resourceId = classOrderTemp[oldIndex];
    classOrderTemp.removeAt(oldIndex);
    classOrderTemp.insert(newIndex, resourceId);
    ref.read(questionsFilteredProvider.notifier).set(classOrderTemp);
  }
}
