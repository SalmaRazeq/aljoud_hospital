class UserDM {
  static const String collectionName = 'Users';
  static UserDM? currentUser;
  String id;
  String email;
  String? fullName;
  String? phoneNumber;
  String? age;
  String? weight;
  String? height;

  UserDM({
    required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.age,
    this.height,
    this.weight,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  UserDM.fromFireStore(Map<String, dynamic> data) : this(
    id: data['id'],
    email: data['email'],
    fullName: data['fullName'],
    phoneNumber: data['phoneNumber'],
    age: data['age']?.toString(),
    height: data['height']?.toString(),
    weight: data['weight']?.toString(),
  );
}
