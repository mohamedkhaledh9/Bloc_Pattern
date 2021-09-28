class Character {
  late int id;
  late String name;
  late String nickName;
  late String image;
  late String birthDate;
  late List<dynamic> jobs;
  late List<dynamic> appearance;
  late String category;
  List<dynamic> bettertCallSaulAppearance;

  Character(
      {required this.id,
      required this.name,
      required this.appearance,
      required this.bettertCallSaulAppearance,
      required this.birthDate,
      required this.category,
      required this.image,
      required this.jobs,
      required this.nickName});
  factory Character.fromJson(Map<String,dynamic>jsonData){
    return Character(
      id: jsonData['char_id'],
      appearance: jsonData['appearance'],
      image: jsonData['img'],
      birthDate: jsonData['birthday'],
      category: jsonData['category'],
      jobs: jsonData['occupation'],
      name: jsonData['name'],
      nickName: jsonData['nickname'],
      bettertCallSaulAppearance: jsonData['better_call_saul_appearance'],
    );
  }
}

