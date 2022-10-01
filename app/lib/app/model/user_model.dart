import 'package:app/app/model/asset_model.dart';

class UserModel {
  String name;
  String avatar;
  String address;
  List<AssetModel> assets;

  UserModel({
    required this.name,
    required this.avatar,
    required this.address,
    required this.assets,
  });

// todo: toJson
// todo: fromJson
// todo: toString
}
