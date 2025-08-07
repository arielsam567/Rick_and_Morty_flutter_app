import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class DetailsController extends ChangeNotifier {
  final RickAndMortyRepository _repository;

  DetailsController(this._repository);

  Character? _character;
  bool _isLoading = false;
  String? _error;

  Character? get character => _character;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCharacter(int id, {Character? character}) async {
    _isLoading = true;
    _error = null;
    if (character != null) {
      _character = character;
      _isLoading = false;
      notifyListeners();
      return;
    }
    notifyListeners();

    final result = await _repository.getCharacterById(id);

    result.fold(
      (error) {
        _error = error;
        _isLoading = false;
        notifyListeners();
      },
      (character) {
        _character = character;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
