import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/constants/auth_strings.dart';
import 'package:group_mobile/core/services/auth_service.dart';

void main() {
  test('normalizes phone number by removing spaces and dashes', () {
    final normalized = AuthService.normalizePhoneNumber('09 421-000-111');

    expect(normalized, '09421000111');
    expect(
      AuthService.toPseudoEmail(normalized),
      '09421000111@${AuthStrings.pseudoEmailDomain}',
    );
  });

  test('derives account code from last 3 phone digits', () {
    final accountCode = AuthService.deriveAccountCodeFromPhone(
      '09 421-000-123',
    );

    expect(accountCode, '123');
  });

  test('rejects phone number that does not start with 09', () {
    expect(
      () => AuthService.normalizePhoneNumber(
        '0942000000'.replaceFirst('09', '95'),
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          AuthStrings.invalidPhonePrefix,
        ),
      ),
    );
  });

  test('rejects phone number with invalid characters', () {
    expect(
      () => AuthService.normalizePhoneNumber('09ABC123'),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          AuthStrings.invalidPhoneCharacters,
        ),
      ),
    );
  });
}
