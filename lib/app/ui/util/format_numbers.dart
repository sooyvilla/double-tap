extension FormatNumbers on int {
  String formatNumber() {
    return toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
  }
}

extension FormatTime on int {
  String formatTime() {
    final days = this ~/ 86400;
    final hours = (this % 86400) ~/ 3600;
    final minutes = ((this % 86400) % 3600) ~/ 60;
    final seconds = ((this % 86400) % 3600) % 60;

    if (days > 0) {
      return '$days:${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
