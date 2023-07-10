import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/authentication/riverpod/auth_prov.dart';
import 'core/authentication/riverpod/auth_state.dart';
import 'feature/anamnese_group/list/anamnese_group_list_page.dart';
import 'feature/anamnese_group/save/anamnese_group_save_page.dart';
import 'feature/anamnese_people/anamnese_people_list_page.dart';
import 'feature/anamnese_people/anamnese_people_answer_list_page.dart';
import 'feature/anamnese_question/list/anamnese_question_list_page.dart';
import 'feature/anamnese_question/save/anamnese_question_save_page.dart';
import 'feature/attendance/add/attendance_add_page.dart';
import 'feature/attendance/edit/attendance_edit_page.dart';
import 'feature/attendance/list/attendance_list_page.dart';
import 'feature/attendance/search/attendance_search_page.dart';
import 'feature/error/error_page.dart';
import 'feature/event/list/event_list_page.dart';
import 'feature/event/save/event_save_page.dart';
import 'feature/event/search/event_search_page.dart';
import 'feature/expertise/list/expertise_list_page.dart';
import 'feature/expertise/save/expertise_save_page.dart';
import 'feature/healthplantype/list/healthplantype_list_page.dart';
import 'feature/healthplantype/save/healthplantype_save_page.dart';
import 'feature/office/list/office_list_page.dart';
import 'feature/office/save/office_save_page.dart';
import 'feature/patient/list/patient_list_page.dart';
import 'feature/patient/save/patient_save_page.dart';
import 'feature/patient/view/patient_view_page.dart';
import 'feature/procedure/list/procedure_list_page.dart';
import 'feature/procedure/save/procedure_save_page.dart';
import 'feature/region/list/region_list_page.dart';
import 'feature/region/save/region_save_page.dart';
import 'feature/room/list/room_list_page.dart';
import 'feature/room/save/room_save_page.dart';
import 'feature/schedule/list/schedule_page.dart';
import 'feature/shared/list/shared_list_page.dart';
import 'feature/shared/patient/list/shared_patient_list_page.dart';
import 'feature/shared/save/shared_save_page.dart';
import 'feature/splash/splash_page.dart';
import 'feature/status/list/status_list_page.dart';
import 'feature/status/save/status_save_page.dart';
import 'feature/user/login/user_login_page.dart';
import 'feature/user/register/email/user_register_email.page.dart';
import 'feature/user_profile/access/user_profile_access_page.dart';
import 'feature/user_profile/list/user_profile_list_page.dart';
import 'feature/user_profile/save/user_profile_edit_page.dart';
import 'feature/home/home_page.dart';
import 'feature/user_profile/view/user_profile_view_page.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigator =
//     GlobalKey(debugLabel: 'shell');

