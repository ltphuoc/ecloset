class SubCat {
  int id;
  String name;

  SubCat({required this.id, required this.name});
}

List<SubCat> cat = [
  SubCat(id: 1, name: "Top"),
  SubCat(id: 2, name: "Pant"),
  SubCat(id: 3, name: "Footwear"),
  SubCat(id: 4, name: "Accessories"),
];

List<SubCat> topBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 1, name: "T-Shirt"),
  SubCat(id: 2, name: "Polo"),
  SubCat(id: 3, name: "Shirt"),
  SubCat(id: 4, name: "Jacket"),
  SubCat(id: 5, name: "Hoodie"),
  SubCat(id: 6, name: "Sweater"),
  SubCat(id: 7, name: "Blazer"),
];
List<SubCat> pantBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 8, name: "Short"),
  SubCat(id: 9, name: "Trousers"),
  SubCat(id: 10, name: "Jeans"),
  SubCat(id: 11, name: "Khaki"),
  SubCat(id: 12, name: "Cargo"),
];
List<SubCat> footwearBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 13, name: "Trainers"),
  SubCat(id: 14, name: "Sneakers"),
  SubCat(id: 15, name: "Boots"),
  SubCat(id: 16, name: "Sandals"),
];
List<SubCat> otherBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 17, name: "Hat"),
  SubCat(id: 18, name: "Glasses"),
  SubCat(id: 19, name: "Belt"),
  SubCat(id: 20, name: "Wallet"),
];

String getNameById(int id, List<SubCat> list) {
  for (var subCat in list) {
    if (subCat.id == id) {
      return subCat.name;
    }
  }
  return "";
}
