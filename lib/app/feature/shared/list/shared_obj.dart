import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/shared_model.dart';

class SharedObj extends StatelessWidget {
  final SharedModel model;
  const SharedObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.professional!.name}'),
            Text(dateFormat.format(model.createdAt!)),
            Text('${model.history}'),
          ],
        ),
      ),
    );
  }
}
