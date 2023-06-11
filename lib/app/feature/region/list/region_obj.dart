import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/region_model.dart';
import '../../../routes.dart';
import '../../utils/app_text_title_value.dart';

class RegionObj extends StatelessWidget {
  final RegionModel model;
  const RegionObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextTitleValue(
              title: 'UF: ',
              value: model.uf,
            ),
            AppTextTitleValue(
              title: 'Cidade: ',
              value: model.city,
            ),
            AppTextTitleValue(
              title: 'Nome: ',
              value: model.name,
            ),
            Center(
              child: Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.goNamed(AppPage.regionSave.name, extra: model.id);
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
