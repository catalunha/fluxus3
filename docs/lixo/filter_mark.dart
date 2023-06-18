// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'controller/providers.dart';
// import 'controller/states.dart';

// class FilterMark extends ConsumerWidget {
//   final String title;
//   final PatientFilterStatus status;
//   const FilterMark({
//     super.key,
//     required this.title,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: ref.watch(patientFilteredByProvider) == status
//             ? const MaterialStatePropertyAll<Color>(Colors.black)
//             : null,
//       ),
//       onPressed: () {
//         ref.read(patientFilteredByProvider.notifier).set(status);
//       },
//       child: Text(title),
//     );
//   }
// }
