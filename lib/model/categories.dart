class Categories {
  String? name;
  int? subCategories;

  Categories({this.name, this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subCategories = json['sub_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sub_categories'] = this.subCategories;
    return data;
  }
}
