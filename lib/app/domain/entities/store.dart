// ignore_for_file: public_member_api_docs, sort_constructors_first
class Store {
  int timeStore;
  List<WeaponSingle> store;
  List<Packs>? packs;
  List<WeaponSingle>? nightMarket;
  Store({
    required this.timeStore,
    required this.store,
    this.packs,
    this.nightMarket,
  });
}

class WeaponSingle {
  String name;
  String typeId;
  String id;
  int price;
  int? discount;
  String? displayIcon;
  String? displayVideo;
  WeaponSingle({
    required this.name,
    required this.typeId,
    required this.id,
    required this.price,
    this.discount,
    this.displayIcon,
    this.displayVideo,
  });
}

class Packs {
  int timePack;
  String name;
  String id;
  int price;
  double discount;
  String displayIcon;
  List<WeaponSingle?> weapons;
  Packs({
    required this.timePack,
    required this.name,
    required this.id,
    required this.price,
    required this.discount,
    required this.displayIcon,
    required this.weapons,
  });
}
