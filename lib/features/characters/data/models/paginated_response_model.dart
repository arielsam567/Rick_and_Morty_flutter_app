import 'package:ricky_and_martie_app/features/characters/data/models/character_model.dart';

class PaginatedResponseModel<T> {
  final InfoModel info;
  final List<T> results;

  const PaginatedResponseModel({
    required this.info,
    required this.results,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponseModel<T>(
      info: InfoModel.fromJson(json['info']),
      results:
          (json['results'] as List).map((item) => fromJsonT(item)).toList(),
    );
  }
}

class InfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const InfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}
