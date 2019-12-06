class User {
  String username;
  String password;

  User({this.username, this.password});

  factory User.fromJson(Map jsonMap) {
    return User(
      username: jsonMap['username'],
      password: jsonMap['password']
    );
  }

  Map toMap() {
    var map =  Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;

    return map;
  }
}