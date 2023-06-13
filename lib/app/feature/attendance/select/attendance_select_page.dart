import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/providers.dart';
import 'attendance_obj.dart';

class AttendanceSelectPage extends ConsumerWidget {
  final bool isSingleValue;

  const AttendanceSelectPage({super.key, this.isSingleValue = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(attendanceSelectProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Selecione ${isSingleValue ? 'um atendimento' : 'alguns atendimentos'}'),
      ),
      body: list.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final level = data[index];
              return AttendanceObj(
                model: level,
                isSingleValue: isSingleValue,
              );
            },
          );
        },
        error: (error, stackTrace) {
          log('Erro em Lista de atendimentos');
          log('$error');
          log('$stackTrace');
          return const Center(
            child: Text('Erro em Lista de atendimentos'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: !isSingleValue,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(ref.watch(attendanceSelectedProvider));
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}
