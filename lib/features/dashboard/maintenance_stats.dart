import 'dart:convert';
import '../../data/db/app_database.dart';

/// Logs arrive newest-first, so the first match is the latest.
LogEntry? latestOfType(List<LogEntry> logs, String type) {
  for (final l in logs) {
    if (l.type == type) return l;
  }
  return null;
}

Map<String, dynamic> payloadOf(LogEntry e) =>
    jsonDecode(e.payload) as Map<String, dynamic>;
