import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxus3/app/routes.dart';
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
          'Olá ${auth.user?.userProfile?.name ?? auth.user?.email}',
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
                title: 'Eventos',
                // icon: Icons.event_available,
                icon: Icons.local_convenience_store_rounded,
                color: Colors.black87,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.eventAdd.name);
                    },
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.eventList.name);
                    },
                    icon: const Icon(Icons.list),
                  )
                ],
              ),
              const Divider(
                height: 10,
              ),
              HomeModule(
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
                title: 'Horários',
                icon: Icons.timer_sharp,
                color: Colors.black,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(AppPage.hourList.name);
                    },
                    icon: const Icon(Icons.list),
                  ),
                ],
              ),
              HomeModule(
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
            ],
          ),
        ),
      ),
    );
  }
}
