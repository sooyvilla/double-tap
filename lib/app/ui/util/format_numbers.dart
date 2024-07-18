extension FormatNumbers on int {
  String formatNumber() {
    // asignar el formato de mill (1.000, 10.000, 100.000)
    return toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
  }
}
