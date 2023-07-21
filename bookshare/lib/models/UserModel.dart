class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? phone;
  String? gender;
  String? Age;
  String? profilepic;

  UserModel(
      {this.uid,
      this.fullname,
      this.gender,
      this.Age,
      this.email,
      this.phone,
      this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    gender = map["gender"];
    Age = map["Age"];
    phone = map["phone"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "gender": gender,
      "Age": Age,
      "phone": phone,
      "profilepic": profilepic
    };
  }
}
