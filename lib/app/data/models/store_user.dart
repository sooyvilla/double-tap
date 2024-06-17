
class StoreUser {
  final FeaturedBundle? featuredBundle;
  final SkinsPanelLayout? skinsPanelLayout;
  final UpgradeCurrencyStore? upgradeCurrencyStore;
  final AccessoryStore? accessoryStore;
  final BonusStore? bonusStore;

  StoreUser({
    this.featuredBundle,
    this.skinsPanelLayout,
    this.upgradeCurrencyStore,
    this.accessoryStore,
    this.bonusStore,
  });

  StoreUser copyWith({
    FeaturedBundle? featuredBundle,
    SkinsPanelLayout? skinsPanelLayout,
    UpgradeCurrencyStore? upgradeCurrencyStore,
    AccessoryStore? accessoryStore,
    BonusStore? bonusStore,
  }) =>
      StoreUser(
        featuredBundle: featuredBundle ?? this.featuredBundle,
        skinsPanelLayout: skinsPanelLayout ?? this.skinsPanelLayout,
        upgradeCurrencyStore: upgradeCurrencyStore ?? this.upgradeCurrencyStore,
        accessoryStore: accessoryStore ?? this.accessoryStore,
        bonusStore: bonusStore ?? this.bonusStore,
      );


  factory StoreUser.fromJson(Map<String, dynamic> json) =>
      StoreUser(
        featuredBundle: json["FeaturedBundle"] == null
            ? null
            : FeaturedBundle.fromJson(json["FeaturedBundle"]),
        skinsPanelLayout: json["SkinsPanelLayout"] == null
            ? null
            : SkinsPanelLayout.fromJson(json["SkinsPanelLayout"]),
        upgradeCurrencyStore: json["UpgradeCurrencyStore"] == null
            ? null
            : UpgradeCurrencyStore.fromJson(json["UpgradeCurrencyStore"]),
        accessoryStore: json["AccessoryStore"] == null
            ? null
            : AccessoryStore.fromJson(json["AccessoryStore"]),
        bonusStore: json["BonusStore"] == null
            ? null
            : BonusStore.fromJson(json["BonusStore"]),
      );

  Map<String, dynamic> toJson() => {
        "FeaturedBundle": featuredBundle?.toJson(),
        "SkinsPanelLayout": skinsPanelLayout?.toJson(),
        "UpgradeCurrencyStore": upgradeCurrencyStore?.toJson(),
        "AccessoryStore": accessoryStore?.toJson(),
        "BonusStore": bonusStore?.toJson(),
      };
}

class AccessoryStore {
  final List<AccessoryStoreOffer>? accessoryStoreOffers;
  final double? accessoryStoreRemainingDurationInSeconds;
  final String? storefrontId;

  AccessoryStore({
    this.accessoryStoreOffers,
    this.accessoryStoreRemainingDurationInSeconds,
    this.storefrontId,
  });

  AccessoryStore copyWith({
    List<AccessoryStoreOffer>? accessoryStoreOffers,
    double? accessoryStoreRemainingDurationInSeconds,
    String? storefrontId,
  }) =>
      AccessoryStore(
        accessoryStoreOffers: accessoryStoreOffers ?? this.accessoryStoreOffers,
        accessoryStoreRemainingDurationInSeconds:
            accessoryStoreRemainingDurationInSeconds ??
                this.accessoryStoreRemainingDurationInSeconds,
        storefrontId: storefrontId ?? this.storefrontId,
      );


  factory AccessoryStore.fromJson(Map<String, dynamic> json) => AccessoryStore(
        accessoryStoreOffers: json["AccessoryStoreOffers"] == null
            ? []
            : List<AccessoryStoreOffer>.from(json["AccessoryStoreOffers"]!
                .map((x) => AccessoryStoreOffer.fromJson(x))),
        accessoryStoreRemainingDurationInSeconds:
            json["AccessoryStoreRemainingDurationInSeconds"],
        storefrontId: json["StorefrontID"],
      );

  Map<String, dynamic> toJson() => {
        "AccessoryStoreOffers": accessoryStoreOffers == null
            ? []
            : List<dynamic>.from(accessoryStoreOffers!.map((x) => x.toJson())),
        "AccessoryStoreRemainingDurationInSeconds":
            accessoryStoreRemainingDurationInSeconds,
        "StorefrontID": storefrontId,
      };
}

class AccessoryStoreOffer {
  final Offer? offer;
  final String? contractId;

  AccessoryStoreOffer({
    this.offer,
    this.contractId,
  });

