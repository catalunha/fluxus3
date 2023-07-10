import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/shared_model.dart';
import '../../utils/app_launch.dart';

class SharedObj extends StatelessWidget {
  final SharedModel model;
  const SharedObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y HH:mm');
    final createdAt =
        AgeCalculator.age(model.createdAt!, today: DateTime.now());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flexible(child: Text('${model.description}')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${model.professional!.name}'),
                    Text(
                        '${dateFormat.format(model.createdAt!)} - ${createdAt.years} a, ${createdAt.months} m, ${createdAt.days} d'),
                  ],
                ),
                if (model.document != null)
                  IconButton(
                    onPressed: () {
                      AppLaunch.launchLink(model.document!);
                    },
                    icon: const Icon(Icons.file_download),
                  ),
              ],
            ),

            Visibility(
              visible: model.isPublic,
              child: const Divider(
                color: Colors.green,
              ),
            ),
            Visibility(
              visible: !model.isPublic,
              child: const Divider(),
            ),
            Text('${model.description}'),
            // IconButton(
            //   onPressed: () {
            //     context.goNamed(AppPage.sharedSave.name, extra: model.id);
            //   },
            //   icon: const Icon(Icons.edit),
            // ),
          ],
        ),
      ),
    );
  }
}
