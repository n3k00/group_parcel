import 'package:firebase_auth/firebase_auth.dart';

import '../constants/auth_strings.dart';
import '../../features/auth/models/auth_user.dart';

class AuthService {
  AuthService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<AppAuthUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_toAuthUser);
  }

  AppAuthUser? get currentUser => _toAuthUser(_firebaseAuth.currentUser);

  Future<AppAuthUser> signInWithPhonePassword({
    required String phoneNumber,
    required String password,
  }) async {
    final normalizedPhone = AuthService.normalizePhoneNumber(phoneNumber);
    final pseudoEmail = AuthService.toPseudoEmail(normalizedPhone);

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: pseudoEmail,
        password: password,
      );
      final user = _toAuthUser(credential.user);
      if (user == null) {
        throw StateError(AuthStrings.unknownLoginError);
      }
      return user;
    } on FirebaseAuthException catch (error) {
      throw StateError(_messageForAuthException(error));
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  static String normalizePhoneNumber(String input) {
    final trimmed = input.trim();
    final sanitized = trimmed.replaceAll(RegExp(r'[\s-]'), '');

    if (sanitized.isEmpty) {
      throw StateError(AuthStrings.missingPhoneNumber);
    }
    if (!sanitized.startsWith('09')) {
      throw StateError(AuthStrings.invalidPhonePrefix);
    }
    if (!RegExp(r'^\d+$').hasMatch(sanitized)) {
      throw StateError(AuthStrings.invalidPhoneCharacters);
    }

    return sanitized;
  }

  static String toPseudoEmail(String normalizedPhoneNumber) {
    return '$normalizedPhoneNumber@${AuthStrings.pseudoEmailDomain}';
  }

  static String deriveAccountCodeFromPhone(String normalizedPhoneNumber) {
    final phone = normalizePhoneNumber(normalizedPhoneNumber);
    if (phone.length <= 3) {
      return phone;
    }
    return phone.substring(phone.length - 3);
  }

  AppAuthUser? _toAuthUser(User? user) {
    if (user == null) {
      return null;
    }

    final email = user.email ?? '';
    final suffix = '@${AuthStrings.pseudoEmailDomain}';
    final phoneNumber = email.endsWith(suffix)
        ? email.substring(0, email.length - suffix.length)
        : email;

    return AppAuthUser(
      uid: user.uid,
      phoneNumber: phoneNumber,
      pseudoEmail: email,
    );
  }

  String _messageForAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-email':
        return AuthStrings.invalidCredentials;
      case 'user-disabled':
        return AuthStrings.disabledAccount;
      case 'too-many-requests':
        return AuthStrings.tooManyRequests;
      case 'network-request-failed':
        return AuthStrings.networkError;
      default:
        return error.message?.trim().isNotEmpty == true
            ? error.message!.trim()
            : AuthStrings.unknownLoginError;
    }
  }
}
