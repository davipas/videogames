import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userGoogleProvider = StateProvider<User?>((ref) => null);
final userFirebaseProvider = StateProvider<User?>((ref) => null);
