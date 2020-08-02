// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeEntity _$HomeEntityFromJson(Map<String, dynamic> json) {
  return HomeEntity(
    events: json['events'] == null
        ? null
        : HomeBox.fromJson(json['events'] as Map<String, dynamic>),
    summons: json['summons'] == null
        ? null
        : HomeBox.fromJson(json['summons'] as Map<String, dynamic>),
    newCards: json['newCards'] == null
        ? null
        : HomeBox.fromJson(json['newCards'] as Map<String, dynamic>),
    weeklyMission: json['weeklyMission'] == null
        ? null
        : HomeBox.fromJson(json['weeklyMission'] as Map<String, dynamic>),
    nextWeeklyMission: json['nextWeeklyMission'] == null
        ? null
        : HomeBox.fromJson(json['nextWeeklyMission'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeEntityToJson(HomeEntity instance) =>
    <String, dynamic>{
      'events': instance.events?.toJson(),
      'summons': instance.summons?.toJson(),
      'newCards': instance.newCards?.toJson(),
      'weeklyMission': instance.weeklyMission?.toJson(),
      'nextWeeklyMission': instance.nextWeeklyMission?.toJson(),
    };

HomeBox<T> _$HomeBoxFromJson<T>(Map<String, dynamic> json) {
  return HomeBox<T>(
    cnContainer: HomeBox._containerFromJson(json['cnContainer']),
    jpContainer: HomeBox._containerFromJson(json['jpContainer']),
  );
}

Map<String, dynamic> _$HomeBoxToJson<T>(HomeBox<T> instance) =>
    <String, dynamic>{
      'cnContainer': HomeBox._containerToJson(instance.cnContainer),
      'jpContainer': HomeBox._containerToJson(instance.jpContainer),
    };

HomePageSection _$HomePageSectionFromJson(Map<String, dynamic> json) {
  return HomePageSection(
    subtitle: json['subtitle'] as String,
    items: (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : HomePageImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomePageSectionToJson(HomePageSection instance) =>
    <String, dynamic>{
      'subtitle': instance.subtitle,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };

HomePageImage _$HomePageImageFromJson(Map<String, dynamic> json) {
  return HomePageImage(
    title: json['title'] as String,
    imageURL: json['imageURL'] as String,
    href: json['href'] as String,
  );
}

Map<String, dynamic> _$HomePageImageToJson(HomePageImage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageURL': instance.imageURL,
      'href': instance.href,
    };

WeeklyMissionContainer _$WeeklyMissionContainerFromJson(
    Map<String, dynamic> json) {
  return WeeklyMissionContainer(
    tabName: json['tabName'] as String,
    date: json['date'] as String,
    tasks: (json['tasks'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$WeeklyMissionContainerToJson(
        WeeklyMissionContainer instance) =>
    <String, dynamic>{
      'tabName': instance.tabName,
      'date': instance.date,
      'tasks': instance.tasks,
    };