  AccessoryStoreOffer copyWith({
    Offer? offer,
    String? contractId,
  }) =>
      AccessoryStoreOffer(
        offer: offer ?? this.offer,
        contractId: contractId ?? this.contractId,
      );


  factory AccessoryStoreOffer.fromJson(Map<String, dynamic> json) =>
      AccessoryStoreOffer(
        offer: json["Offer"] == null ? null : Offer.fromJson(json["Offer"]),
        contractId: json["ContractID"],
      );

  Map<String, dynamic> toJson() => {
        "Offer": offer?.toJson(),
        "ContractID": contractId,
      };
}

class Offer {
  final String? offerId;
  final bool? isDirectPurchase;
  final String? startDate;
  final TotalBaseCost? cost;
  final List<Reward>? rewards;

  Offer({
    this.offerId,
    this.isDirectPurchase,
    this.startDate,
    this.cost,
    this.rewards,
  });

  Offer copyWith({
    String? offerId,
    bool? isDirectPurchase,
    String? startDate,
    TotalBaseCost? cost,
    List<Reward>? rewards,
  }) =>
      Offer(
        offerId: offerId ?? this.offerId,
        isDirectPurchase: isDirectPurchase ?? this.isDirectPurchase,
        startDate: startDate ?? this.startDate,
        cost: cost ?? this.cost,
        rewards: rewards ?? this.rewards,
      );


  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerId: json["OfferID"],
        isDirectPurchase: json["IsDirectPurchase"],
        startDate: json["StartDate"],
        cost:
            json["Cost"] == null ? null : TotalBaseCost.fromJson(json["Cost"]),
        rewards: json["Rewards"] == null
            ? []
            : List<Reward>.from(
                json["Rewards"]!.map((x) => Reward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "OfferID": offerId,
        "IsDirectPurchase": isDirectPurchase,
        "StartDate": startDate,
        "Cost": cost?.toJson(),
        "Rewards": rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
      };
}

class TotalBaseCost {
  final int? x;

  TotalBaseCost({
    this.x,
  });

  TotalBaseCost copyWith({
    int? x,
  }) =>
      TotalBaseCost(
        x: x ?? this.x,
      );


  factory TotalBaseCost.fromJson(Map<String, dynamic> json) => TotalBaseCost(
        x: json["x"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
      };
}

class Reward {
  final String? itemTypeId;
  final String? itemId;
  final double? quantity;

  Reward({
    this.itemTypeId,
    this.itemId,
    this.quantity,
  });

  Reward copyWith({
    String? itemTypeId,
    String? itemId,
    double? quantity,
  }) =>
      Reward(
        itemTypeId: itemTypeId ?? this.itemTypeId,
        itemId: itemId ?? this.itemId,
        quantity: quantity ?? this.quantity,
      );


  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        itemTypeId: json["ItemTypeID"],
        itemId: json["ItemID"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "ItemTypeID": itemTypeId,
        "ItemID": itemId,
        "Quantity": quantity,
      };
}

class BonusStore {
  final List<BonusStoreOffer>? bonusStoreOffers;
  final int? bonusStoreRemainingDurationInSeconds;

  BonusStore({
    this.bonusStoreOffers,
    this.bonusStoreRemainingDurationInSeconds,
  });

  BonusStore copyWith({
    List<BonusStoreOffer>? bonusStoreOffers,
    int? bonusStoreRemainingDurationInSeconds,
  }) =>
      BonusStore(
        bonusStoreOffers: bonusStoreOffers ?? this.bonusStoreOffers,
        bonusStoreRemainingDurationInSeconds:
            bonusStoreRemainingDurationInSeconds ??
                this.bonusStoreRemainingDurationInSeconds,
      );


  factory BonusStore.fromJson(Map<String, dynamic> json) => BonusStore(
        bonusStoreOffers: json["BonusStoreOffers"] == null
            ? []
            : List<BonusStoreOffer>.from(json["BonusStoreOffers"]!
                .map((x) => BonusStoreOffer.fromJson(x))),
        bonusStoreRemainingDurationInSeconds:
            json["BonusStoreRemainingDurationInSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "BonusStoreOffers": bonusStoreOffers == null
            ? []
            : List<dynamic>.from(bonusStoreOffers!.map((x) => x.toJson())),
        "BonusStoreRemainingDurationInSeconds":
            bonusStoreRemainingDurationInSeconds,
      };
}

class BonusStoreOffer {
  final String? bonusOfferId;
  final Offer? offer;
  final int? discountPercent;
  final TotalBaseCost? discountCosts;
  final bool? isSeen;

  BonusStoreOffer({
    this.bonusOfferId,
    this.offer,
    this.discountPercent,
    this.discountCosts,
    this.isSeen,
  });

