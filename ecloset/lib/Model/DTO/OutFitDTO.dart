class OutFitDTO {
  int? outfitId;
  String? outfitName;
  int? categoryId;
  int? subcategoryId;
  int? supplierId;
  String? image;
  String? description;

  OutFitDTO(
      {this.outfitId,
      this.outfitName,
      this.categoryId,
      this.subcategoryId,
      this.supplierId,
      this.image,
      this.description});

  OutFitDTO.fromJson(Map<String, dynamic> json) {
    outfitId = json['outfitId'];
    outfitName = json['outfitName'];
    categoryId = json['categoryId'];
    subcategoryId = json['subcategoryId'];
    supplierId = json['supplierId'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outfitId'] = this.outfitId;
    data['outfitName'] = this.outfitName;
    data['categoryId'] = this.categoryId;
    data['subcategoryId'] = this.subcategoryId;
    data['supplierId'] = this.supplierId;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
