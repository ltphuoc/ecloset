class ClosetDTO {
  Result? result;
  int? id;
  int? exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  int? asyncState;
  bool? isFaulted;

  ClosetDTO(
      {this.result,
      this.id,
      this.exception,
      this.status,
      this.isCanceled,
      this.isCompleted,
      this.isCompletedSuccessfully,
      this.creationOptions,
      this.asyncState,
      this.isFaulted});

  ClosetDTO.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['isCompletedSuccessfully'] = this.isCompletedSuccessfully;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}

class Result {
  Metadata? metadata;
  List<ClosetData>? data;

  Result({this.metadata, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <ClosetData>[];
      json['data'].forEach((v) {
        data!.add(new ClosetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int? page;
  int? size;
  int? total;

  Metadata({this.page, this.size, this.total});

  Metadata.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}

class ClosetData {
  int? productId;
  String? productName;
  int? categoryId;
  int? subcategoryId;
  int? supplierId;
  String? color;
  String? image;
  String? productUrl;

  ClosetData(
      {this.productId,
      this.productName,
      this.categoryId,
      this.subcategoryId,
      this.supplierId,
      this.color,
      this.image,
      this.productUrl});

  ClosetData.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    categoryId = json['categoryId'];
    subcategoryId = json['subcategoryId'];
    supplierId = json['supplierId'];
    color = json['color'];
    image = json['image'];
    productUrl = json['productUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['categoryId'] = this.categoryId;
    data['subcategoryId'] = this.subcategoryId;
    data['supplierId'] = this.supplierId;
    data['color'] = this.color;
    data['image'] = this.image;
    data['productUrl'] = this.productUrl;
    return data;
  }
}
