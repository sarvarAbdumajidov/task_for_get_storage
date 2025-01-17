class User {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      };
}
