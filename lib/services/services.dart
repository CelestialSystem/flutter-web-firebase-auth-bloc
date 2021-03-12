import 'package:flutter_web_firebase/services/auth/firebase_auth_service.dart';

abstract class Services {
  FirebaseAuthService get firebaseAuthService;
}

class ServicesImpl extends Services {
  static final ServicesImpl _services = ServicesImpl._internal();

  FirebaseAuthService _firebaseAuthService;

  ServicesImpl._internal() {
    _firebaseAuthService = FirebaseAuthService();
  }

  static ServicesImpl getInstance() => _services;

  @override
  FirebaseAuthService get firebaseAuthService => _services._firebaseAuthService;
}
