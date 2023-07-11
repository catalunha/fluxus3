import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routes.dart';
import 'package:go_router/go_router.dart';

import '../../core/authentication/riverpod/auth_prov.dart';
import '../utils/app_mixin_loader.dart';
import '../utils/app_mixin_messages.dart';
import 'home_module.dart';
import 'home_popmenu.dart';

class HomePage extends ConsumerWidget with Loader, Messages {
  HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authChNotProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá ${auth.user?.userProfile?.nickname ?? "Atualize seu nome curto"}',
        ),
        actions: const [
          HomePopMenu(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              HomeModule(
                access: const ['sec'],
                title: 'Pacientes',
                icon: Icons.personal_injury,
                color: Colors.black87,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.patientList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     context.goNamed(AppPage.patientList.name);
                  //   },
                  //   icon: const Icon(Icons.search),
                  // )
                ],
              ),
              HomeModule(
                access: const ['sec'],
                title: 'Atendimentos',
                icon: Icons.book,
                color: Colors.black87,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.attendanceAdd.name);
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.attendanceSearch.name);
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              HomeModule(
                access: const ['sec'],
                title: 'Eventos',
                icon: Icons.maps_home_work_rounded,
                color: Colors.black87,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.eventSave.name);
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.eventSearch.name);
                    },
                    icon: const Icon(Icons.search),
                  )
                ],
              ),
              HomeModule(
                access: const ['sec'],
                title: 'Agenda',
                icon: Icons.calendar_month,
                color: Colors.black87,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.schedule.name);
                    },
                    icon: const Icon(Icons.view_timeline_sharp),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin', 'sec', 'prof'],
                title: 'Prontuário',
                icon: Icons.folder_shared_outlined,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.sharedPatientList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Gerenciar Usuários',
                icon: Icons.people,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.userProfileList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Cargos',
                icon: Icons.power_input_sharp,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.officeList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Procedimentos',
                icon: Icons.construction_sharp,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.procedureList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Especialidades',
                icon: Icons.folder_special,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.expertiseList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['sec'],
                title: 'Região',
                icon: Icons.bubble_chart_outlined,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.regionList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Sala',
                icon: Icons.house_sharp,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.roomList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Status',
                icon: Icons.start,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.statusList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Tipos de Planos de Saúde',
                icon: Icons.credit_card_rounded,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.healthPlanTypeList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Anamnese - Grupos',
                icon: Icons.question_answer,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.anamneseGroupList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['admin'],
                title: 'Anamnese - Perguntas',
                icon: Icons.question_mark,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.anamneseQuestionList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
                access: const ['prof'],
                title: 'Anamnese - Respostas',
                icon: Icons.receipt_long,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.anamnesePeopleList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
