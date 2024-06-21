class Bill {
  final String title;
  final String dueDate;
  final String value;
  final List<int> notificationChannels;
  final String? phoneToNotify;

  const Bill({
    required this.title,
    required this.dueDate,
    required this.value,
    required this.notificationChannels,
    this.phoneToNotify,
  });
}
