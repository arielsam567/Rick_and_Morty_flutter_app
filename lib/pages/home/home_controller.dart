import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class HomeController extends ChangeNotifier {
  final RickAndMortyRepository _repository;

  HomeController(this._repository);

  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  String _searchQuery = '';
  int _currentPage = 1;
  bool _hasMorePages = true;
  String? _nextPageUrl;
  Timer? _debounceTimer;

  List<Character> get characters => _filteredCharacters;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasMorePages => _hasMorePages;

  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allCharacters.clear();
      _hasMorePages = true;
      _nextPageUrl = null;
    }

    if (!_hasMorePages || _isLoadingMore) {
      return;
    }

    if (_currentPage == 1) {
      _setLoading(true);
    } else {
      _setLoadingMore(true);
    }

    _setError(null);

    final result = await _repository.getCharacters(page: _currentPage);

    result.fold(
      (error) {
        _setError(error);
        _setLoading(false);
        _setLoadingMore(false);
      },
      (response) {
        if (_currentPage == 1) {
          _allCharacters = response.results;
        } else {
          _allCharacters.addAll(response.results);
        }

        _nextPageUrl = response.info.next;
        _hasMorePages = _nextPageUrl != null;
        _currentPage++;

        _filterCharacters();
        _setLoading(false);
        _setLoadingMore(false);
      },
    );
  }

  Future<void> loadMoreCharacters() async {
    if (_searchQuery.isNotEmpty) {
      return; // Não carrega mais itens durante busca
    }

    await loadCharacters();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;

    // Cancelar timer anterior
    _debounceTimer?.cancel();

    // Reset paginação quando a busca muda
    if (_searchQuery.isEmpty) {
      _currentPage = 1;
      _allCharacters.clear();
      _hasMorePages = true;
      _nextPageUrl = null;
      loadCharacters();
    } else {
      // Debounce de 500ms para evitar muitas requisições
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _filterCharacters();
        notifyListeners();
      });
    }
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

  void _setLoadingMore(bool loading) {
    _isLoadingMore = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void retry() {
    loadCharacters(refresh: true);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
