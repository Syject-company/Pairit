class User {
  String id;
  String email;
  String phoneNumber1;
  String phoneNumber2;
  String address;
  String company;
  String position;
  String profileImage;
  String companyLogo;
  String firstName;
  String lastName;
  String socialLink1;
  String socialLink2;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber1,
    this.phoneNumber2,
    this.socialLink1,
    this.socialLink2,
    this.address,
    this.position,
    this.company,
    this.companyLogo,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phoneNumber1: json['phoneNumber'],
      phoneNumber2: json['secondPhoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      profileImage: json['profileImage'] ?? '',
      company: json['companyName'],
      companyLogo: json['companyLogo'] ?? '',
      position: json['position'],
      socialLink1: json['facebookLink'],
      socialLink2: json['instagramLink'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName}';
  }
}