class UserLogin {
  int id;
  String username;
  String password;
  String name;
  String surname;
  String birthday;
  String email;
  String picture;
  String dateRegister;

  UserLogin(
      {this.id,
        this.username,
        this.password,
        this.name,
        this.surname,
        this.birthday,
        this.email,
        this.picture,
        this.dateRegister});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    surname = json['surname'];
    birthday = json['birthday'];
    email = json['email'];
    picture = json['picture'];
    dateRegister = json['dateRegister'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['dateRegister'] = this.dateRegister;
    return data;
  }
}