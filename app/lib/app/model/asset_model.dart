part of 'data_model.dart';

@JsonSerializable()
class AssetModel extends DataModel {
  const AssetModel({
    required this.icon,
    required this.symbol,
    required this.address,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);

  final String icon;
  final String symbol;
  final String address;

  @override
  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
