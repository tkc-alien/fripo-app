class MemberInfo {
  MemberInfo({
    required this.name,
    required this.iconUrl,
    required this.life,
    required this.isActive,
    required this.isNotExited,
  });

  factory MemberInfo.fromMap(Map<dynamic, dynamic> map) {
    return MemberInfo(
      name: map['name'],
      iconUrl: map['iconUrl'],
      life: map['totalScore'],
      isActive: map['isActive'],
      isNotExited: map['isNotExited'],
    );
  }

  MemberInfo copyWith({
    String? name,
    String? iconUrl,
    int? life,
    bool? isActive,
    bool? isNotExited,
  }) {
    return MemberInfo(
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      life: life ?? this.life,
      isActive: isActive ?? this.isActive,
      isNotExited: isNotExited ?? this.isNotExited,
    );
  }

  final String name;
  final String iconUrl;
  final int? life;
  final bool isActive;
  final bool isNotExited;
}
