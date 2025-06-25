import 'package:intl/intl.dart';

String formatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inDays == 0) {
    // Same day → show time
    return DateFormat.jm().format(timestamp); // e.g., 11:45 AM
  } else if (difference.inDays == 1) {
    return "Yesterday";
  } else if (difference.inDays < 7) {
    return DateFormat.EEEE().format(timestamp); // e.g., Monday
  } else {
    return DateFormat('dd MMM').format(timestamp); // e.g., 25 May
  }
}