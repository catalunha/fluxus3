import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/patient_model.dart';
import '../../../../core/utils/allowed_access.dart';
import '../../../../routes.dart';
import '../../list/controller/providers.dart';
import '../../list/controller/states.dart';
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
                if (ref
                    .read(allowedAccessProvider.notifier)
                    .consultFor(['admin']))
                  IconButton(
                    icon: const Icon(Icons.admin_panel_settings),
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);
                      ref
                          .read(sharedListByStatusStateProvider.notifier)
                          .set(SharedListByStatus.admin);

                      context.goNamed(AppPage.sharedList.name);
                    },
                  ),
                Visibility(
                  visible: ref
                      .read(allowedAccessProvider.notifier)
                      .consultFor(['prof']),
                  child: IconButton(
                    icon: const Icon(Icons.block),
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);
                      ref
                          .read(sharedListByStatusStateProvider.notifier)
                          .set(SharedListByStatus.private);

                      context.goNamed(AppPage.sharedList.name);
                    },
                  ),
                ),
                if (ref
                    .read(allowedAccessProvider.notifier)
                    .consultFor(['prof']))
                  IconButton(
                    icon: const Icon(Icons.medical_information),
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);
                      ref
                          .read(sharedListByStatusStateProvider.notifier)
                          .set(SharedListByStatus.public);

                      context.goNamed(AppPage.sharedList.name);
                    },
                  ),
                Visibility(
                  visible: ref
                      .read(allowedAccessProvider.notifier)
                      .consultFor(['sec']),
                  child: IconButton(
                    icon: const Icon(Icons.room_service_outlined),
                    onPressed: () {
                      ref
                          .read(sharedPatientSelectedProvider.notifier)
                          .set(model);
                      ref
                          .read(sharedListByStatusStateProvider.notifier)
                          .set(SharedListByStatus.byOffice);

                      context.goNamed(AppPage.sharedList.name);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
