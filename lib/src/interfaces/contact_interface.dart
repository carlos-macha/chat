class Contact {
  final String? email;
  final String? name;

  Contact({
    this.email,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      email: json['email'],
    );
  }
}
