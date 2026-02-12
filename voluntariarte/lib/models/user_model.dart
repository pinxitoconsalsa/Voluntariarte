class UserModel {
  final String id;
  final String email;
  final String name;
  final UserType userType;
  final String? photoUrl;
  final String? phone;
  final String? bio;
  final DateTime createdAt;
  
  // Campos específicos para voluntarios
  final List<String>? skills;
  final List<String>? interests;
  final int? totalHours;
  final int? eventsCompleted;
  final List<String>? badges;
  
  // Campos específicos para organizaciones
  final String? organizationName;
  final String? description;
  final String? website;
  final String? address;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.userType,
    this.photoUrl,
    this.phone,
    this.bio,
    required this.createdAt,
    this.skills,
    this.interests,
    this.totalHours,
    this.eventsCompleted,
    this.badges,
    this.organizationName,
    this.description,
    this.website,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${json['userType']}',
      ),
      photoUrl: json['photoUrl'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      interests: (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList(),
      totalHours: json['totalHours'] as int?,
      eventsCompleted: json['eventsCompleted'] as int?,
      badges: (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList(),
      organizationName: json['organizationName'] as String?,
      description: json['description'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType.toString().split('.').last,
      'photoUrl': photoUrl,
      'phone': phone,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'skills': skills,
      'interests': interests,
      'totalHours': totalHours,
      'eventsCompleted': eventsCompleted,
      'badges': badges,
      'organizationName': organizationName,
      'description': description,
      'website': website,
      'address': address,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    UserType? userType,
    String? photoUrl,
    String? phone,
    String? bio,
    DateTime? createdAt,
    List<String>? skills,
    List<String>? interests,
    int? totalHours,
    int? eventsCompleted,
    List<String>? badges,
    String? organizationName,
    String? description,
    String? website,
    String? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      photoUrl: photoUrl ?? this.photoUrl,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      totalHours: totalHours ?? this.totalHours,
      eventsCompleted: eventsCompleted ?? this.eventsCompleted,
      badges: badges ?? this.badges,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      website: website ?? this.website,
      address: address ?? this.address,
    );
  }
}

enum UserType {
  volunteer,
  organization,
}
