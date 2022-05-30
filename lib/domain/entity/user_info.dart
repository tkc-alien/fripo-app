class UserInfo {
  UserInfo({
    required this.name,
    required this.iconUrl,
  });

  factory UserInfo.fromMap(Map<dynamic, dynamic> map) {
    return UserInfo(
      name: map['name'],
      iconUrl: map['iconUrl'],
    );
  }

  final String name;
  final String iconUrl;
}
