import 'package:html/parser.dart';
import 'package:html/dom.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:chaldea_domain/entities/home.dart';

part 'home_entity.g.dart';
part 'home_entity.e.dart';
part 'home_entity.domain.dart';

@JsonSerializable(explicitToJson: true)
class HomeEntity {
  /// 活动
  final HomeBox<List<HomePageSection>> events;

  /// 卡池
  final HomeBox<List<HomePageSection>> summons;

  /// 新增
  final HomeBox<List<HomePageSection>> newCards;

  /// 周常
  final HomeBox<WeeklyMissionContainer> weeklyMission;

  final HomeBox<WeeklyMissionContainer> nextWeeklyMission;

  const HomeEntity(
      {this.events,
      this.summons,
      this.newCards,
      this.weeklyMission,
      this.nextWeeklyMission});

  // Data mapper
  factory HomeEntity.fromHTML(String html) => _$HomeEntityFromHTML(html);
  factory HomeEntity.fromJson(Map<String, dynamic> json) =>
      _$HomeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$HomeEntityToJson(this);

  // Domain mapper
  Home toCNDomain() => _$HomeEntityToCNDomain(this);
  Home toJPDomain() => _$HomeEntityToJPDomain(this);
}

@JsonSerializable(explicitToJson: true)
class HomeBox<T> {
  @JsonKey(fromJson: _containerFromJson, toJson: _containerToJson)
  final T cnContainer;
  @JsonKey(fromJson: _containerFromJson, toJson: _containerToJson)
  final T jpContainer;

  const HomeBox({this.cnContainer, this.jpContainer});

  factory HomeBox.fromJson(Map<String, dynamic> json) =>
      _$HomeBoxFromJson(json);
  Map<String, dynamic> toJson() => _$HomeBoxToJson(this);

  static T _containerFromJson<T>(Object json) {
    if (json is Map<String, dynamic>) {
      return WeeklyMissionContainer.fromJson(json) as T;
    }
    if (json is List) {
      return json
          .map((e) => HomePageSection.fromJson(e as Map<String, dynamic>))
          .toList(growable: false) as T;
    }
    if (json == null) {
      return null;
    }
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }

  static dynamic _containerToJson<T>(T object) {
    if (object is List<HomePageSection>) {
      return object.map((e) => e.toJson()).toList(growable: false);
    }
    if (object is WeeklyMissionContainer) {
      return object.toJson();
    }
    if (object == null) {
      return null;
    }

    throw ArgumentError.value(
      object,
      '$T',
      'Cannot convert the provided data.',
    );
  }
}

@JsonSerializable(explicitToJson: true)
class HomePageSection {
  /// eg: 当前主要XX（1个）、当前XX（2个）、即将开放XX（0个）、未来开放XX（2个）、近期暂无XX.
  final String subtitle;

  final List<HomePageImage> items;

  const HomePageSection({this.subtitle, this.items});

  factory HomePageSection.fromJson(Map<String, dynamic> json) =>
      _$HomePageSectionFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageSectionToJson(this);
}

@JsonSerializable()
class HomePageImage {
  final String title;
  final String imageURL;
  final String href;

  const HomePageImage({this.title, this.imageURL, this.href});

  factory HomePageImage.fromJson(Map<String, dynamic> json) =>
      _$HomePageImageFromJson(json);
  Map<String, dynamic> toJson() => _$HomePageImageToJson(this);
}

@JsonSerializable()
class WeeklyMissionContainer {
  final String tabName;
  final String date;
  final List<String> tasks;

  const WeeklyMissionContainer({this.tabName, this.date, this.tasks});

  factory WeeklyMissionContainer.fromJson(Map<String, dynamic> json) =>
      _$WeeklyMissionContainerFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyMissionContainerToJson(this);
}
