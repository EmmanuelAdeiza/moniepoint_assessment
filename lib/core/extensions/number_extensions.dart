extension NumberFormatting on num {
  String get formatWithThousandSeparator {
    final parts = toString().split('.');
    final wholePart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = wholePart.replaceAllMapped(regex, (match) => '${match[1]} ');

    return formatted + decimalPart;
  }
}
