import 'dart:convert';

class StoreUser {
  final FeaturedBundle? featuredBundle;
  final SkinsPanelLayout? skinsPanelLayout;
  final UpgradeCurrencyStore? upgradeCurrencyStore;
  final AccessoryStore? accessoryStore;
  final List<PluginStore>? pluginStores;
  final List<InfoItemStore>? infoItemStores;
  final List<BundleInfo>? bundleInfos;

  StoreUser({
    this.featuredBundle,
    this.skinsPanelLayout,
    this.upgradeCurrencyStore,
    this.accessoryStore,
    this.pluginStores,
    this.infoItemStores,
    this.bundleInfos,
  });

  StoreUser copyWith({
    FeaturedBundle? featuredBundle,
    SkinsPanelLayout? skinsPanelLayout,
    UpgradeCurrencyStore? upgradeCurrencyStore,
    AccessoryStore? accessoryStore,
    List<PluginStore>? pluginStores,
    List<InfoItemStore>? infoItemStore,
    List<BundleInfo>? bundleInfo,
  }) =>
      StoreUser(
        featuredBundle: featuredBundle ?? this.featuredBundle,
        skinsPanelLayout: skinsPanelLayout ?? this.skinsPanelLayout,
        upgradeCurrencyStore: upgradeCurrencyStore ?? this.upgradeCurrencyStore,
        accessoryStore: accessoryStore ?? this.accessoryStore,
        pluginStores: pluginStores ?? this.pluginStores,
        infoItemStores: infoItemStore ?? infoItemStores,
        bundleInfos: bundleInfo ?? bundleInfos,
      );

