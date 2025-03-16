// import '../../domain/entities/user.dart';

// class UserModel extends User {
//   const UserModel({
//     required String id,
//     required String name,
//     required String email,
//     String? profileImage,
//   }) : super(
//           id: id,
//           name: name,
//           email: email,
//         );

//   // Convert JSON to Model
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as String,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       profileImage: json['profileImage'] as String?,
//     );
//   }

//   // Convert Model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }
