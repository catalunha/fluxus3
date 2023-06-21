// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '../../../core/models/anamnese_question_model.dart';
// import '../../../routes.dart';
// import 'anamnese_question_obj.dart';
// import 'controller/providers.dart';
// import 'group_mark.dart';

// class AnamneseQuestionListPage extends ConsumerStatefulWidget {
//   const AnamneseQuestionListPage({super.key});

//   @override
//   ConsumerState<AnamneseQuestionListPage> createState() =>
//       _AnamneseQuestionListPageState();
// }

// class _AnamneseQuestionListPageState
//     extends ConsumerState<AnamneseQuestionListPage> {
//   @override
//   Widget build(BuildContext context) {
//     final list = ref.watch(anamneseQuestionsProvider);
//     final listGroup = ref.watch(anamneseGroupsProvider);
//     ref.watch(anamneseGroupSelectedProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lista com ${list.asData?.value.length} perguntas'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.goNamed(AppPage.anamneseQuestionSave.name, extra: null);
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: list.when(data: (data) {
//         final questionsFiltered = ref.watch(questionsFilteredProvider);
//         return Column(
//           children: [
//             Text('Filtre por grupo. ${questionsFiltered.length} neste grupo.'),
//             listGroup.when(
//               data: (data) {
//                 return Wrap(
//                   children: [
//                     for (var group in data) GroupMark(model: group),
//                   ],
//                 );
//               },
//               error: (error, stackTrace) {
//                 return const Text('Erro na lista de grupos');
//               },
//               loading: () {
//                 return const Text('Carregando grupos...');
//               },
//             ),
//             Flexible(
//               child: ReorderableListView.builder(
//                 itemBuilder: (context, index) {
//                   final level = questionsFiltered[index];
//                   return AnamneseQuestionObj(
//                     key: ValueKey(level.id),
//                     model: level,
//                   );
//                 },
//                 itemCount: questionsFiltered.length,
//                 onReorder: _onReorder,
//               ),
//             ),
//             /*
//             Flexible(
//               child: ListView.builder(
//                 itemCount: questionsFiltered.length,
//                 itemBuilder: (context, index) {
//                   final level = questionsFiltered[index];
//                   return AnamneseQuestionObj(
//                     model: level,
//                   );
//                 },
//               ),
//             ),
//             */
//           ],
//         );
//       }, error: (error, stackTrace) {
//         log('Erro em AnamneseQuestionListPage');
//         log('$error');
//         log('$stackTrace');
//         return const Center(
//           child: Text('Erro em AnamneseQuestionListPage'),
//         );
//       }, loading: () {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }),
//     );
//   }

//   void _onReorder(int oldIndex, int newIndex) {
//     print('oldIndex:$oldIndex, newIndex:$newIndex');
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//     });
//     List<AnamneseQuestionModel> classOrderTemp =
//         ref.read(questionsFilteredProvider);
//     AnamneseQuestionModel resourceId = classOrderTemp[oldIndex];
//     classOrderTemp.removeAt(oldIndex);
//     classOrderTemp.insert(newIndex, resourceId);
//     ref.read(questionsFilteredProvider.notifier).set(classOrderTemp);
//   }
// }
