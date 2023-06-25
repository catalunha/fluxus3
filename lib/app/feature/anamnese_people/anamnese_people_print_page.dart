import 'dart:async';
import 'dart:typed_data';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/models/anamnese_answer_model.dart';
import '../../core/models/anamnese_people_model.dart';

class AnamnesePeoplePrintPage extends StatelessWidget {
  final AnamnesePeopleModel people;
  final List<AnamneseAnswerModel> answerList;
  const AnamnesePeoplePrintPage({
    Key? key,
    required this.people,
    required this.answerList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Anamnese'),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        pdfFileName: 'AnamnesePeople',
        build: (format) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd/MM/y');
    final childBirthDate =
        AgeCalculator.age(people.childBirthDate, today: DateTime.now());
    final createdAt =
        AgeCalculator.age(people.createdAt!, today: DateTime.now());
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginTop: 1.0 * PdfPageFormat.cm,
          marginLeft: 1.0 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 1.0 * PdfPageFormat.cm,
        ),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        footer: (pw.Context context) => footerPage(context),
        build: (pw.Context context) => <pw.Widget>[
          pw.Header(
            level: 1,
            child: pw.Text('Relatório de Anamnese'),
          ),
          pw.Text(
              'Data da Entrevista: ${dateFormat.format(people.createdAt!)} - ${createdAt.years} a, ${createdAt.months} m, ${createdAt.days} d'),
          pw.Text('Dados do adulto'),
          pw.Text('Nome: ${people.adultName}'),
          pw.Text('Telefone: ${people.adultPhone}'),
          pw.Text('Dados da criança'),
          pw.Text('Nome: ${people.childName}'),
          pw.Text('A criança é: ${people.childIsFemale ? "MeninA" : "MeninO"}'),
          pw.Text(
              'Nascimento: ${dateFormat.format(people.childBirthDate)} - ${childBirthDate.years} a, ${childBirthDate.months} m, ${childBirthDate.days} d'),
          ...body(),
        ],
      ),
    );

    return await pdf.save();
  }

  body() {
    List<pw.Widget> lineList = [];
    for (var model in answerList) {
      lineList.add(userBody(model));
    }

    return lineList;
  }

  userBody(AnamneseAnswerModel model) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          pw.SizedBox(width: 10),
          pw.Expanded(
              child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('answer: ${model.answerText}'),
            ],
          ))
        ]),
        // pw.Divider(),
      ],
    );
  }

  footerPage(context) {
    final dateFormat = DateFormat('dd/MM/y HH:mm');

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
      decoration: const pw.BoxDecoration(
          border: pw.Border(
              top: pw.BorderSide(width: 1.0, color: PdfColors.black))),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Fluxus - ${dateFormat.format(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            'Pág.: ${context.pageNumber} de ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
