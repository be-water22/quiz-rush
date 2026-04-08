import 'dart:math';
import '../models/player.dart';

/// Pool of 25 unique players to randomly draw opponents from.
class Lobby {
  static final _random = Random();

  static const _allPlayers = [
    Player(userId: 'npc-01', username: 'Aman'),
    Player(userId: 'npc-02', username: 'Priya'),
    Player(userId: 'npc-03', username: 'Rahul'),
    Player(userId: 'npc-04', username: 'Neha'),
    Player(userId: 'npc-05', username: 'Vikram'),
    Player(userId: 'npc-06', username: 'Sneha'),
    Player(userId: 'npc-07', username: 'Arjun'),
    Player(userId: 'npc-08', username: 'Kavya'),
    Player(userId: 'npc-09', username: 'Rohan'),
    Player(userId: 'npc-10', username: 'Diya'),
    Player(userId: 'npc-11', username: 'Karthik'),
    Player(userId: 'npc-12', username: 'Ananya'),
    Player(userId: 'npc-13', username: 'Siddharth'),
    Player(userId: 'npc-14', username: 'Meera'),
    Player(userId: 'npc-15', username: 'Aditya'),
    Player(userId: 'npc-16', username: 'Ishita'),
    Player(userId: 'npc-17', username: 'Manav'),
    Player(userId: 'npc-18', username: 'Tanya'),
    Player(userId: 'npc-19', username: 'Dev'),
    Player(userId: 'npc-20', username: 'Riya'),
    Player(userId: 'npc-21', username: 'Harsh'),
    Player(userId: 'npc-22', username: 'Pooja'),
    Player(userId: 'npc-23', username: 'Nikhil'),
    Player(userId: 'npc-24', username: 'Simran'),
    Player(userId: 'npc-25', username: 'Varun'),
  ];

  /// Pick [count] random opponents (excluding the current user).
  static List<Player> pickOpponents(int count) {
    final shuffled = List<Player>.from(_allPlayers)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// Pick a random number of opponents between [min] and [max] inclusive.
  static List<Player> pickRandomOpponents({int min = 4, int max = 9}) {
    final count = min + _random.nextInt(max - min + 1);
    return pickOpponents(count);
  }
}
