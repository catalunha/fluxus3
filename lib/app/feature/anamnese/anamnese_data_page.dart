import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../utils/app_textformfield.dart';
import 'controller/providers.dart';

class AnamneseDataPage extends ConsumerStatefulWidget {
  const AnamneseDataPage({super.key});

  @override
  ConsumerState<AnamneseDataPage> createState() => _AnamneseDataPageState();
}

class _AnamneseDataPageState extends ConsumerState<AnamneseDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final dateFormat = DateFormat('dd/MM/y');

  @override
  void initState() {
    super.initState();
    _nameTec.text = "";
  }

  @override
  void dispose() {
    _nameTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados pessoais'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextFormField(
                      label: '* Nome do adulto entrevistador',
                      controller: _nameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    AppTextFormField(
                      label: '* Email do adulto entrevistador',
                      controller: _nameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    AppTextFormField(
                      label: '* Celular do adulto entrevistador',
                      controller: _nameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    AppTextFormField(
                      label: '* Nome da criança entrevistada',
                      controller: _nameTec,
                      validator: Validatorless.required(
                          'Esta informação é obrigatória'),
                    ),
                    SwitchListTile(
                      title: const Text('É menina ?'),
                      value: ref.watch(childIsFemaleProvider),
                      onChanged: (value) {
                        ref.read(childIsFemaleProvider.notifier).toggle();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Data de nascimento:'),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime.now(),
                              );
                              ref
                                  .watch(childBirthDayProvider.notifier)
                                  .set(newDate);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.date_range),
                                const SizedBox(width: 10),
                                Text(ref.watch(childBirthDayProvider) != null
                                    ? dateFormat.format(
                                        ref.watch(childBirthDayProvider)!)
                                    : "Não informado"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
