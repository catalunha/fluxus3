import 'package:flutter/material.dart';
import 'package:fluxus3/app/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/user_profile_model.dart';
import '../../utils/app_launch.dart';
import '../../utils/app_text_title_value.dart';

class UserProfileObj extends StatelessWidget {
  final UserProfileModel model;
  const UserProfileObj({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              model.photo != null && model.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        model.photo!,
                        height: 70,
                        width: 70,
                      ),
                    )
                  : const SizedBox(
                      height: 70,
                      width: 70,
                      child: Icon(Icons.person_outline),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppTextTitleValue(
                    //   title: 'Id: ',
                    //   value: model.id,
                    // ),
                    AppTextTitleValue(
                      title: 'Email: ',
                      value: model.userName,
                    ),
                    AppTextTitleValue(
                      title: 'Nome curto: ',
                      value: '${model.nickname}',
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.goNamed(AppPage.userProfileAccess.name,
                                pathParameters: {"id": model.id});
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.goNamed(AppPage.userProfileView.name,
                                pathParameters: {"id": model.id});
                          },
                          icon: const Icon(
                            Icons.assignment_ind_outlined,
                          ),
                        ),
                        if (model.phone != null && model.phone!.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              AppLaunch.launchWhatsApp(
                                  phone: model.phone!, message: 'Olá');
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
