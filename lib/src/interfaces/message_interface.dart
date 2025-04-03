class Message {
  final String? content;
  final String? contactEmail;

  Message({
    this.contactEmail,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": contactEmail,
      "message": content
    };
  }
}