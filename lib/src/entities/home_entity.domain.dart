part of 'home_entity.dart';

Home _$HomeEntityToCNDomain(HomeEntity instance) {
  final events = _containerToBannerItems(instance.events.cnContainer);
  final summons = _containerToBannerItems(instance.summons.cnContainer);
  final newCards = _containerToNewCards(instance.newCards.cnContainer);
  final masterMission =
      MasterMission(null, null, instance.weeklyMission.cnContainer.tasks);
  final nextMasterMission =
      MasterMission(null, null, instance.nextWeeklyMission.cnContainer.tasks);
  return Home(events, summons, newCards, masterMission,
      masterMissionOfNextWeek: nextMasterMission);
}

Home _$HomeEntityToJPDomain(HomeEntity instance) {
  final events = _containerToBannerItems(instance.events.jpContainer);
  final summons = _containerToBannerItems(instance.summons.jpContainer);
  final newCards = _containerToNewCards(instance.newCards.jpContainer);
  final masterMission =
      MasterMission(null, null, instance.weeklyMission.jpContainer.tasks);
  return Home(events, summons, newCards, masterMission);
}

List<HomeEvent> _containerToBannerItems(List<HomePageSection> container) {
  return container.fold<List<HomeEvent>>(<HomeEvent>[],
      (previousValue, section) {
    final newItems = section.items.map<HomeEvent>((item) {
      return HomeEvent(item.title, section.subtitle, item.imageURL, item.href);
    }).toList(growable: false);
    return previousValue + newItems;
  });
}

List<HomeNewCard> _containerToNewCards(List<HomePageSection> container) {
  return container.fold<List<HomeNewCard>>(<HomeNewCard>[],
      (previousValue, section) {
    final newItems = section.items.map((item) {
      var name = item.title;
      var enhancementTitle;
      HomeNewCardType cardType;
      HomeNewCardEnhancement cardEnhancement;
      final title2 = name.split('#');
      if (title2.length == 2) {
        name = title2[0];
        enhancementTitle = title2[1];

        switch (enhancementTitle) {
          case '技能':
            cardEnhancement = HomeNewCardEnhancement.skill;
            break;
          case '宝具':
            cardEnhancement = HomeNewCardEnhancement.treasureDevice;
            break;
        }
      }

      switch (section.subtitle) {
        case '从者':
          cardType = HomeNewCardType.servant;
          break;
        case '概念礼装':
          cardType = HomeNewCardType.craftEssence;
          break;
        case '从者强化':
          cardType = HomeNewCardType.servantEnhancement;
          break;
        case '指令纹章':
          cardType = HomeNewCardType.commandCode;
          break;
      }
      return HomeNewCard(name, item.imageURL, item.href, cardType,
          enhancementType: cardEnhancement);
    }).toList(growable: false);
    return previousValue + newItems;
  });
}
