// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      date: DateTime.parse(json['date'] as String),
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      address: json['address'] as String,
      count: (json['count'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'address': instance.address,
      'count': instance.count,
      'currency': instance.currency,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.receive: 'receive',
  ActivityType.send: 'send',
};

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) => AssetModel(
      icon: json['icon'] as String,
      symbol: json['symbol'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$AssetModelToJson(AssetModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'symbol': instance.symbol,
      'address': instance.address,
    };

GuardianModel _$GuardianModelFromJson(Map<String, dynamic> json) =>
    GuardianModel(
      name: json['name'] as String,
      address: json['address'] as String,
      addedDate: json['addedDate'] as String?,
    );

Map<String, dynamic> _$GuardianModelToJson(GuardianModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'addedDate': instance.addedDate,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'address': instance.address,
    };
