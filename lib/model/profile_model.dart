class ProfileModel {
  String? uid;
  String? email;
  String? firstname;
  String? age;
  String? currency;

  ProfileModel({this.uid, this.email, this.firstname, this.age, this.currency});

  //receiving data from server
  factory ProfileModel.fromMap(map) {
    return ProfileModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstname'],
      age: map['age'],
      currency: map['currency'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'age': age,
      'currency': currency,
    };
  }
}
