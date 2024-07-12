// class Product {
//   final String id;
//   final String name;
//   // final String imageUrl;
//   final String dateCreated;
//   final bool status;

//   Product({
//     required this.id,
//     required this.name,
//     // required this.imageUrl,
//     required this.dateCreated,
//     required this.status,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['unique_id'],
//       name: json['name'],
//       // imageUrl: json['imageUrl'],
//       dateCreated: json['date_created'],
//       status: json['is_available'],
//     );
//   }
// }



class Product {
  int page;
  int size;
  int total;
  dynamic debug;
  dynamic previousPage;
  dynamic nextPage;
  List<Item> items;

  Product({
    required this.page,
    required this.size,
    required this.total,
    this.debug,
    this.previousPage,
    this.nextPage,
    required this.items,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      page: json['page'],
      size: json['size'],
      total: json['total'],
      debug: json['debug'],
      previousPage: json['previous_page'],
      nextPage: json['next_page'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
    );
  }

  // get currentPrice => currentPrice;

  // get productImage => productImage;

  // get name => name;

  // get isAvailable => isAvailable;
}

class Item {
  String name;
  String? description;
  String uniqueId;
  String urlSlug;
  bool isAvailable;
  bool isService;
  bool unavailable;
  String id;
  String? parentProductId;
  String? parent;
  String organizationId;
  List<String> productImage;
  List<String> categories;
  DateTime dateCreated;
  DateTime lastUpdated;
  String userId;
  List<Photo> photos;
  List<Price> currentPrice;
  bool isDeleted;
  double availableQuantity;
  double? sellingPrice;
  double? discountedPrice;
  double? buyingPrice;
  dynamic extraInfos;

  Item({
    required this.name,
    this.description,
    required this.uniqueId,
    required this.urlSlug,
    required this.isAvailable,
    required this.isService,
    required this.unavailable,
    required this.id,
    this.parentProductId,
    this.parent,
    required this.organizationId,
    required this.productImage,
    required this.categories,
    required this.dateCreated,
    required this.lastUpdated,
    required this.userId,
    required this.photos,
    required this.currentPrice,
    required this.isDeleted,
    required this.availableQuantity,
    this.sellingPrice,
    this.discountedPrice,
    this.buyingPrice,
    this.extraInfos,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      uniqueId: json['unique_id'],
      urlSlug: json['url_slug'],
      isAvailable: json['is_available'],
      isService: json['is_service'],
      unavailable: json['unavailable'],
      id: json['id'],
      parentProductId: json['parent_product_id'],
      parent: json['parent'],
      organizationId: json['organization_id'],
      productImage: List<String>.from(json['product_image']),
      categories: List<String>.from(json['categories']),
      dateCreated: DateTime.parse(json['date_created']),
      lastUpdated: DateTime.parse(json['last_updated']),
      userId: json['user_id'],
      photos: List<Photo>.from(
          json['photos'].map((photo) => Photo.fromJson(photo))),
      currentPrice: List<Price>.from(
          json['current_price'].map((price) => Price.fromJson(price))),
      isDeleted: json['is_deleted'],
      availableQuantity: json['available_quantity'].toDouble(),
      sellingPrice: json['selling_price']?.toDouble(),
      discountedPrice: json['discounted_price']?.toDouble(),
      buyingPrice: json['buying_price']?.toDouble(),
      extraInfos: json['extra_infos'],
    );
  }
}

class Photo {
  String modelName;
  String modelId;
  String organizationId;
  String filename;
  String url;
  bool isFeatured;
  bool saveAsJpg;
  bool isPublic;
  bool fileRename;
  int position;

  Photo({
    required this.modelName,
    required this.modelId,
    required this.organizationId,
    required this.filename,
    required this.url,
    required this.isFeatured,
    required this.saveAsJpg,
    required this.isPublic,
    required this.fileRename,
    required this.position,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      modelName: json['model_name'],
      modelId: json['model_id'],
      organizationId: json['organization_id'],
      filename: json['filename'],
      url: json['url'],
      isFeatured: json['is_featured'],
      saveAsJpg: json['save_as_jpg'],
      isPublic: json['is_public'],
      fileRename: json['file_rename'],
      position: json['position'],
    );
  }
}

class Price {
  Map<String, dynamic> prices;

  Price({
    required this.prices,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      prices: Map<String, dynamic>.from(json),
    );
  }
}