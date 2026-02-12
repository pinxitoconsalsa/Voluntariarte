class BadgeModel {
  final String id;
  final String name;
  final String description;
  final String iconName;
  final BadgeCategory category;
  final int requiredPoints;
  final bool isEarned;
  final DateTime? earnedDate;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconName,
    required this.category,
    required this.requiredPoints,
    required this.isEarned,
    this.earnedDate,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      category: BadgeCategory.values.firstWhere(
        (e) => e.toString() == 'BadgeCategory.${json['category']}',
      ),
      requiredPoints: json['requiredPoints'] as int,
      isEarned: json['isEarned'] as bool,
      earnedDate: json['earnedDate'] != null 
          ? DateTime.parse(json['earnedDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'category': category.toString().split('.').last,
      'requiredPoints': requiredPoints,
      'isEarned': isEarned,
      'earnedDate': earnedDate?.toIso8601String(),
    };
  }

  BadgeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? iconName,
    BadgeCategory? category,
    int? requiredPoints,
    bool? isEarned,
    DateTime? earnedDate,
  }) {
    return BadgeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      category: category ?? this.category,
      requiredPoints: requiredPoints ?? this.requiredPoints,
      isEarned: isEarned ?? this.isEarned,
      earnedDate: earnedDate ?? this.earnedDate,
    );
  }
}

enum BadgeCategory {
  environmental,
  social,
  educational,
  community,
  milestone,
}
