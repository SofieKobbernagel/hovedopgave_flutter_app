class Employee{
  String role;
  String name;
  String? email;
  String? phone;
  int? yearAppointed;
  int? yearEmployed;
  String? other;
  String? photo;

  Employee({
    required this.role,
    required this.name,
    this.email,
    this.phone,
    this.yearAppointed,
    this.yearEmployed,
    this.other,
    this.photo,
  });
}
