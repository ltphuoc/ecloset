class ClosetDTO {
  final int productId;
  final int categoryId;
  final int subcategoryId;
  final int supplierId;
  final String productName;
  final String? color;
  final String? image;
  final String? productUrl;
  final String? subcategory;
  final String? supplier;

  ClosetDTO(
      {required this.productId,
      required this.categoryId,
      required this.subcategoryId,
      required this.supplierId,
      required this.productName,
      this.color,
      this.image,
      this.productUrl,
      this.subcategory,
      this.supplier});

  static fromJson(i) {
    ClosetDTO c = ClosetDTO(
      productName: i['productName'],
      productId: i['productId'],
      categoryId: i['categoryId'],
      subcategoryId: i['subcategoryId'],
      supplierId: i['supplierId'],
      color: i["color"],
      image: i["image"],
      productUrl: i["productUrl"],
      subcategory: i["subcategory"],
      supplier: i["supplier"],
    );
    return c;
  }
}