  factory StoreUser.fromRawJson(String str) =>
      StoreUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreUser.fromJson(Map<String, dynamic> json) => StoreUser(
        featuredBundle: json['FeaturedBundle'] == null
            ? null
            : FeaturedBundle.fromJson(json['FeaturedBundle']),
        skinsPanelLayout: json['SkinsPanelLayout'] == null
            ? null
            : SkinsPanelLayout.fromJson(json['SkinsPanelLayout']),
        upgradeCurrencyStore: json['UpgradeCurrencyStore'] == null
            ? null
            : UpgradeCurrencyStore.fromJson(json['UpgradeCurrencyStore']),
        accessoryStore: json['AccessoryStore'] == null
            ? null
            : AccessoryStore.fromJson(json['AccessoryStore']),
        pluginStores: json['PluginStores'] == null
            ? []
            : List<PluginStore>.from(
                json['PluginStores']!.map((x) => PluginStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'FeaturedBundle': featuredBundle?.toJson(),
        'SkinsPanelLayout': skinsPanelLayout?.toJson(),
        'UpgradeCurrencyStore': upgradeCurrencyStore?.toJson(),
        'AccessoryStore': accessoryStore?.toJson(),
        'PluginStores': pluginStores == null
            ? []
            : List<dynamic>.from(pluginStores!.map((x) => x.toJson())),
      };
}

class AccessoryStore {
  final List<AccessoryStoreOffer>? accessoryStoreOffers;
  final int? accessoryStoreRemainingDurationInSeconds;
  final String? storefrontId;

  AccessoryStore({
    this.accessoryStoreOffers,
    this.accessoryStoreRemainingDurationInSeconds,
    this.storefrontId,
  });

  AccessoryStore copyWith({
    List<AccessoryStoreOffer>? accessoryStoreOffers,
    int? accessoryStoreRemainingDurationInSeconds,
    String? storefrontId,
  }) =>
      AccessoryStore(
        accessoryStoreOffers: accessoryStoreOffers ?? this.accessoryStoreOffers,
        accessoryStoreRemainingDurationInSeconds:
            accessoryStoreRemainingDurationInSeconds ??
                this.accessoryStoreRemainingDurationInSeconds,
        storefrontId: storefrontId ?? this.storefrontId,
      );

  factory AccessoryStore.fromRawJson(String str) =>
      AccessoryStore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccessoryStore.fromJson(Map<String, dynamic> json) => AccessoryStore(
        accessoryStoreOffers: json['AccessoryStoreOffers'] == null
            ? []
            : List<AccessoryStoreOffer>.from(json['AccessoryStoreOffers']!
                .map((x) => AccessoryStoreOffer.fromJson(x))),
        accessoryStoreRemainingDurationInSeconds:
            json['AccessoryStoreRemainingDurationInSeconds'],
        storefrontId: json['StorefrontID'],
      );

  Map<String, dynamic> toJson() => {
        'AccessoryStoreOffers': accessoryStoreOffers == null
            ? []
            : List<dynamic>.from(accessoryStoreOffers!.map((x) => x.toJson())),
        'AccessoryStoreRemainingDurationInSeconds':
            accessoryStoreRemainingDurationInSeconds,
        'StorefrontID': storefrontId,
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

  factory AccessoryStoreOffer.fromRawJson(String str) =>
      AccessoryStoreOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccessoryStoreOffer.fromJson(Map<String, dynamic> json) =>
      AccessoryStoreOffer(
        offer: json['Offer'] == null ? null : Offer.fromJson(json['Offer']),
        contractId: json['ContractID'],
      );

  Map<String, dynamic> toJson() => {
        'Offer': offer?.toJson(),
        'ContractID': contractId,
      };
}

class Offer {
  final String? offerId;
  final bool? isDirectPurchase;
  final DateTime? startDate;
  final Cost? cost;
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
    DateTime? startDate,
    Cost? cost,
    List<Reward>? rewards,
  }) =>
      Offer(
        offerId: offerId ?? this.offerId,
        isDirectPurchase: isDirectPurchase ?? this.isDirectPurchase,
        startDate: startDate ?? this.startDate,
        cost: cost ?? this.cost,
        rewards: rewards ?? this.rewards,
      );

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerId: json['OfferID'],
        isDirectPurchase: json['IsDirectPurchase'],
        startDate: json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        cost: json['Cost'] == null ? null : Cost.fromJson(json['Cost']),
        rewards: json['Rewards'] == null
            ? []
            : List<Reward>.from(
                json['Rewards']!.map((x) => Reward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerId,
        'IsDirectPurchase': isDirectPurchase,
        'StartDate': startDate?.toIso8601String(),
        'Cost': cost?.toJson(),
        'Rewards': rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
      };
}

class Cost {
  final int? the85Ca954A41F2Ce949B458Ca3Dd39A00D;

  Cost({
    this.the85Ca954A41F2Ce949B458Ca3Dd39A00D,
  });

  Cost copyWith({
    int? the85Ca954A41F2Ce949B458Ca3Dd39A00D,
  }) =>
      Cost(
        the85Ca954A41F2Ce949B458Ca3Dd39A00D:
            the85Ca954A41F2Ce949B458Ca3Dd39A00D ??
                this.the85Ca954A41F2Ce949B458Ca3Dd39A00D,
      );

  factory Cost.fromRawJson(String str) => Cost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        the85Ca954A41F2Ce949B458Ca3Dd39A00D:
            json['85ca954a-41f2-ce94-9b45-8ca3dd39a00d'],
      );

  Map<String, dynamic> toJson() => {
        '85ca954a-41f2-ce94-9b45-8ca3dd39a00d':
            the85Ca954A41F2Ce949B458Ca3Dd39A00D,
      };
}

class Reward {
  final String? itemTypeId;
  final String? itemId;
  final int? quantity;

  Reward({
    this.itemTypeId,
    this.itemId,
    this.quantity,
  });

  Reward copyWith({
    String? itemTypeId,
    String? itemId,
    int? quantity,
  }) =>
      Reward(
        itemTypeId: itemTypeId ?? this.itemTypeId,
        itemId: itemId ?? this.itemId,
        quantity: quantity ?? this.quantity,
      );

  factory Reward.fromRawJson(String str) => Reward.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        itemTypeId: json['ItemTypeID'],
        itemId: json['ItemID'],
        quantity: json['Quantity'],
      );

