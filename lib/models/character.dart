// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LifeStatus {
  Alive,
  Dead,
  unknown,
}

class Character {
  final int id;
  final String name;
  final LifeStatus status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;
  final String origin;
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    required this.origin,
    required this.location,
  });

  //crie o copyWith
  Character copyWith({
    int? id,
    String? name,
    LifeStatus? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
    String? origin,
    String? location,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      created: created ?? this.created,
      origin: origin ?? this.origin,
      location: location ?? this.location,
    );
  }

  static LifeStatus _parseStatus(String statusString) {
    try {
      return LifeStatus.values.byName(statusString);
    } catch (e) {
      return LifeStatus.unknown;
    }
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: _parseStatus(json['status']),
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: DateTime.parse(json['created']),
      origin: json['origin']?['name'] ?? 'Unknown',
      location: json['location']?['name'] ?? 'Unknown',
    );
  }

  Color getStatusColor() {
    switch (status) {
      case LifeStatus.Alive:
        return Colors.green;
      case LifeStatus.Dead:
        return Colors.red;
      case LifeStatus.unknown:
        return Colors.grey;
    }
  }
}
