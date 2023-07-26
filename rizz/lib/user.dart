import 'dart:core';

/// Fake data class GET RID OF LATER JUST FOR TESTING
class UserData {
  final String name;
  final num age;
  final String gender;
  final String pronouns;
  final String aboutMe;
  final String profilephoto;
  final List<String> lifesytleInterests;

  UserData(
    this.name,
    this.age,
    this.gender,
    this.pronouns,
    this.aboutMe,
    this.profilephoto,
    this.lifesytleInterests,
  );
}

/// Fake data class GET RID OF LATER JUST FOR TESTING
class FakeData {
  FakeData._();

  static UserData user3 = UserData(
      'Vanessa',
      19,
      'Male',
      'he/him',
      'Hello world this is my about me section!',
      "https://randomuser.me/api/portraits/men/1.jpg", []);
}
