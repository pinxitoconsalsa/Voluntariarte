class EventModel {
  final String id;
  final String title;
  final String description;
  final String organizationId;
  final String organizationName;
  final DateTime date;
  final String location;
  final double latitude;
  final double longitude;
  final int maxVolunteers;
  final int currentVolunteers;
  final List<String> requiredSkills;
  final String category;
  final String? imageUrl;
  final int estimatedHours;
  final bool isActive;
  final DateTime createdAt;
  final List<String> registeredVolunteers;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.organizationId,
    required this.organizationName,
    required this.date,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.maxVolunteers,
    required this.currentVolunteers,
    required this.requiredSkills,
    required this.category,
    this.imageUrl,
    required this.estimatedHours,
    required this.isActive,
    required this.createdAt,
    required this.registeredVolunteers,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      organizationId: json['organizationId'] as String,
      organizationName: json['organizationName'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      maxVolunteers: json['maxVolunteers'] as int,
      currentVolunteers: json['currentVolunteers'] as int,
      requiredSkills: (json['requiredSkills'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String?,
      estimatedHours: json['estimatedHours'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      registeredVolunteers: (json['registeredVolunteers'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'date': date.toIso8601String(),
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'maxVolunteers': maxVolunteers,
      'currentVolunteers': currentVolunteers,
      'requiredSkills': requiredSkills,
      'category': category,
      'imageUrl': imageUrl,
      'estimatedHours': estimatedHours,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'registeredVolunteers': registeredVolunteers,
    };
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? organizationId,
    String? organizationName,
    DateTime? date,
    String? location,
    double? latitude,
    double? longitude,
    int? maxVolunteers,
    int? currentVolunteers,
    List<String>? requiredSkills,
    String? category,
    String? imageUrl,
    int? estimatedHours,
    bool? isActive,
    DateTime? createdAt,
    List<String>? registeredVolunteers,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      date: date ?? this.date,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      maxVolunteers: maxVolunteers ?? this.maxVolunteers,
      currentVolunteers: currentVolunteers ?? this.currentVolunteers,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      registeredVolunteers: registeredVolunteers ?? this.registeredVolunteers,
    );
  }

  bool get isFull => currentVolunteers >= maxVolunteers;
  
  int get availableSpots => maxVolunteers - currentVolunteers;
}
