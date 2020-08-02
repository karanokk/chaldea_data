part of 'home_entity.dart';

HomeEntity _$HomeEntityFromHTML(String html) {
  final root = parse(html);

  final events = HomeBox(
      cnContainer: _parseContainer(root, _Source.cn, _Container.homeEvents),
      jpContainer: _parseContainer(root, _Source.jp, _Container.homeEvents));
  final summons = HomeBox(
      cnContainer: _parseContainer(root, _Source.cn, _Container.homeSummons),
      jpContainer: _parseContainer(root, _Source.jp, _Container.homeSummons));
  final newCards = HomeBox(
      cnContainer: _parseContainer(root, _Source.cn, _Container.newCards),
      jpContainer: _parseContainer(root, _Source.jp, _Container.newCards));
  final weeklyMission = HomeBox(
      cnContainer:
          _parseWeeklyMission(root, _Source.cn, _Container.weeklyMission),
      jpContainer:
          _parseWeeklyMission(root, _Source.jp, _Container.weeklyMission));
  final nextWeeklyMission = HomeBox(
      cnContainer:
          _parseWeeklyMission(root, _Source.next, _Container.weeklyMission),
      jpContainer: null);

  return HomeEntity(
      events: events,
      summons: summons,
      newCards: newCards,
      weeklyMission: weeklyMission,
      nextWeeklyMission: nextWeeklyMission);
}

enum _Source { cn, jp, next }

enum _Container { homeEvents, homeSummons, newCards, weeklyMission }

extension on _Container {
  // ignore: missing_return
  String get subtitleClassName {
    switch (this) {
      case _Container.homeEvents:
        return 'home-events-subtitle';
        break;
      case _Container.homeSummons:
        return 'home-summons-subtitle';
        break;
      case _Container.newCards:
        return 'new-cards-subtitle';
        break;
      case _Container.weeklyMission:
        return 'weekly-mission-date';
        break;
    }
  }

  // ignore: missing_return
  String get itemClassName {
    switch (this) {
      case _Container.homeEvents:
        return 'home-events-pageimages';
        break;
      case _Container.homeSummons:
        return 'home-summons-pageimages';
        break;
      case _Container.newCards:
        return 'new-cards-icons';
        break;
      case _Container.weeklyMission:
        return 'weekly-mission-desc';
        break;
    }
  }

  // ignore: missing_return
  String id(_Source source) {
    final sourceStr = source.toString().split('.').last;
    switch (this) {
      case _Container.homeEvents:
        return 'home-events-container-$sourceStr';
        break;
      case _Container.homeSummons:
        return 'home-summons-container-$sourceStr';
        break;
      case _Container.newCards:
        return 'new-cards-container-$sourceStr';
        break;
      case _Container.weeklyMission:
        return 'weekly-mission-container-$sourceStr';
        break;
    }
  }

  String get itemANodeSelector {
    switch (this) {
      case _Container.homeEvents:
        return 'span.nomobile > a';
        break;
      case _Container.homeSummons:
        return 'div > a';
        break;
      case _Container.newCards:
        return 'div > div:not(.enhancement-icon) > a';
        break;
      default:
        throw StateError('Impossible case');
    }
  }

  String get itemTitleNodeSelector {
    switch (this) {
      case _Container.homeEvents:
        return 'span.nomobile > span';
        break;
      case _Container.homeSummons:
        return 'font';
        break;
      case _Container.newCards:
        return 'div > div:not(.enhancement-icon) > a';
        break;
      default:
        throw StateError('message');
    }
  }
}

List<HomePageSection> _parseContainer(
    Document root, _Source source, _Container container) {
  final sections = <HomePageSection>[];
  const domain = 'https://fgo.wiki';
  String currentSubtitle;
  final id = container.id(source);
  final subtitleClassName = container.subtitleClassName;
  final itemClassName = container.itemClassName;
  for (final node in root.querySelectorAll('#$id > div')) {
    // title node
    if (node.className == subtitleClassName) {
      currentSubtitle = node.text;
      continue;
    }

    // content node
    if (node.className == itemClassName) {
      final aNodes = node.querySelectorAll(container.itemANodeSelector);

      if (aNodes.isEmpty) {
        currentSubtitle = '';
        continue;
      }

      final titleNodes = node.querySelectorAll(container.itemTitleNodeSelector);

      assert(aNodes.length == titleNodes.length);

      final items = [for (var i = 0; i < aNodes.length; i += 1) i].map((index) {
        final aNode = aNodes[index];
        final tNode = titleNodes[index];

        final imageSrc =
            domain + aNode.querySelector('img').attributes['data-src'];
        final href = domain + aNode.attributes['href'];
        var title = tNode.text;
        if (title.isEmpty) {
          title = tNode.attributes['title'];
        }

        final item =
            HomePageImage(title: title, imageURL: imageSrc, href: href);
        return item;
      }).toList(growable: false);

      final section = HomePageSection(subtitle: currentSubtitle, items: items);
      sections.add(section);
    }
  }
  return sections;
}

WeeklyMissionContainer _parseWeeklyMission(
    Document root, _Source source, _Container container) {
  final tasks = <String>[];
  var date = '';

  for (var p in root.querySelectorAll('#${container.id(source)} > p')) {
    if (p.className == container.subtitleClassName) {
      date = p.text;
      continue;
    }

    if (p.className == container.itemClassName) {
      final text = p.text.split(' ').last;
      tasks.add(text);
    }
  }
  final groupTitle = source == _Source.next ? '下周预任务预测' : '本周任务';
  final masterMission =
      WeeklyMissionContainer(tabName: groupTitle, date: date, tasks: tasks);
  return masterMission;
}
