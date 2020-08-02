import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import 'package:chaldea_data/src/entities/home_entity.dart';

void main() {
  group('HomeEntity', () {
    test('toDomain()', () async {
      final html = await File(TEST_HTML_FILE_PATH).readAsString();
      final entity = HomeEntity.fromHTML(html);
      final cnDomain = entity.toCNDomain();

      int sumContainerItems(Iterable<HomePageSection> contianer) =>
          contianer.fold(0, (sum, e) => sum + e.items.length);

      expect(
          cnDomain.events.length, sumContainerItems(entity.events.cnContainer));
      expect(cnDomain.summons.length,
          sumContainerItems(entity.summons.cnContainer));
      expect(cnDomain.newCards.length,
          sumContainerItems(entity.newCards.cnContainer));
      expect(cnDomain.masterMissionOfNextWeek, isNotNull);

      final jpDomain = entity.toJPDomain();

      expect(
          jpDomain.events.length, sumContainerItems(entity.events.jpContainer));
      expect(jpDomain.summons.length,
          sumContainerItems(entity.summons.jpContainer));
      expect(jpDomain.newCards.length,
          sumContainerItems(entity.newCards.jpContainer));
      expect(jpDomain.masterMissionOfNextWeek, isNull);
    });
    test('fromHTML()', () async {
      final html = await File(TEST_HTML_FILE_PATH).readAsString();
      final entity = HomeEntity.fromHTML(html);

      expect(entity.events.cnContainer.length, 2);
      expect(entity.summons.cnContainer.length, 2);
      expect(entity.newCards.cnContainer.length, 2);
      expect(entity.weeklyMission.cnContainer, isNotNull);
      expect(entity.weeklyMission.jpContainer, isNotNull);
      expect(entity.nextWeeklyMission.cnContainer, isNotNull);
      expect(entity.nextWeeklyMission.jpContainer, isNull);

      expect(entity.newCards.cnContainer[0].items.length, 3);
      expect(entity.newCards.cnContainer[1].items.length, 3);
      expect(entity.newCards.jpContainer[0].items.length, 2);

      expect(entity.newCards.jpContainer[0].items[0].title, '司马懿〔莱妮丝〕#技能');
      expect(entity.newCards.jpContainer[0].items[1].title, '夏洛克·福尔摩斯#技能');
    });

    test('fromJson() & toJson()', () {
      final entity = HomeEntity.fromJson(jsonDecode(HOME_ENTITY_JSON));
      expect(jsonEncode(entity), HOME_ENTITY_JSON);
      expect(jsonEncode(entity.toJson()), HOME_ENTITY_JSON);
    });
  });
}

