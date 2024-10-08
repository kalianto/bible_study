class Profile {
  final String firstName;
  final String lastName;
  final String nickname;
  final String email;
  final String mobile;
  final String address;
  final String suburb;
  final String state;
  final String postcode;
  final String profileIcon;

  Profile({
    this.firstName,
    this.lastName,
    this.nickname,
    this.email,
    this.mobile,
    this.address,
    this.suburb,
    this.state,
    this.postcode,
    this.profileIcon,
  });

  String fullName() {
    return this.firstName != null && this.lastName != null
        ? this.firstName + ' ' + this.lastName
        : 'Your Name';
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      address: json['address'] as String,
      suburb: json['suburb'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      profileIcon: json['profileIcon'] as String,
    );
  }

  bool isEmpty() {
    Map<String, dynamic> _profile = this.toJson();
    return _profile.values.map((v) => v).toList().every((val) => val == null);
  }

  String getProfileIcon() {
    return this.profileIcon ?? 'userImage.png';
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'nickname': nickname,
        'email': email,
        'mobile': mobile,
        'address': address,
        'suburb': suburb,
        'state': state,
        'postcode': postcode,
        'profileIcon': profileIcon,
      };
}
