class BoardMember {
  String role;
  String name;
  String email;
  String phoneNumber;
  String? description;
  String imageUrl;

  BoardMember({
    required this.role,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.description,
    required this.imageUrl,
  });
}