  BonusStoreOffer copyWith({
    String? bonusOfferId,
    Offer? offer,
    int? discountPercent,
    TotalBaseCost? discountCosts,
    bool? isSeen,
  }) =>
      BonusStoreOffer(
        bonusOfferId: bonusOfferId ?? this.bonusOfferId,
        offer: offer ?? this.offer,
        discountPercent: discountPercent ?? this.discountPercent,
        discountCosts: discountCosts ?? this.discountCosts,
        isSeen: isSeen ?? this.isSeen,
      );


  factory BonusStoreOffer.fromJson(Map<String, dynamic> json) =>
      BonusStoreOffer(
        bonusOfferId: json["BonusOfferID"],
        offer: json["Offer"] == null ? null : Offer.fromJson(json["Offer"]),
        discountPercent: json["DiscountPercent"],
        discountCosts: json["DiscountCosts"] == null
            ? null
            : TotalBaseCost.fromJson(json["DiscountCosts"]),
        isSeen: json["IsSeen"],
      );

  Map<String, dynamic> toJson() => {
        "BonusOfferID": bonusOfferId,
        "Offer": offer?.toJson(),
        "DiscountPercent": discountPercent,
        "DiscountCosts": discountCosts?.toJson(),
        "IsSeen": isSeen,
      };
}

class FeaturedBundle {
  final Bundle? bundle;
  final List<Bundle>? bundles;
  final double? bundleRemainingDurationInSeconds;

  FeaturedBundle({
    this.bundle,
    this.bundles,
    this.bundleRemainingDurationInSeconds,
  });

  FeaturedBundle copyWith({
    Bundle? bundle,
    List<Bundle>? bundles,
    double? bundleRemainingDurationInSeconds,
  }) =>
      FeaturedBundle(
        bundle: bundle ?? this.bundle,
        bundles: bundles ?? this.bundles,
        bundleRemainingDurationInSeconds: bundleRemainingDurationInSeconds ??
            this.bundleRemainingDurationInSeconds,
      );


  factory FeaturedBundle.fromJson(Map<String, dynamic> json) => FeaturedBundle(
        bundle: json["Bundle"] == null ? null : Bundle.fromJson(json["Bundle"]),
        bundles: json["Bundles"] == null
            ? []
            : List<Bundle>.from(
                json["Bundles"]!.map((x) => Bundle.fromJson(x))),
        bundleRemainingDurationInSeconds:
            json["BundleRemainingDurationInSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "Bundle": bundle?.toJson(),
        "Bundles": bundles == null
            ? []
            : List<dynamic>.from(bundles!.map((x) => x.toJson())),
        "BundleRemainingDurationInSeconds": bundleRemainingDurationInSeconds,
      };
}

class Bundle {
  final String? id;
  final String? dataAssetId;
  final String? currencyId;
  final List<ItemElement>? items;
  final List<ItemOffer>? itemOffers;
  final TotalBaseCost? totalBaseCost;
  final TotalBaseCost? totalDiscountedCost;
  final double? totalDiscountPercent;
  final double? durationRemainingInSeconds;
  final bool? wholesaleOnly;

  Bundle({
    this.id,
    this.dataAssetId,
    this.currencyId,
    this.items,
    this.itemOffers,
    this.totalBaseCost,
    this.totalDiscountedCost,
    this.totalDiscountPercent,
    this.durationRemainingInSeconds,
    this.wholesaleOnly,
  });