  Map<String, dynamic> toJson() => {
        'ItemTypeID': itemTypeId,
        'ItemID': itemId,
        'Quantity': quantity,
      };
}

class FeaturedBundle {
  final Bundle? bundle;
  final List<Bundle>? bundles;
  final int? bundleRemainingDurationInSeconds;

  FeaturedBundle({
    this.bundle,
    this.bundles,
    this.bundleRemainingDurationInSeconds,
  });

  FeaturedBundle copyWith({
    Bundle? bundle,
    List<Bundle>? bundles,
    int? bundleRemainingDurationInSeconds,
  }) =>
      FeaturedBundle(
        bundle: bundle ?? this.bundle,
        bundles: bundles ?? this.bundles,
        bundleRemainingDurationInSeconds: bundleRemainingDurationInSeconds ??
            this.bundleRemainingDurationInSeconds,
      );

  factory FeaturedBundle.fromRawJson(String str) =>
      FeaturedBundle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeaturedBundle.fromJson(Map<String, dynamic> json) => FeaturedBundle(
        bundle: json['Bundle'] == null ? null : Bundle.fromJson(json['Bundle']),
        bundles: json['Bundles'] == null
            ? []
            : List<Bundle>.from(
                json['Bundles']!.map((x) => Bundle.fromJson(x))),
        bundleRemainingDurationInSeconds:
            json['BundleRemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'Bundle': bundle?.toJson(),
        'Bundles': bundles == null
            ? []
            : List<dynamic>.from(bundles!.map((x) => x.toJson())),
        'BundleRemainingDurationInSeconds': bundleRemainingDurationInSeconds,
      };
}

class Bundle {
  final String? id;
  final String? dataAssetId;
  final String? currencyId;
  final List<ItemElement>? items;
  final List<ItemOffer>? itemOffers;
  final TotalBaseCostClass? totalBaseCost;
  final TotalBaseCostClass? totalDiscountedCost;
  final double? totalDiscountPercent;
  final int? durationRemainingInSeconds;
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
    TotalBaseCostClass? totalBaseCost,
    TotalBaseCostClass? totalDiscountedCost,
    double? totalDiscountPercent,
    int? durationRemainingInSeconds,
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

