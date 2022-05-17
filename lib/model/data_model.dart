class Coffee {
  String? title;
  String? description;
  List<String>? ingredients;
  int? id;

  Coffee({this.title, this.description, this.ingredients,  this.id});

  factory Coffee.fromJson(json) => Coffee(
    title : json['title'],
    description :json['description'],
    ingredients : json['ingredients'].cast<String>(),
    id : json['id']);
    
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['ingredients'] = ingredients;
    data['id'] = id;
    return data;
  }
}
