class User {
  final String address;
  final bool isAdmin;

  User({required this.address, this.isAdmin = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(address: json['address'], isAdmin: json['isAdmin'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'address': address, 'isAdmin': isAdmin};
  }
}
