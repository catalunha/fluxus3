import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search/controller/providers.dart';
import '../search/controller/states.dart';
import 'attendance_obj.dart';

class AttendanceListPage extends ConsumerWidget {
  const AttendanceListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(attendanceListProvider);
    final listFiltered = ref.watch(attendanceFilteredProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${listFiltered.length} Atendimentos'),
      ),
      body: list.when(data: (data) {
        return Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'digite parte do nome para busca',
                ),
                onChanged: (value) {
                  ref.read(attendanceSearchProvider.notifier).set(value);
                },
              ),
            ),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(attendanceColumnSelectedProvider.notifier)
                        .set(AttendanceColumnBySearch.professional);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ref.watch(attendanceColumnSelectedProvider) ==
                                AttendanceColumnBySearch.professional
                            ? Colors.black
                            : null, // Background color
                  ),
                  child: const Text('Prof.'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(attendanceColumnSelectedProvider.notifier)
                        .set(AttendanceColumnBySearch.patient);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ref.watch(attendanceColumnSelectedProvider) ==
                                AttendanceColumnBySearch.patient
                            ? Colors.black
                            : null, // Background color
                  ),
                  child: const Text('Pac.'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(attendanceColumnSelectedProvider.notifier)
                        .set(AttendanceColumnBySearch.authorizationCode);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ref.watch(attendanceColumnSelectedProvider) ==
                                AttendanceColumnBySearch.authorizationCode
                            ? Colors.black
                            : null, // Background color
                  ),
                  child: const Text('Code'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(attendanceColumnSelectedProvider.notifier)
                        .set(AttendanceColumnBySearch.objectId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ref.watch(attendanceColumnSelectedProvider) ==
                                AttendanceColumnBySearch.objectId
                            ? Colors.black
                            : null, // Background color
                  ),
                  child: const Text('Id'),
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: listFiltered.length,
                itemBuilder: (context, index) {
                  final level = listFiltered[index];
                  return AttendanceObj(
                    model: level,
                  );
                },
              ),
            ),
          ],
        );

        // return ListView.builder(
        //   itemCount: data.length,
        //   itemBuilder: (context, index) {
        //     final level = data[index];
        //     return AttendanceObj(
        //       model: level,
        //     );
        //   },
        // );
      }, error: (error, stackTrace) {
        log('Erro em Lista de atendimentos');
        log('$error');
        log('$stackTrace');
        return const Center(
          child: Text('Erro em Lista de atendimentos'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
