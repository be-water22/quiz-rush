class Player {
  final String userId;
  final String username;

  const Player({
    required this.userId,
    required this.username,
  });

  String get initial => username.isNotEmpty ? username[0].toUpperCase() : '?';

  Player copyWith({String? userId, String? username}) {
    return Player(
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }
}
