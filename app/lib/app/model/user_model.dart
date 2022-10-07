part of 'data_model.dart';

@JsonSerializable()
class UserModel extends DataModel {
  const UserModel({
    required this.name,
    required this.avatar,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  final String name;
  final String avatar;
  final String address;

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