  Bundle copyWith({
    String? id,
    String? dataAssetId,
    String? currencyId,
    List<ItemElement>? items,
    List<ItemOffer>? itemOffers,
    TotalBaseCost? totalBaseCost,
    TotalBaseCost? totalDiscountedCost,
    double? totalDiscountPercent,
    double? durationRemainingInSeconds,
    bool? wholesaleOnly,
  }) =>
      Bundle(
        id: id ?? this.id,
        dataAssetId: dataAssetId ?? this.dataAssetId,
        currencyId: currencyId ?? this.currencyId,
        items: items ?? this.items,
        itemOffers: itemOffers ?? this.itemOffers,
        totalBaseCost: totalBaseCost ?? this.totalBaseCost,
        totalDiscountedCost: totalDiscountedCost ?? this.totalDiscountedCost,
        totalDiscountPercent: totalDiscountPercent ?? this.totalDiscountPercent,
        durationRemainingInSeconds:
            durationRemainingInSeconds ?? this.durationRemainingInSeconds,
        wholesaleOnly: wholesaleOnly ?? this.wholesaleOnly,
      );


  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        id: json["ID"],
        dataAssetId: json["DataAssetID"],
        currencyId: json["CurrencyID"],
        items: json["Items"] == null
            ? []
            : List<ItemElement>.from(
                json["Items"]!.map((x) => ItemElement.fromJson(x))),
        itemOffers: json["ItemOffers"] == null
            ? []
            : List<ItemOffer>.from(
                json["ItemOffers"]!.map((x) => ItemOffer.fromJson(x))),
        totalBaseCost: json["TotalBaseCost"] == null
            ? null
            : TotalBaseCost.fromJson(json["TotalBaseCost"]),
        totalDiscountedCost: json["TotalDiscountedCost"] == null
            ? null
            : TotalBaseCost.fromJson(json["TotalDiscountedCost"]),
        totalDiscountPercent: json["TotalDiscountPercent"],
        durationRemainingInSeconds: json["DurationRemainingInSeconds"],
        wholesaleOnly: json["WholesaleOnly"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "DataAssetID": dataAssetId,
        "CurrencyID": currencyId,
        "Items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "ItemOffers": itemOffers == null
            ? []
            : List<dynamic>.from(itemOffers!.map((x) => x.toJson())),
        "TotalBaseCost": totalBaseCost?.toJson(),
        "TotalDiscountedCost": totalDiscountedCost?.toJson(),
        "TotalDiscountPercent": totalDiscountPercent,
        "DurationRemainingInSeconds": durationRemainingInSeconds,
        "WholesaleOnly": wholesaleOnly,
      };
}

class ItemOffer {
  final String? bundleItemOfferId;
  final Offer? offer;
  final int? discountPercent;
  final TotalBaseCost? discountedCost;

  ItemOffer({
    this.bundleItemOfferId,
    this.offer,
    this.discountPercent,
    this.discountedCost,
  });

  ItemOffer copyWith({
    String? bundleItemOfferId,
    Offer? offer,
    int? discountPercent,
    TotalBaseCost? discountedCost,
  }) =>
      ItemOffer(
        bundleItemOfferId: bundleItemOfferId ?? this.bundleItemOfferId,
        offer: offer ?? this.offer,
        discountPercent: discountPercent ?? this.discountPercent,
        discountedCost: discountedCost ?? this.discountedCost,
      );


  factory ItemOffer.fromJson(Map<String, dynamic> json) => ItemOffer(
        bundleItemOfferId: json["BundleItemOfferID"],
        offer: json["Offer"] == null ? null : Offer.fromJson(json["Offer"]),
        discountPercent: json["DiscountPercent"],
        discountedCost: json["DiscountedCost"] == null
            ? null
            : TotalBaseCost.fromJson(json["DiscountedCost"]),
      );

  Map<String, dynamic> toJson() => {
        "BundleItemOfferID": bundleItemOfferId,
        "Offer": offer?.toJson(),
        "DiscountPercent": discountPercent,
        "DiscountedCost": discountedCost?.toJson(),
      };
}

class ItemElement {
  final ItemItem? item;
  final int? basePrice;
  final String? currencyId;
  final int? discountPercent;
  final int? discountedPrice;
  final bool? isPromoItem;

  ItemElement({
    this.item,
    this.basePrice,
    this.currencyId,
    this.discountPercent,
    this.discountedPrice,
    this.isPromoItem,
  });

  ItemElement copyWith({
    ItemItem? item,
    int? basePrice,
    String? currencyId,
    int? discountPercent,
    int? discountedPrice,
    bool? isPromoItem,
  }) =>
      ItemElement(
        item: item ?? this.item,
        basePrice: basePrice ?? this.basePrice,
        currencyId: currencyId ?? this.currencyId,
        discountPercent: discountPercent ?? this.discountPercent,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        isPromoItem: isPromoItem ?? this.isPromoItem,
      );


  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        item: json["Item"] == null ? null : ItemItem.fromJson(json["Item"]),
        basePrice: json["BasePrice"],
        currencyId: json["CurrencyID"],
        discountPercent: json["DiscountPercent"],
        discountedPrice: json["DiscountedPrice"],
        isPromoItem: json["IsPromoItem"],
      );

  Map<String, dynamic> toJson() => {
        "Item": item?.toJson(),
        "BasePrice": basePrice,
        "CurrencyID": currencyId,
        "DiscountPercent": discountPercent,
        "DiscountedPrice": discountedPrice,
        "IsPromoItem": isPromoItem,
      };
}

class ItemItem {
  final String? itemTypeId;
  final String? itemId;
  final int? amount;

  ItemItem({
    this.itemTypeId,
    this.itemId,
    this.amount,
  });

