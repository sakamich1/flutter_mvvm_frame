// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationEntity _$LocationEntityFromJson(Map<String, dynamic> json) {
  return LocationEntity(
    json['callbackTime'] as String?,
    json['locationTime'] as String?,
    json['locationType'] as String?,
    json['latitude'] as String?,
    json['longitude'] as String?,
    json['accuracy'] as String?,
    json['altitude'] as String?,
    json['bearing'] as String?,
    json['speed'] as String?,
    json['country'] as String?,
    json['province'] as String?,
    json['city'] as String?,
    json['district'] as String?,
    json['street'] as String?,
    json['streetNumber'] as String?,
    json['cityCode'] as String?,
    json['adCode'] as String?,
    json['address'] as String?,
    json['description'] as String?,
  );
}

Map<String, dynamic> _$LocationEntityToJson(LocationEntity instance) =>
    <String, dynamic>{
      'callbackTime': instance.callbackTime,
      'locationTime': instance.locationTime,
      'locationType': instance.locationType,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'bearing': instance.bearing,
      'speed': instance.speed,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'street': instance.street,
      'streetNumber': instance.streetNumber,
      'cityCode': instance.cityCode,
      'adCode': instance.adCode,
      'address': instance.address,
      'description': instance.description,
    };
