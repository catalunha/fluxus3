import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../routes.dart';
import 'controller/providers.dart';

class SharedPatientObj extends ConsumerWidget {
  final PatientModel model;
  const SharedPatientObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Card(
    //   child: ListTile(
    //     title: Text('${model.name}'),
    //     onTap: () {
    //       ref.read(sharedPatientSelectedProvider.notifier).set(model);
    //       // context.goNamed(AppPage.sharedAdd.name, extra: null);
    //       context.goNamed(AppPage.sharedList.name);
    //     },
    //   ),
    // );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.name}'),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // ref
                      //     .read(sharedPatientSelectedProvider.notifier)
                      //     .set(model);

                      // context.goNamed(AppPage.sharedList.name);
                    },
                    icon: const Icon(Icons.block)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);

                      context.goNamed(AppPage.sharedList.name);
                    },
                    icon: const Icon(Icons.medical_information)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);

                      context.goNamed(AppPage.sharedAdd.name, extra: null);
                    },
                    icon: const Icon(Icons.room_service_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }
}
