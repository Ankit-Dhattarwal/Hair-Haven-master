class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class SignUp {
  final String username;
  final String email;
  final String password;

  SignUp({required this.username, required this.email, required this.password});

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
  };
}



