class MemberInfo {
  MemberInfo({
    required this.userId,
    required this.name,
    required this.iconUrl,
    required this.totalScore,
    required this.isActive,
    required this.isReady,
  });

  factory MemberInfo.fromMap(Map<dynamic, dynamic> map) {
    return MemberInfo(
      userId: map['userId'],
      name: map['name'],
      iconUrl: map['iconUrl'],
      totalScore: map['totalScore'],
      isActive: map['isActive'],
      isReady: map['isReady'],
    );
  }

  factory MemberInfo.copyWith(
    MemberInfo info, {
    String? userId,
    String? name,
    String? iconUrl,
    int? totalScore,
    bool? isActive,
    bool? isReady,
  }) {
    return MemberInfo(
      userId: userId ?? info.userId,
      name: name ?? info.name,
      iconUrl: iconUrl ?? info.iconUrl,
      totalScore: totalScore ?? info.totalScore,
      isActive: isActive ?? info.isActive,
      isReady: isReady ?? info.isReady,
    );
  }

  final String userId;
  final String name;
  final String iconUrl;
  final int totalScore;
  final bool isActive;
  final bool isReady;
}
