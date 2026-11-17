class School{
// final means the value can only be assigned once when the object is created.
// The value cannot be changed through this School object, but a new School
// object with updated values can be loaded from the database.
  final String name;
  final String address;
  final int zipCode;
  final String city;
  final String region;
  final String phoneNumber;
  final int yearFounded;
  final String website;
  final String email;
  final int numberOfClasses;
  final String levelStart;
  final String levelEnd;
  final String classQuota;
  final int numberOfStudents;
  final int? numberOfStudentsInSFO;
  final String? titleText;
  final String? descriptionText;
  final String? imageUrl;
  final bool isGrundskole;
  final bool isGymnasial;
  final double latitude;
  final double longitude;
  


  School({
    required this.name, 
    required this.address, 
    required this.zipCode, 
    required this.city,
    required this.region,
    required this.phoneNumber,
    required this.yearFounded,
    required this.website,
    required this.email,
    required this.numberOfClasses,
    required this.levelStart,
    required this.levelEnd,
    required this.classQuota,
    required this.numberOfStudents,
    this.numberOfStudentsInSFO,
    this.titleText,
    this.descriptionText,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
  }) : isGrundskole = levelEnd != '3.G',
       isGymnasial = levelStart == '1.G' || levelEnd == '3.G';
}