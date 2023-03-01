class Demo {
  int? id;
  String? name;
  String? gender;
  int? age;

  Demo({this.id, this.name, this.gender, this.age});

  Demo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['age'] = age;
    return data;
  }
}
