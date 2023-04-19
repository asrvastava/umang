import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String phone;

  const User({
    required this.email,
    required this.uid,
    required this.photourl,
    required this.username,
    required this.phone,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photourl: snapshot["photoUrl"],
      phone: snapshot["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photourl,
        'bio': phone,
      };
}
