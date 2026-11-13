class Secretary {
  String role;
  String name;
  String email;
  String phoneNumber;
  String? responsibilityArea;
  String imageUrl;

  Secretary({
    required this.role,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.responsibilityArea,
    required this.imageUrl,
  });
}