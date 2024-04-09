class Bill {
  final String title;
  final String dueDate;
  final List<int> notificationChannels;

  const Bill({
    required this.title,
    required this.dueDate,
    required this.notificationChannels,
  });
}
