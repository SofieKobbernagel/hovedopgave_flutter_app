class School{
  //final means it can only be set once and cannot be changed after that.
  final String name;
  String address;
  int zipCode;
  String city;
  String phoneNumber;
  int yearFounded;
  String website;
  String email;
  int numberOfClasses;
  String levelStart;
  String levelEnd;
  String klassekvotient;
  int numberOfStudents;
  int numberOfStudentsInSFO;
  String? titleText;
  String? descriptionText;
  String? imageUrl;

  School({
    required this.name, 
    required this.address, 
    required this.zipCode, 
    required this.city,
    required this.phoneNumber,
    required this.yearFounded,
    required this.website,
    required this.email,
    required this.numberOfClasses,
    required this.levelStart,
    required this.levelEnd,
    required this.klassekvotient,
    required this.numberOfStudents,
    required this.numberOfStudentsInSFO,
    this.titleText,
    this.descriptionText,
    this.imageUrl,
  });
}