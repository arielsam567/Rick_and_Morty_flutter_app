import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class HomeController extends ChangeNotifier {
  final RickAndMortyRepository _repository;

  HomeController(this._repository);

  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  // Getters
  List<Character> get characters => _filteredCharacters;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  Future<void> loadCharacters() async {
    _setLoading(true);
    _setError(null);

    final result = await _repository.getCharacters();

    result.fold(
      (error) {
        _setError(error);
        _setLoading(false);
      },
      (response) {
        _allCharacters = response.results;
        _filterCharacters();
        _setLoading(false);
      },
    );
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterCharacters();
    notifyListeners();
  }

  void _filterCharacters() {
    if (_searchQuery.isEmpty) {
      _filteredCharacters = _allCharacters;
    } else {
      _filteredCharacters = _allCharacters
          .where((character) =>
              character.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void retry() {
    loadCharacters();
  }
}
