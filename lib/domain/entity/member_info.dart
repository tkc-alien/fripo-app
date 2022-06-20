class MemberInfo {
  MemberInfo({
    required this.name,
    required this.iconUrl,
    required this.life,
    required this.isActive,
    required this.isParticipating,
  });

  factory MemberInfo.fromMap(Map<dynamic, dynamic> map) {
    return MemberInfo(
      name: map['name'],
      iconUrl: map['iconUrl'],
      life: map['life'],
      isActive: map['isActive'],
      isParticipating: map['isParticipating'],
    );
  }

  MemberInfo copyWith({
    String? name,
    String? iconUrl,
    int? life,
    bool? isActive,
    bool? isParticipating,
  }) {
    return MemberInfo(
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      life: life ?? this.life,
      isActive: isActive ?? this.isActive,
      isParticipating: isParticipating ?? this.isParticipating,
    );
  }

  final String name;
  final String iconUrl;
  final int? life;
  final bool isActive;
  final bool isParticipating;
}
