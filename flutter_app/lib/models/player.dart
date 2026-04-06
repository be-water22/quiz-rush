class Player {
  final String userId;
  final String username;
  final int rating;

  const Player({
    required this.userId,
    required this.username,
    this.rating = 1500,
  });

  String get initial => username.isNotEmpty ? username[0].toUpperCase() : '?';

  Player copyWith({String? userId, String? username, int? rating}) {
    return Player(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      rating: rating ?? this.rating,
    );
  }
}