final goRouterProv = Provider<GoRouter>(
  (ref) {
    final authChNotProvIR = ref.watch(authChNotProvider);
    return GoRouter(
      navigatorKey: _rootNavigator,
      debugLogDiagnostics: true,
      initialLocation: AppPage.splash.path,
      refreshListenable: authChNotProvIR,
      redirect: (context, state) {
        final authStatus = authChNotProvIR.status;
        // //log('+++ redirect');
        // //log('state.location: ${state.location}');
        // //log('authStatusStProvIR: $authStatus');
        if (authStatus == AuthStatus.unauthenticated &&
            state.location != '/login/registerEmail') {
          // //log('--- redirected 1 to login');
          return AppPage.login.path;
        }
        if (authStatus == AuthStatus.authenticated &&
            (state.location == AppPage.login.path ||
                state.location == AppPage.splash.path)) {
          // //log('--- redirected 2 to home');
          return AppPage.home.path;
        }
        // //log('--- redirected 3 to ${state.location}');

        return null;
      },
      routes: [
        GoRoute(
          path: AppPage.splash.path,
          name: AppPage.splash.name,
          builder: (context, state) => SplashPage(
            key: state.pageKey,
          ),
        ),
        GoRoute(
          path: AppPage.login.path,
          name: AppPage.login.name,
          builder: (context, state) => UserLoginPage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: AppPage.registerEmail.path,
              name: AppPage.registerEmail.name,
              builder: (context, state) => UserRegisterEmailPage(
                key: state.pageKey,
              ),
            ),
          ],
        ),
        GoRoute(
          path: AppPage.home.path,
          name: AppPage.home.name,
          builder: (context, state) => HomePage(
            key: state.pageKey,
          ),
          routes: [
            GoRoute(
              path: AppPage.userProfileSave.path,
              name: AppPage.userProfileSave.name,
              builder: (context, state) {
                return UserProfileEditPage(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.userProfileList.path,
              name: AppPage.userProfileList.name,
              builder: (context, state) {
                return UserProfileListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.userProfileView.path,
                  name: AppPage.userProfileView.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] as String;
                    return UserProfileViewPage(
                      key: state.pageKey,
                      userProfileId: id,
                    );
                  },
                ),
                GoRoute(
                  path: AppPage.userProfileAccess.path,
                  name: AppPage.userProfileAccess.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] as String;
                    return UserProfileAccessPage(
                      key: state.pageKey,
                      userProfileId: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.officeList.path,
              name: AppPage.officeList.name,
              builder: (context, state) {
                return OfficeListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.officeSave.path,
                  name: AppPage.officeSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return OfficeSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.procedureList.path,
              name: AppPage.procedureList.name,
              builder: (context, state) {
                return ProcedureListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.procedureSave.path,
                  name: AppPage.procedureSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return ProcedureSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.expertiseList.path,
              name: AppPage.expertiseList.name,
              builder: (context, state) {
                return ExpertiseListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.expertiseSave.path,
                  name: AppPage.expertiseSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return ExpertiseSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.regionList.path,
              name: AppPage.regionList.name,
              builder: (context, state) {
                return RegionListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.regionSave.path,
                  name: AppPage.regionSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return RegionSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.roomList.path,
              name: AppPage.roomList.name,
              builder: (context, state) {
                return RoomListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.roomSave.path,
                  name: AppPage.roomSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return RoomSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.statusList.path,
              name: AppPage.statusList.name,
              builder: (context, state) {
                return StatusListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.statusSave.path,
                  name: AppPage.statusSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return StatusSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.healthPlanTypeList.path,
              name: AppPage.healthPlanTypeList.name,
              builder: (context, state) {
                return HealthPlanTypeListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.healthPlanTypeSave.path,
                  name: AppPage.healthPlanTypeSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return HealthPlanTypeSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.patientList.path,
              name: AppPage.patientList.name,
              builder: (context, state) {
                return PatientListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.patientSave.path,
                  name: AppPage.patientSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return PatientSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
                GoRoute(
                  path: AppPage.patientView.path,
                  name: AppPage.patientView.name,
                  builder: (context, state) {
                    final id = state.extra as String;
                    return PatientViewPage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.attendanceAdd.path,
              name: AppPage.attendanceAdd.name,
              builder: (context, state) {
                final id = state.extra as String?;
                return AttendanceAddPage(
                  key: state.pageKey,
                  id: id,
                );
              },
            ),
            GoRoute(
              path: AppPage.attendanceSearch.path,
              name: AppPage.attendanceSearch.name,
              builder: (context, state) {
                return AttendanceSearchPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.attendanceList.path,
                  name: AppPage.attendanceList.name,
                  builder: (context, state) {
                    return AttendanceListPage(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppPage.attendanceEdit.path,
                      name: AppPage.attendanceEdit.name,
                      builder: (context, state) {
                        final id = state.extra as String?;
                        return AttendanceEditPage(
                          key: state.pageKey,
                          id: id,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
                path: AppPage.eventSearch.path,
                name: AppPage.eventSearch.name,
                builder: (context, state) {
                  return EventSearchPage(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                    path: AppPage.eventList.path,
                    name: AppPage.eventList.name,
                    builder: (context, state) {
                      return EventListPage(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AppPage.eventEdit.path,
                        name: AppPage.eventEdit.name,
                        builder: (context, state) {
                          final id = state.extra as String?;
                          return EventSavePage(
                            key: state.pageKey,
                            id: id,
                          );
                        },
                      ),
                    ],
                  ),
                ]),
            GoRoute(
              path: AppPage.eventAdd.path,
              name: AppPage.eventAdd.name,
              builder: (context, state) {
                return EventSavePage(
                  id: null,
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.schedule.path,
              name: AppPage.schedule.name,
              builder: (context, state) {
                return SchedulePage(
                  key: state.pageKey,
                );
              },
            ),
            GoRoute(
              path: AppPage.anamneseGroupList.path,
              name: AppPage.anamneseGroupList.name,
              builder: (context, state) {
                return AnamneseGroupListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.anamneseGroupSave.path,
                  name: AppPage.anamneseGroupSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return AnamneseGroupSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.anamneseQuestionList.path,
              name: AppPage.anamneseQuestionList.name,
              builder: (context, state) {
                return AnamneseQuestionListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.anamneseQuestionSave.path,
                  name: AppPage.anamneseQuestionSave.name,
                  builder: (context, state) {
                    final id = state.extra as String?;
                    return AnamneseQuestionSavePage(
                      key: state.pageKey,
                      id: id,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.anamnesePeopleList.path,
              name: AppPage.anamnesePeopleList.name,
              builder: (context, state) {
                return AnamnesePeopleListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.anamnesePeopleAnswerList.path,
                  name: AppPage.anamnesePeopleAnswerList.name,
                  builder: (context, state) {
                    return AnamnesePeopleAnswerListPage(
                      key: state.pageKey,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppPage.sharedPatientList.path,
              name: AppPage.sharedPatientList.name,
              builder: (context, state) {
                return SharedPatientListPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: AppPage.sharedList.path,
                  name: AppPage.sharedList.name,
                  builder: (context, state) {
                    return SharedListPage(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppPage.sharedSave.path,
                      name: AppPage.sharedSave.name,
                      builder: (context, state) {
                        final id = state.extra as String?;
                        return SharedSavePage(
                          key: state.pageKey,
                          id: id,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(
        key: state.pageKey,
        errorMsg: state.error.toString(),
      ),
    );
  },
);

/*
/splash
/login
/login/registerEmail
/home
/home/userProfileSave
/home/userProfileList
/home/userProfileList/userProfileView/:id
/home/userProfileList/userProfileAccess/:id
/home/officeList
/home/officeList/officeSave
/home/procedureList
/home/procedureList/procedureSave

*/

enum AppPage {
  splash('/', 'splash'),
  login('/login', 'login'),
  registerEmail('registerEmail', 'registerEmail'),

  home('/home', 'home'),
  userProfileSave('userProfileSave', 'userProfileSave'),
  userProfileList('userProfileList', 'userProfileList'),
  userProfileView('userProfileView/:id', 'userProfileView'),
  userProfileAccess('userProfileAccess/:id', 'userProfileAccess'),
  officeList('officeList', 'officeList'),
  officeSave('officeSave', 'officeSave'),
  procedureList('procedureList', 'procedureList'),
  procedureSave('procedureSave', 'procedureSave'),
  expertiseList('expertiseList', 'expertiseList'),
  expertiseSave('expertiseSave', 'expertiseSave'),
  regionList('regionList', 'regionList'),
  regionSave('regionSave', 'regionSave'),
  roomList('roomList', 'roomList'),
  roomSave('roomSave', 'roomSave'),
  statusList('statusList', 'statusList'),
  statusSave('statusSave', 'statusSave'),
  healthPlanTypeList('healthPlanTypeList', 'healthPlanTypeList'),
  healthPlanTypeSave('healthPlanTypeSave', 'healthPlanTypeSave'),
  patientList('patientList', 'patientList'),
  patientSave('patientSave', 'patientSave'),
  patientView('patientView', 'patientView'),
  attendanceSearch('attendanceSearch', 'attendanceSearch'),
  attendanceList('attendanceList', 'attendanceList'),
  attendanceAdd('attendanceAdd', 'attendanceAdd'),
  attendanceEdit('attendanceEdit', 'attendanceEdit'),
  eventSearch('eventSearch', 'eventSearch'),
  eventList('eventList', 'eventList'),
  eventEdit('eventEdit', 'eventEdit'),
  eventAdd('eventAdd', 'eventAdd'),
  schedule('schedule', 'schedule'),
  anamneseGroupList('anamneseGroupList', 'anamneseGroupList'),
  anamneseGroupSave('anamneseGroupSave', 'anamneseGroupSave'),
  anamneseQuestionList('anamneseQuestionList', 'anamneseQuestionList'),
  anamneseQuestionSave('anamneseQuestionSave', 'anamneseQuestionSave'),
  anamnesePeopleList('anamnesePeopleList', 'anamnesePeopleList'),
  anamnesePeopleAnswerList(
      'anamnesePeopleAnswerList', 'anamnesePeopleAnswerList'),
  sharedPatientList('sharedPatientList', 'sharedPatientList'),
  sharedList('sharedList', 'sharedList'),
  sharedSave('sharedSave', 'sharedSave');

  final String path;
  final String name;
  const AppPage(this.path, this.name);
}
