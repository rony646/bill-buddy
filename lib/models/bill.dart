class Bill {
  final String? id;
  final String title;
  final String dueDate;
  final String value;
  final List<int> notificationChannels;

  const Bill({
    this.id,
    required this.title,
    required this.dueDate,
    required this.value,
    required this.notificationChannels,
  });
}