const TEST_HTML_FILE_PATH = 'test/testdata/mooncell_home.htm';
const HOME_ENTITY_JSON =
    '''{"events":{"cnContainer":[{"subtitle":"当前主要活动（1个）","items":[{"title":"Lostbelt No.4 创世灭亡轮回 由伽·刹多罗","imageURL":"https://fgo.wiki/images/thumb/9/9d/Lostbelt_No.4.png/360px-Lostbelt_No.4.png","href":"https://fgo.wiki/w/Lostbelt_No.4_%E5%88%9B%E4%B8%96%E7%81%AD%E4%BA%A1%E8%BD%AE%E5%9B%9E_%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97"}]},{"subtitle":"即将开放活动（2个）","items":[{"title":"1700万下载突破纪念活动","imageURL":"https://fgo.wiki/images/thumb/2/2b/1700%E4%B8%87%E4%B8%8B%E8%BD%BD.png/360px-1700%E4%B8%87%E4%B8%8B%E8%BD%BD.png","href":"https://fgo.wiki/w/1700%E4%B8%87%E4%B8%8B%E8%BD%BD%E7%AA%81%E7%A0%B4%E7%BA%AA%E5%BF%B5%E6%B4%BB%E5%8A%A8"},{"title":"「君主·埃尔梅罗Ⅱ世事件簿」播放纪念活动","imageURL":"https://fgo.wiki/images/thumb/0/02/%E5%90%9B%E4%B8%BB%C2%B7%E5%9F%83%E5%B0%94%E6%A2%85%E7%BD%97%E2%85%A1%E4%B8%96%E4%BA%8B%E4%BB%B6%E7%B0%BF_%E9%AD%94%E7%9C%BC%E6%94%B6%E9%9B%86%E5%88%97%E8%BD%A6%E6%92%AD%E6%94%BE%E7%BA%AA%E5%BF%B5.png/360px-%E5%90%9B%E4%B8%BB%C2%B7%E5%9F%83%E5%B0%94%E6%A2%85%E7%BD%97%E2%85%A1%E4%B8%96%E4%BA%8B%E4%BB%B6%E7%B0%BF_%E9%AD%94%E7%9C%BC%E6%94%B6%E9%9B%86%E5%88%97%E8%BD%A6%E6%92%AD%E6%94%BE%E7%BA%AA%E5%BF%B5.png","href":"https://fgo.wiki/w/TV%E5%8A%A8%E7%94%BB%E3%80%8C%E5%90%9B%E4%B8%BB%C2%B7%E5%9F%83%E5%B0%94%E6%A2%85%E7%BD%97%E2%85%A1%E4%B8%96%E4%BA%8B%E4%BB%B6%E7%B0%BF_-%E9%AD%94%E7%9C%BC%E6%94%B6%E9%9B%86%E5%88%97%E8%BD%A6_Grace_note-%E3%80%8D%E6%92%AD%E6%94%BE%E7%BA%AA%E5%BF%B5%E6%B4%BB%E5%8A%A8"}]}],"jpContainer":[{"subtitle":"当前主要活动（1个）","items":[{"title":"狩猎关卡 第8弹","imageURL":"https://fgo.wiki/images/thumb/d/dd/%E7%8B%A9%E7%8C%8E%E4%BB%BB%E5%8A%A1_%E7%AC%AC8%E5%BC%B9_jp.png/360px-%E7%8B%A9%E7%8C%8E%E4%BB%BB%E5%8A%A1_%E7%AC%AC8%E5%BC%B9_jp.png","href":"https://fgo.wiki/w/%E7%8B%A9%E7%8C%8E%E5%85%B3%E5%8D%A1_%E7%AC%AC8%E5%BC%B9"}]}]},"summons":{"cnContainer":[{"subtitle":"当前卡池（2个）","items":[{"title":"由伽·刹多罗推荐召唤2","imageURL":"https://fgo.wiki/images/thumb/e/ed/%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A42.png/360px-%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A42.png","href":"https://fgo.wiki/w/%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A42"},{"title":"由伽·刹多罗推荐召唤","imageURL":"https://fgo.wiki/images/thumb/9/9d/%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4.png/360px-%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4.png","href":"https://fgo.wiki/w/%E7%94%B1%E4%BC%BD%C2%B7%E5%88%B9%E5%A4%9A%E7%BD%97%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4"}]},{"subtitle":"即将开放卡池（1个）","items":[{"title":"1700万下载纪念推荐召唤","imageURL":"https://fgo.wiki/images/thumb/3/32/1700%E4%B8%87%E4%B8%8B%E8%BD%BD%E7%BA%AA%E5%BF%B5%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4.png/360px-1700%E4%B8%87%E4%B8%8B%E8%BD%BD%E7%BA%AA%E5%BF%B5%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4.png","href":"https://fgo.wiki/w/1700%E4%B8%87%E4%B8%8B%E8%BD%BD%E7%BA%AA%E5%BF%B5%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4"}]}],"jpContainer":[{"subtitle":"当前卡池（2个）","items":[{"title":"包括泳装的全体攻击宝具推荐召唤","imageURL":"https://fgo.wiki/images/thumb/c/cd/%E5%8C%85%E6%8B%AC%E6%B3%B3%E8%A3%85%E7%9A%84%E5%85%A8%E4%BD%93%E6%94%BB%E5%87%BB%E5%AE%9D%E5%85%B7%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4_jp.png/360px-%E5%8C%85%E6%8B%AC%E6%B3%B3%E8%A3%85%E7%9A%84%E5%85%A8%E4%BD%93%E6%94%BB%E5%87%BB%E5%AE%9D%E5%85%B7%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4_jp.png","href":"https://fgo.wiki/w/%E5%8C%85%E6%8B%AC%E6%B3%B3%E8%A3%85%E7%9A%84%E5%85%A8%E4%BD%93%E6%94%BB%E5%87%BB%E5%AE%9D%E5%85%B7%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4"},{"title":"幕间物语活动第13弹推荐召唤","imageURL":"https://fgo.wiki/images/thumb/4/4a/%E5%B9%95%E9%97%B4%E7%89%A9%E8%AF%AD%E6%B4%BB%E5%8A%A8%E7%AC%AC13%E5%BC%B9%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4_jp.png/360px-%E5%B9%95%E9%97%B4%E7%89%A9%E8%AF%AD%E6%B4%BB%E5%8A%A8%E7%AC%AC13%E5%BC%B9%E6%8E%A8%E8%8D%90%E5%8F%AC%E5%94%A4_jp.png","href":"https://fgo.wiki/w/%E5%B9%95%E9%97%B4%E7%89%A9%E8%AF%AD%E6%B4%BB%E5%8A%A8/%E7%AC%AC13%E5%BC%B9/%E5%8D%A1%E6%B1%A0%E8%AF%A6%E6%83%85"}]}]},"newCards":{"cnContainer":[{"subtitle":"从者","items":[{"title":"阿周那〔Alter〕","imageURL":"https://fgo.wiki/images/thumb/a/a2/Servant247.jpg/60px-Servant247.jpg","href":"https://fgo.wiki/w/%E9%98%BF%E5%91%A8%E9%82%A3%E3%80%94Alter%E3%80%95"},{"title":"马嘶","imageURL":"https://fgo.wiki/images/thumb/d/d2/Servant248.jpg/60px-Servant248.jpg","href":"https://fgo.wiki/w/%E9%A9%AC%E5%98%B6"},{"title":"阿斯克勒庇俄斯","imageURL":"https://fgo.wiki/images/thumb/6/6f/Servant249.jpg/60px-Servant249.jpg","href":"https://fgo.wiki/w/%E9%98%BF%E6%96%AF%E5%85%8B%E5%8B%92%E5%BA%87%E4%BF%84%E6%96%AF"}]},{"subtitle":"概念礼装","items":[{"title":"铭刻之物","imageURL":"https://fgo.wiki/images/thumb/a/a7/%E7%A4%BC%E8%A3%851022.jpg/60px-%E7%A4%BC%E8%A3%851022.jpg","href":"https://fgo.wiki/w/%E9%93%AD%E5%88%BB%E4%B9%8B%E7%89%A9"},{"title":"遥不可及","imageURL":"https://fgo.wiki/images/thumb/4/48/%E7%A4%BC%E8%A3%851023.jpg/60px-%E7%A4%BC%E8%A3%851023.jpg","href":"https://fgo.wiki/w/%E9%81%A5%E4%B8%8D%E5%8F%AF%E5%8F%8A"},{"title":"蛇之杖","imageURL":"https://fgo.wiki/images/thumb/1/13/%E7%A4%BC%E8%A3%851024.jpg/60px-%E7%A4%BC%E8%A3%851024.jpg","href":"https://fgo.wiki/w/%E8%9B%87%E4%B9%8B%E6%9D%96"}]}],"jpContainer":[{"subtitle":"从者强化","items":[{"title":"司马懿〔莱妮丝〕#技能","imageURL":"https://fgo.wiki/images/thumb/6/6f/Servant241.jpg/60px-Servant241.jpg","href":"https://fgo.wiki/w/%E5%8F%B8%E9%A9%AC%E6%87%BF%E3%80%94%E8%8E%B1%E5%A6%AE%E4%B8%9D%E3%80%95#.E6.8A.80.E8.83.BD"},{"title":"夏洛克·福尔摩斯#技能","imageURL":"https://fgo.wiki/images/thumb/e/e3/Servant173.jpg/60px-Servant173.jpg","href":"https://fgo.wiki/w/%E5%A4%8F%E6%B4%9B%E5%85%8B%C2%B7%E7%A6%8F%E5%B0%94%E6%91%A9%E6%96%AF#.E6.8A.80.E8.83.BD"}]}]},"weeklyMission":{"cnContainer":{"tabName":"本周任务","date":"2020年7月6日~7月12日","tasks":["完成本周所有的御主任务","击败3骑持有『善』属性的从者","击败3骑持有『恶』属性的从者","击败20个敌人(从者以及部分boss除外)","击败40个敌人(从者以及部分boss除外)","击败15个持有『天』之力的敌人","击败15个持有『地』之力的敌人"]},"jpContainer":{"tabName":"本周任务","date":"2020年7月6日~7月12日","tasks":["完成本周所有的御主任务","进行30次友情点召唤","击败『Saber』『Rider』职阶中任意一种敌人15个(从者以及部分boss除外)","击败『Lancer』『Assassin』『Berserker』职阶中任意一种敌人15个(从者以及部分boss除外)","击败『Archer』『Caster』职阶中任意一种敌人15个(从者以及部分boss除外)","完成任意关卡5次","完成任意关卡10次"]}},"nextWeeklyMission":{"cnContainer":{"tabName":"下周预任务预测","date":"2020年7月13日~7月19日","tasks":["完成本周所有的御主任务","击败8骑从者","击败『Saber』『Archer』『Lancer』职阶中任意一种敌人15个(从者以及部分boss除外)","击败『Saber』『Archer』『Lancer』职阶中任意一种敌人30个(从者以及部分boss除外)","击败『Rider』『Caster』『Assassin』『Berserker』职阶中任意一种敌人15个(从者以及部分boss除外)","击败『Rider』『Caster』『Assassin』『Berserker』职阶中任意一种敌人30个(从者以及部分boss除外)","完成任意关卡10次"]},"jpContainer":null}}''';
