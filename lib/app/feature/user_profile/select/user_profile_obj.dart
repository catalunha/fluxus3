import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user_profile_model.dart';
import 'controller/providers.dart';

class UserProfileObj extends ConsumerWidget {
  final UserProfileModel model;
  final bool isSingleValue;

  const UserProfileObj(
      {Key? key, required this.model, this.isSingleValue = true})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color? color;
    final userProfileSelected = ref.watch(userProfileSelectedProvider);
    if (userProfileSelected.contains(model)) {
      color = Colors.green;
    }
    return Card(
      child: ListTile(
        title: Text('${model.nickname}'),
        // subtitle: Text('${model.nickname}'),
        tileColor: color,
        onTap: () {
          if (isSingleValue) {
            Navigator.of(context).pop(model);
          } else {
            ref.watch(userProfileSelectedProvider.notifier).toggle(model);
          }
        },
      ),
    );
  }
}
