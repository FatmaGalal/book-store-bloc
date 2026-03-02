import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_store/src/features/authentication/data/auth_service.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential])
void main() {
  late MockFirebaseAuth mockAuth;
  late AuthService authService;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    authService = AuthService(auth: mockAuth);
  });

  test('signIn calls Firebase correctly', () async {
    when(
      mockAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => MockUserCredential());

    await authService.signIn(email: 'test@test.com', password: '123456');

    verify(
      mockAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: '123456',
      ),
    ).called(1);
  });
}
