import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_model.freezed.dart';

@freezed
abstract class LogModel with _$LogModel {
  factory LogModel({
    String? id,
    required String userProfile,
    required String table,
    required String tableId,
    required String action,
  }) = _LogModel;
}
