class NotificationItem {
  final String title;
  final String message;
  final String label;
  final String dateTime;

  NotificationItem({
    required this.title,
    required this.message,
    required this.label,
    required this.dateTime,
  });
}

List<NotificationItem> notifikasi = [
  NotificationItem(
    title: 'Terjadi Begal disekitar Anda!',
    message:
    'Hati-hati ketika melewati Simpang Tiga Kampus USU. Tekan notifikasi untuk melihat detail dan tindakan pencegahan.',
    label: 'Baru',
    dateTime: '2/6/2024 (19:45:20 WIB)',
  ),
  NotificationItem(
    title: 'Terjadi Jambret disekitar Anda!',
    message:
    'Hati-hati melewati Jalan Dr. Mansyur. Tekan notifikasi untuk melihat detail dan tindakan pencegahan.',
    label: '',
    dateTime: '2/6/2024 (18:35:32 WIB)',
  ),
  NotificationItem(
    title: 'Terjadi Pembacokan disekitar Anda!',
    message:
    'Hati-hati melewati Jalan Iskandar Muda. Tekan notifikasi untuk melihat detail dan tindakan pencegahan.',
    label: '',
    dateTime: '2/6/2024 (17:25:34 WIB)',
  ),
];