class PermissionException implements Exception {
  final String channel;
  final String message;

  const PermissionException({required this.channel, required this.message});
}
