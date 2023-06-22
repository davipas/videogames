import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserContextGoogle {
  final User? user;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  UserContextGoogle({
    required this.user,
    required this.auth,
    required this.googleSignIn
  });
  
}