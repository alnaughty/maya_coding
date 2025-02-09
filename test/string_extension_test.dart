import 'package:flutter_test/flutter_test.dart';
import 'package:maya_coding_test/core/extensions/num.dart';
import 'package:maya_coding_test/core/extensions/string.dart';

void main() {
  group('Currency Format Tests', () {
    test('Formats currency correctly', () {
      expect(10000.toAmount(), '₱10,000.00');
      expect(1234.56.toAmount(), '₱1,234.56');
      expect(100.5.toAmount(), '₱100.50');
    });

    test("Obscure numerical currency", () {
      expect(100000.toAmount(isObscured: true), "₱***,***.**");
      expect(10000.toAmount(isObscured: true), "₱**,***.**");
      expect(1000.toAmount(isObscured: true), "₱*,***.**");
      expect(500.toAmount(isObscured: true), "₱***.**");
      expect(10.toAmount(isObscured: true), "₱**.**");
      expect(5.toAmount(isObscured: true), "₱*.**");
    });
  });
  group('Money Validation Tests', () {
    test('Valid money amounts', () {
      expect('1000.54'.isValidMoneyAmount(), true);
      expect('1000'.isValidMoneyAmount(), true);
      expect('100'.isValidMoneyAmount(), true);
      expect('100.2'.isValidMoneyAmount(), true);
      expect('1'.isValidMoneyAmount(), true);
      expect('1.5'.isValidMoneyAmount(), true);
      expect('1.64'.isValidMoneyAmount(), true);
      expect('12.3'.isValidMoneyAmount(), true);
      expect('10000'.isValidMoneyAmount(), true);
      expect('10000.23'.isValidMoneyAmount(), true);
    });

    test('Invalid money amounts', () {
      expect('0100.'.isValidMoneyAmount(), false);
      expect('100.'.isValidMoneyAmount(), false);
      expect('1,99'.isValidMoneyAmount(), false);
      expect('100.999'.isValidMoneyAmount(), false);
      expect('.50'.isValidMoneyAmount(), false);
    });
  });

  group('Email Validation Tests', () {
    test('Valid email formats', () {
      expect('sample@email.com'.isValidEmail, true);
      expect('sample@gmail.fr'.isValidEmail, true);
      expect('sample@email.ph'.isValidEmail, true);
      expect('sample@email.au'.isValidEmail, true);
    });

    test('Invalid email formats', () {
      expect('e@e.co76854865m'.isValidEmail, false);
      expect('e@e.8970'.isValidEmail, false);
      expect('e@e.p'.isValidEmail, false);
      expect('e@e.'.isValidEmail, false);
    });
  });
}
