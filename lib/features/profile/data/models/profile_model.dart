class ProfileModel {
  final String name;
  final String description;
  final String phone1;
  final String phone2;
  final String address;

  ProfileModel({
    required this.name,
    required this.description,
    required this.phone1,
    required this.phone2,
    required this.address,
  });

  /// Convert JSON to Model
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      address: json['address'] ?? '',
    );
  }

  /// Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'phone1': phone1,
      'phone2': phone2,
      'address': address,
    };
  }

  /// CopyWith (مهم لو بتستخدم Bloc أو Cubit)
  ProfileModel copyWith({
    String? name,
    String? description,
    String? phone1,
    String? phone2,
    String? address,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      description: description ?? this.description,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      address: address ?? this.address,
    );
  }
}