  ItemItem copyWith({
    String? itemTypeId,
    String? itemId,
    int? amount,
  }) =>
      ItemItem(
        itemTypeId: itemTypeId ?? this.itemTypeId,
        itemId: itemId ?? this.itemId,
        amount: amount ?? this.amount,
      );


  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        itemTypeId: json["ItemTypeID"],
        itemId: json["ItemID"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "ItemTypeID": itemTypeId,
        "ItemID": itemId,
        "Amount": amount,
      };
}

class SkinsPanelLayout {
  final List<String>? singleItemOffers;
  final List<Offer>? singleItemStoreOffers;
  final int? singleItemOffersRemainingDurationInSeconds;

  SkinsPanelLayout({
    this.singleItemOffers,
    this.singleItemStoreOffers,
    this.singleItemOffersRemainingDurationInSeconds,
  });

  SkinsPanelLayout copyWith({
    List<String>? singleItemOffers,
    List<Offer>? singleItemStoreOffers,
    int? singleItemOffersRemainingDurationInSeconds,
  }) =>
      SkinsPanelLayout(
        singleItemOffers: singleItemOffers ?? this.singleItemOffers,
        singleItemStoreOffers:
            singleItemStoreOffers ?? this.singleItemStoreOffers,
        singleItemOffersRemainingDurationInSeconds:
            singleItemOffersRemainingDurationInSeconds ??
                this.singleItemOffersRemainingDurationInSeconds,
      );


  factory SkinsPanelLayout.fromJson(Map<String, dynamic> json) =>
      SkinsPanelLayout(
        singleItemOffers: json["SingleItemOffers"] == null
            ? []
            : List<String>.from(json["SingleItemOffers"]!.map((x) => x)),
        singleItemStoreOffers: json["SingleItemStoreOffers"] == null
            ? []
            : List<Offer>.from(
                json["SingleItemStoreOffers"]!.map((x) => Offer.fromJson(x))),
        singleItemOffersRemainingDurationInSeconds:
            json["SingleItemOffersRemainingDurationInSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "SingleItemOffers": singleItemOffers == null
            ? []
            : List<dynamic>.from(singleItemOffers!.map((x) => x)),
        "SingleItemStoreOffers": singleItemStoreOffers == null
            ? []
            : List<dynamic>.from(singleItemStoreOffers!.map((x) => x.toJson())),
        "SingleItemOffersRemainingDurationInSeconds":
            singleItemOffersRemainingDurationInSeconds,
      };
}

class UpgradeCurrencyStore {
  final List<UpgradeCurrencyOffer>? upgradeCurrencyOffers;

  UpgradeCurrencyStore({
    this.upgradeCurrencyOffers,
  });

  UpgradeCurrencyStore copyWith({
    List<UpgradeCurrencyOffer>? upgradeCurrencyOffers,
  }) =>
      UpgradeCurrencyStore(
        upgradeCurrencyOffers:
            upgradeCurrencyOffers ?? this.upgradeCurrencyOffers,
      );

  factory UpgradeCurrencyStore.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyStore(
        upgradeCurrencyOffers: json["UpgradeCurrencyOffers"] == null
            ? []
            : List<UpgradeCurrencyOffer>.from(json["UpgradeCurrencyOffers"]!
                .map((x) => UpgradeCurrencyOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "UpgradeCurrencyOffers": upgradeCurrencyOffers == null
            ? []
            : List<dynamic>.from(upgradeCurrencyOffers!.map((x) => x.toJson())),
      };
}

class UpgradeCurrencyOffer {
  final String? offerId;
  final String? storefrontItemId;
  final Offer? offer;
  final int? discountedPercent;

  UpgradeCurrencyOffer({
    this.offerId,
    this.storefrontItemId,
    this.offer,
    this.discountedPercent,
  });

  UpgradeCurrencyOffer copyWith({
    String? offerId,
    String? storefrontItemId,
    Offer? offer,
    int? discountedPercent,
  }) =>
      UpgradeCurrencyOffer(
        offerId: offerId ?? this.offerId,
        storefrontItemId: storefrontItemId ?? this.storefrontItemId,
        offer: offer ?? this.offer,
        discountedPercent: discountedPercent ?? this.discountedPercent,
      );


  factory UpgradeCurrencyOffer.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyOffer(
        offerId: json["OfferID"],
        storefrontItemId: json["StorefrontItemID"],
        offer: json["Offer"] == null ? null : Offer.fromJson(json["Offer"]),
        discountedPercent: json["DiscountedPercent"],
      );

  Map<String, dynamic> toJson() => {
        "OfferID": offerId,
        "StorefrontItemID": storefrontItemId,
        "Offer": offer?.toJson(),
        "DiscountedPercent": discountedPercent,
      };
}
