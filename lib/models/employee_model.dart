class Employee{
  String role;
  String name;
  String? email;
  String? phoneNumber;
  int? yearAppointed;
  int? yearEmployed;
  String? other;
  String? imageUrl;

  Employee({
    required this.role,
    required this.name,
    this.email,
    this.phoneNumber,
    this.yearAppointed,
    this.yearEmployed,
    this.other,
    this.imageUrl,
  });
}
