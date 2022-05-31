class MemberInfo {
  MemberInfo({
    required this.name,
    required this.iconUrl,
    required this.totalScore,
    required this.isActive,
  });

  factory MemberInfo.fromMap(Map<dynamic, dynamic> map) {
    return MemberInfo(
      name: map['name'],
      iconUrl: map['iconUrl'],
      totalScore: map['totalScore'],
      isActive: map['isActive'],
    );
  }

  MemberInfo copyWith({
    String? name,
    String? iconUrl,
    int? totalScore,
    bool? isActive,
  }) {
    return MemberInfo(
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      totalScore: totalScore ?? this.totalScore,
      isActive: isActive ?? this.isActive,
    );
  }

  final String name;
  final String iconUrl;
  final int totalScore;
  final bool isActive;
}