  factory Bundle.fromRawJson(String str) => Bundle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        id: json['ID'],
        dataAssetId: json['DataAssetID'],
        currencyId: json['CurrencyID'],
        items: json['Items'] == null
            ? []
            : List<ItemElement>.from(
                json['Items']!.map((x) => ItemElement.fromJson(x))),
        itemOffers: json['ItemOffers'] == null
            ? []
            : List<ItemOffer>.from(
                json['ItemOffers']!.map((x) => ItemOffer.fromJson(x))),
        totalBaseCost: json['TotalBaseCost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['TotalBaseCost']),
        totalDiscountedCost: json['TotalDiscountedCost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['TotalDiscountedCost']),
        totalDiscountPercent: json['TotalDiscountPercent']?.toDouble(),
        durationRemainingInSeconds: json['DurationRemainingInSeconds'],
        wholesaleOnly: json['WholesaleOnly'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'DataAssetID': dataAssetId,
        'CurrencyID': currencyId,
        'Items': items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        'ItemOffers': itemOffers == null
            ? []
            : List<dynamic>.from(itemOffers!.map((x) => x.toJson())),
        'TotalBaseCost': totalBaseCost?.toJson(),
        'TotalDiscountedCost': totalDiscountedCost?.toJson(),
        'TotalDiscountPercent': totalDiscountPercent,
        'DurationRemainingInSeconds': durationRemainingInSeconds,
        'WholesaleOnly': wholesaleOnly,
      };
}

class ItemOffer {
  final String? bundleItemOfferId;
  final SingleItemStoreOfferElement? offer;
  final double? discountPercent;
  final TotalBaseCostClass? discountedCost;

  ItemOffer({
    this.bundleItemOfferId,
    this.offer,
    this.discountPercent,
    this.discountedCost,
  });

  ItemOffer copyWith({
    String? bundleItemOfferId,
    SingleItemStoreOfferElement? offer,
    double? discountPercent,
    TotalBaseCostClass? discountedCost,
  }) =>
      ItemOffer(
        bundleItemOfferId: bundleItemOfferId ?? this.bundleItemOfferId,
        offer: offer ?? this.offer,
        discountPercent: discountPercent ?? this.discountPercent,
        discountedCost: discountedCost ?? this.discountedCost,
      );

  factory ItemOffer.fromRawJson(String str) =>
      ItemOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemOffer.fromJson(Map<String, dynamic> json) => ItemOffer(
        bundleItemOfferId: json['BundleItemOfferID'],
        offer: json['Offer'] == null
            ? null
            : SingleItemStoreOfferElement.fromJson(json['Offer']),
        discountPercent: json['DiscountPercent']?.toDouble(),
        discountedCost: json['DiscountedCost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['DiscountedCost']),
      );

  Map<String, dynamic> toJson() => {
        'BundleItemOfferID': bundleItemOfferId,
        'Offer': offer?.toJson(),
        'DiscountPercent': discountPercent,
        'DiscountedCost': discountedCost?.toJson(),
      };
}

class TotalBaseCostClass {
  final int? cost;

  TotalBaseCostClass({
    this.cost,
  });

  TotalBaseCostClass copyWith({
    int? the85Ad13F73D1B51289Eb27Cd8Ee0B5741,
  }) =>
      TotalBaseCostClass(
        cost: the85Ad13F73D1B51289Eb27Cd8Ee0B5741 ?? cost,
      );

  factory TotalBaseCostClass.fromRawJson(String str) =>
      TotalBaseCostClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalBaseCostClass.fromJson(Map<String, dynamic> json) =>
      TotalBaseCostClass(
        cost: json['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741'],
      );

  Map<String, dynamic> toJson() => {
        '85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741': cost,
      };
}

class SingleItemStoreOfferElement {
  final String? offerId;
  final bool? isDirectPurchase;
  final DateTime? startDate;
  final TotalBaseCostClass? cost;
  final List<Reward>? rewards;

  SingleItemStoreOfferElement({
    this.offerId,
    this.isDirectPurchase,
    this.startDate,
    this.cost,
    this.rewards,
  });

  SingleItemStoreOfferElement copyWith({
    String? offerId,
    bool? isDirectPurchase,
    DateTime? startDate,
    TotalBaseCostClass? cost,
    List<Reward>? rewards,
  }) =>
      SingleItemStoreOfferElement(
        offerId: offerId ?? this.offerId,
        isDirectPurchase: isDirectPurchase ?? this.isDirectPurchase,
        startDate: startDate ?? this.startDate,
        cost: cost ?? this.cost,
        rewards: rewards ?? this.rewards,
      );

  factory SingleItemStoreOfferElement.fromRawJson(String str) =>
      SingleItemStoreOfferElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleItemStoreOfferElement.fromJson(Map<String, dynamic> json) =>
      SingleItemStoreOfferElement(
        offerId: json['OfferID'],
        isDirectPurchase: json['IsDirectPurchase'],
        startDate: json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        cost: json['Cost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['Cost']),
        rewards: json['Rewards'] == null
            ? []
            : List<Reward>.from(
                json['Rewards']!.map((x) => Reward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerId,
        'IsDirectPurchase': isDirectPurchase,
        'StartDate': startDate?.toIso8601String(),
        'Cost': cost?.toJson(),
        'Rewards': rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
      };
}

class ItemElement {
  final ItemItem? item;
  final int? basePrice;
  final String? currencyId;
  final double? discountPercent;
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
    double? discountPercent,
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

  factory ItemElement.fromRawJson(String str) =>
      ItemElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        item: json['Item'] == null ? null : ItemItem.fromJson(json['Item']),
        basePrice: json['BasePrice'],
        currencyId: json['CurrencyID'],
        discountPercent: json['DiscountPercent']?.toDouble(),
        discountedPrice: json['DiscountedPrice'],
        isPromoItem: json['IsPromoItem'],
      );

  Map<String, dynamic> toJson() => {
        'Item': item?.toJson(),
        'BasePrice': basePrice,
        'CurrencyID': currencyId,
        'DiscountPercent': discountPercent,
        'DiscountedPrice': discountedPrice,
        'IsPromoItem': isPromoItem,
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

  factory ItemItem.fromRawJson(String str) =>
      ItemItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        itemTypeId: json['ItemTypeID'],
        itemId: json['ItemID'],
        amount: json['Amount'],
      );

  Map<String, dynamic> toJson() => {
        'ItemTypeID': itemTypeId,
        'ItemID': itemId,
        'Amount': amount,
      };
}

class PluginStore {
  final String? pluginId;
  final PluginOffers? pluginOffers;

  PluginStore({
    this.pluginId,
    this.pluginOffers,
  });

  PluginStore copyWith({
    String? pluginId,
    PluginOffers? pluginOffers,
  }) =>
      PluginStore(
        pluginId: pluginId ?? this.pluginId,
        pluginOffers: pluginOffers ?? this.pluginOffers,
      );

  factory PluginStore.fromRawJson(String str) =>
      PluginStore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PluginStore.fromJson(Map<String, dynamic> json) => PluginStore(
        pluginId: json['PluginID'],
        pluginOffers: json['PluginOffers'] == null
            ? null
            : PluginOffers.fromJson(json['PluginOffers']),
      );

  Map<String, dynamic> toJson() => {
        'PluginID': pluginId,
        'PluginOffers': pluginOffers?.toJson(),
      };
}

class PluginOffers {
  final List<StoreOffer>? storeOffers;
  final int? remainingDurationInSeconds;

  PluginOffers({
    this.storeOffers,
    this.remainingDurationInSeconds,
  });

  PluginOffers copyWith({
    List<StoreOffer>? storeOffers,
    int? remainingDurationInSeconds,
  }) =>
      PluginOffers(
        storeOffers: storeOffers ?? this.storeOffers,
        remainingDurationInSeconds:
            remainingDurationInSeconds ?? this.remainingDurationInSeconds,
      );

  factory PluginOffers.fromRawJson(String str) =>
      PluginOffers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PluginOffers.fromJson(Map<String, dynamic> json) => PluginOffers(
        storeOffers: json['StoreOffers'] == null
            ? []
            : List<StoreOffer>.from(
                json['StoreOffers']!.map((x) => StoreOffer.fromJson(x))),
        remainingDurationInSeconds: json['RemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'StoreOffers': storeOffers == null
            ? []
            : List<dynamic>.from(storeOffers!.map((x) => x.toJson())),
        'RemainingDurationInSeconds': remainingDurationInSeconds,
      };
}

class StoreOffer {
  final PurchaseInformation? purchaseInformation;
  final List<SubOffer>? subOffers;

  StoreOffer({
    this.purchaseInformation,
    this.subOffers,
  });

  StoreOffer copyWith({
    PurchaseInformation? purchaseInformation,
    List<SubOffer>? subOffers,
  }) =>
      StoreOffer(
        purchaseInformation: purchaseInformation ?? this.purchaseInformation,
        subOffers: subOffers ?? this.subOffers,
      );

  factory StoreOffer.fromRawJson(String str) =>
      StoreOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreOffer.fromJson(Map<String, dynamic> json) => StoreOffer(
        purchaseInformation: json['PurchaseInformation'] == null
            ? null
            : PurchaseInformation.fromJson(json['PurchaseInformation']),
        subOffers: json['SubOffers'] == null
            ? []
            : List<SubOffer>.from(
                json['SubOffers']!.map((x) => SubOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'PurchaseInformation': purchaseInformation?.toJson(),
        'SubOffers': subOffers == null
            ? []
            : List<dynamic>.from(subOffers!.map((x) => x.toJson())),
      };
}

class PurchaseInformation {
  final String? dataAssetId;
  final String? offerId;
  final DateTime? startDate;
  final String? primaryCurrencyId;
  final TotalBaseCostClass? cost;
  final TotalBaseCostClass? discountedCost;
  final int? discountedPercentage;
  final List<Reward>? rewards;
  final List<dynamic>? additionalContext;
  final bool? wholesaleOnly;

  PurchaseInformation({
    this.dataAssetId,
    this.offerId,
    this.startDate,
    this.primaryCurrencyId,
    this.cost,
    this.discountedCost,
    this.discountedPercentage,
    this.rewards,
    this.additionalContext,
    this.wholesaleOnly,
  });

  PurchaseInformation copyWith({
    String? dataAssetId,
    String? offerId,
    DateTime? startDate,
    String? primaryCurrencyId,
    TotalBaseCostClass? cost,
    TotalBaseCostClass? discountedCost,
    int? discountedPercentage,
    List<Reward>? rewards,
    List<dynamic>? additionalContext,
    bool? wholesaleOnly,
  }) =>
      PurchaseInformation(
        dataAssetId: dataAssetId ?? this.dataAssetId,
        offerId: offerId ?? this.offerId,
        startDate: startDate ?? this.startDate,
        primaryCurrencyId: primaryCurrencyId ?? this.primaryCurrencyId,
        cost: cost ?? this.cost,
        discountedCost: discountedCost ?? this.discountedCost,
        discountedPercentage: discountedPercentage ?? this.discountedPercentage,
        rewards: rewards ?? this.rewards,
        additionalContext: additionalContext ?? this.additionalContext,
        wholesaleOnly: wholesaleOnly ?? this.wholesaleOnly,
      );

  factory PurchaseInformation.fromRawJson(String str) =>
      PurchaseInformation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseInformation.fromJson(Map<String, dynamic> json) =>
      PurchaseInformation(
        dataAssetId: json['DataAssetID'],
        offerId: json['OfferID'],
        startDate: json['StartDate'] == null
            ? null
            : DateTime.parse(json['StartDate']),
        primaryCurrencyId: json['PrimaryCurrencyID'],
        cost: json['Cost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['Cost']),
        discountedCost: json['DiscountedCost'] == null
            ? null
            : TotalBaseCostClass.fromJson(json['DiscountedCost']),
        discountedPercentage: json['DiscountedPercentage'],
        rewards: json['Rewards'] == null
            ? []
            : List<Reward>.from(
                json['Rewards']!.map((x) => Reward.fromJson(x))),
        additionalContext: json['AdditionalContext'] == null
            ? []
            : List<dynamic>.from(json['AdditionalContext']!.map((x) => x)),
        wholesaleOnly: json['WholesaleOnly'],
      );

  Map<String, dynamic> toJson() => {
        'DataAssetID': dataAssetId,
        'OfferID': offerId,
        'StartDate': startDate?.toIso8601String(),
        'PrimaryCurrencyID': primaryCurrencyId,
        'Cost': cost?.toJson(),
        'DiscountedCost': discountedCost?.toJson(),
        'DiscountedPercentage': discountedPercentage,
        'Rewards': rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
        'AdditionalContext': additionalContext == null
            ? []
            : List<dynamic>.from(additionalContext!.map((x) => x)),
        'WholesaleOnly': wholesaleOnly,
      };
}

class SubOffer {
  final PurchaseInformation? purchaseInformation;

  SubOffer({
    this.purchaseInformation,
  });

  SubOffer copyWith({
    PurchaseInformation? purchaseInformation,
  }) =>
      SubOffer(
        purchaseInformation: purchaseInformation ?? this.purchaseInformation,
      );

  factory SubOffer.fromRawJson(String str) =>
      SubOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubOffer.fromJson(Map<String, dynamic> json) => SubOffer(
        purchaseInformation: json['PurchaseInformation'] == null
            ? null
            : PurchaseInformation.fromJson(json['PurchaseInformation']),
      );

  Map<String, dynamic> toJson() => {
        'PurchaseInformation': purchaseInformation?.toJson(),
      };
}

class SkinsPanelLayout {
  final List<String>? singleItemOffers;
  final List<SingleItemStoreOfferElement>? singleItemStoreOffers;
  final int? singleItemOffersRemainingDurationInSeconds;

  SkinsPanelLayout({
    this.singleItemOffers,
    this.singleItemStoreOffers,
    this.singleItemOffersRemainingDurationInSeconds,
  });

  SkinsPanelLayout copyWith({
    List<String>? singleItemOffers,
    List<SingleItemStoreOfferElement>? singleItemStoreOffers,
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

  factory SkinsPanelLayout.fromRawJson(String str) =>
      SkinsPanelLayout.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SkinsPanelLayout.fromJson(Map<String, dynamic> json) =>
      SkinsPanelLayout(
        singleItemOffers: json['SingleItemOffers'] == null
            ? []
            : List<String>.from(json['SingleItemOffers']!.map((x) => x)),
        singleItemStoreOffers: json['SingleItemStoreOffers'] == null
            ? []
            : List<SingleItemStoreOfferElement>.from(
                json['SingleItemStoreOffers']!
                    .map((x) => SingleItemStoreOfferElement.fromJson(x))),
        singleItemOffersRemainingDurationInSeconds:
            json['SingleItemOffersRemainingDurationInSeconds'],
      );

  Map<String, dynamic> toJson() => {
        'SingleItemOffers': singleItemOffers == null
            ? []
            : List<dynamic>.from(singleItemOffers!.map((x) => x)),
        'SingleItemStoreOffers': singleItemStoreOffers == null
            ? []
            : List<dynamic>.from(singleItemStoreOffers!.map((x) => x.toJson())),
        'SingleItemOffersRemainingDurationInSeconds':
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

  factory UpgradeCurrencyStore.fromRawJson(String str) =>
      UpgradeCurrencyStore.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpgradeCurrencyStore.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyStore(
        upgradeCurrencyOffers: json['UpgradeCurrencyOffers'] == null
            ? []
            : List<UpgradeCurrencyOffer>.from(json['UpgradeCurrencyOffers']!
                .map((x) => UpgradeCurrencyOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'UpgradeCurrencyOffers': upgradeCurrencyOffers == null
            ? []
            : List<dynamic>.from(upgradeCurrencyOffers!.map((x) => x.toJson())),
      };
}

class UpgradeCurrencyOffer {
  final String? offerId;
  final String? storefrontItemId;
  final SingleItemStoreOfferElement? offer;
  final double? discountedPercent;

  UpgradeCurrencyOffer({
    this.offerId,
    this.storefrontItemId,
    this.offer,
    this.discountedPercent,
  });

  UpgradeCurrencyOffer copyWith({
    String? offerId,
    String? storefrontItemId,
    SingleItemStoreOfferElement? offer,
    double? discountedPercent,
  }) =>
      UpgradeCurrencyOffer(
        offerId: offerId ?? this.offerId,
        storefrontItemId: storefrontItemId ?? this.storefrontItemId,
        offer: offer ?? this.offer,
        discountedPercent: discountedPercent ?? this.discountedPercent,
      );

  factory UpgradeCurrencyOffer.fromRawJson(String str) =>
      UpgradeCurrencyOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpgradeCurrencyOffer.fromJson(Map<String, dynamic> json) =>
      UpgradeCurrencyOffer(
        offerId: json['OfferID'],
        storefrontItemId: json['StorefrontItemID'],
        offer: json['Offer'] == null
            ? null
            : SingleItemStoreOfferElement.fromJson(json['Offer']),
        discountedPercent: json['DiscountedPercent']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'OfferID': offerId,
        'StorefrontItemID': storefrontItemId,
        'Offer': offer?.toJson(),
        'DiscountedPercent': discountedPercent,
      };
}

InfoItemStore infoItemStoreFromJson(String str) =>
    InfoItemStore.fromJson(json.decode(str));

String infoItemStoreToJson(InfoItemStore data) => json.encode(data.toJson());

class InfoItemStore {
  final int? status;
  final Data? data;

  InfoItemStore({
    this.status,
    this.data,
  });

  InfoItemStore copyWith({
    int? status,
    Data? data,
  }) =>
      InfoItemStore(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory InfoItemStore.fromJson(Map<String, dynamic> json) => InfoItemStore(
        status: json['status'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

class Data {
  final String? uuid;
  final String? displayName;
  final dynamic levelItem;
  final String? displayIcon;
  final String? streamedVideo;
  final String? assetPath;
  final int? cost;

  Data({
    this.uuid,
    this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    this.assetPath,
    this.cost,
  });

  Data copyWith({
    String? uuid,
    String? displayName,
    dynamic levelItem,
    String? displayIcon,
    String? streamedVideo,
    String? assetPath,
    int? cost,
  }) =>
      Data(
        uuid: uuid ?? this.uuid,
        displayName: displayName ?? this.displayName,
        levelItem: levelItem ?? this.levelItem,
        displayIcon: displayIcon ?? this.displayIcon,
        streamedVideo: streamedVideo ?? this.streamedVideo,
        assetPath: assetPath ?? this.assetPath,
        cost: cost ?? this.cost,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json['uuid'],
        displayName: json['displayName'],
        levelItem: json['levelItem'],
        displayIcon: json['displayIcon'],
        streamedVideo: json['streamedVideo'],
        assetPath: json['assetPath'],
        cost: json['cost'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'levelItem': levelItem,
        'displayIcon': displayIcon,
        'streamedVideo': streamedVideo,
        'assetPath': assetPath,
        'cost': cost,
      };
}

class BundleInfo {
  final int? status;
  final Data? data;

  BundleInfo({
    this.status,
    this.data,
  });

  factory BundleInfo.fromRawJson(String str) =>
      BundleInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BundleInfo.fromJson(Map<String, dynamic> json) => BundleInfo(
        status: json['status'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
      };
}

class DataBundle {
  final String? uuid;
  final String? displayName;
  final dynamic displayNameSubText;
  final String? description;
  final dynamic extraDescription;
  final dynamic promoDescription;
  final bool? useAdditionalContext;
  final String? displayIcon;
  final String? displayIcon2;
  final dynamic logoIcon;
  final String? verticalPromoImage;
  final String? assetPath;

  DataBundle({
    this.uuid,
    this.displayName,
    this.displayNameSubText,
    this.description,
    this.extraDescription,
    this.promoDescription,
    this.useAdditionalContext,
    this.displayIcon,
    this.displayIcon2,
    this.logoIcon,
    this.verticalPromoImage,
    this.assetPath,
  });

  factory DataBundle.fromRawJson(String str) =>
      DataBundle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataBundle.fromJson(Map<String, dynamic> json) => DataBundle(
        uuid: json['uuid'],
        displayName: json['displayName'],
        displayNameSubText: json['displayNameSubText'],
        description: json['description'],
        extraDescription: json['extraDescription'],
        promoDescription: json['promoDescription'],
        useAdditionalContext: json['useAdditionalContext'],
        displayIcon: json['displayIcon'],
        displayIcon2: json['displayIcon2'],
        logoIcon: json['logoIcon'],
        verticalPromoImage: json['verticalPromoImage'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'displayNameSubText': displayNameSubText,
        'description': description,
        'extraDescription': extraDescription,
        'promoDescription': promoDescription,
        'useAdditionalContext': useAdditionalContext,
        'displayIcon': displayIcon,
        'displayIcon2': displayIcon2,
        'logoIcon': logoIcon,
        'verticalPromoImage': verticalPromoImage,
        'assetPath': assetPath,
      };
}
