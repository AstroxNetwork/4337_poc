import 'package:app/generated/json/base/json_convert_content.dart';
import 'package:app/app/model/guardian_model.dart';

GuardianModel $GuardianModelEntityFromJson(Map<String, dynamic> json) {
	final GuardianModel guardianModelEntity = GuardianModel(name: '', address: '');
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		guardianModelEntity.name = name;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		guardianModelEntity.address = address;
	}
	final String? addedDate = jsonConvert.convert<String>(json['addedDate']);
	if (addedDate != null) {
		guardianModelEntity.addedDate = addedDate;
	}
	return guardianModelEntity;
}

Map<String, dynamic> $GuardianModelEntityToJson(GuardianModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['address'] = entity.address;
	data['addedDate'] = entity.addedDate;
	return data;
}