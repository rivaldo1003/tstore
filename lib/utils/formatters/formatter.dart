import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    } else {
      return phoneNumber;
    }
  }

  // Not fully tested

  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Menghapus semua karakter non-digit dari nomor telepon
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Menentukan kode negara dari digit pertama (misalnya '+1' atau '+62')
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Buffer untuk menyusun nomor telepon terformat
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;

      // Kondisi khusus untuk kode negara AS (+1) yang menggunakan tiga digit pertama sebagai area code
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      if (end > digitsOnly.length) {
        end = digitsOnly.length;
      }

      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}
