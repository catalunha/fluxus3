import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/office_model.dart';
import '../../../routes.dart';

class OfficeObj extends StatelessWidget {
  final OfficeModel model;
  const OfficeObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('${model.name}'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.goNamed(AppPage.officeSave.name, extra: model.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
