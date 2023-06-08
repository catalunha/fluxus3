import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_model.freezed.dart';

@freezed
abstract class RegionModel with _$RegionModel {
  factory RegionModel({
    String? id,
    String? uf,
    String? city,
    String? name,
  }) = _RegionModel;
}
