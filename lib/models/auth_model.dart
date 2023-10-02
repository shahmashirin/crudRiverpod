class UserModel {
  final String name;
  final String profilepic;
  final String banner;
  final String uid;
  final bool isAuthenticated;
  final int karma;
  final List<String> awards;

  UserModel({
    required this.name,
    required this.profilepic,
    required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  UserModel copywith({
    String? name,
    String? profilepic,
    String? banner,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilepic: profilepic ?? this.profilepic,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilepic': profilepic,
      'banner': banner,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilepic: map['profilepic'] ?? '',
      banner: map['banner'] ?? '',
      uid: map['uid'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }





}
