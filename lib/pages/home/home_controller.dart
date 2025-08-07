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
  bool _isSearchMode = false;

  List<Character> get characters => _filteredCharacters;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasMorePages => _hasMorePages;
  bool get isSearchMode => _isSearchMode;

  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allCharacters.clear();
      _hasMorePages = true;
      _nextPageUrl = null;
      _isSearchMode = false;
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

  Future<void> searchCharactersByName(String name, {int page = 1}) async {
    if (page == 1) {
      _setLoading(true);
      _currentPage = 1;
      _allCharacters.clear();
    } else {
      _setLoadingMore(true);
    }

    _setError(null);
    _isSearchMode = true;

    final result = await _repository.searchCharactersByName(name, page: page);

    result.fold(
      (error) {
        if (error == 'Nenhum resultado encontrado') {
          _allCharacters = [];
          _filteredCharacters = [];
          _hasMorePages = false;
          _nextPageUrl = null;
          _currentPage = 1;
        } else {
          _setError(error);
        }
        _setLoading(false);
        _setLoadingMore(false);
      },
      (response) {
        if (page == 1) {
          _allCharacters = response.results;
        } else {
          _allCharacters.addAll(response.results);
        }

        _filteredCharacters = _allCharacters;
        _hasMorePages = response.info.next != null;
        _nextPageUrl = response.info.next;
        _currentPage = page + 1;
        _setLoading(false);
        _setLoadingMore(false);
      },
    );
  }

  Future<void> loadMoreCharacters() async {
    if (!_hasMorePages || _isLoadingMore) {
      return;
    }

    if (_isSearchMode) {
      // Em modo de busca, carrega mais itens da busca
      await searchCharactersByName(_searchQuery, page: _currentPage);
    } else {
      // Em modo normal, carrega mais itens da lista geral
      await loadCharacters();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;

    // Cancelar timer anterior
    _debounceTimer?.cancel();

    // Reset paginação quando a busca muda
    if (_searchQuery.isEmpty) {
      _isSearchMode = false;
      _currentPage = 1;
      _allCharacters.clear();
      _hasMorePages = true;
      _nextPageUrl = null;
      loadCharacters();
    } else {
      // Debounce de 500ms para evitar muitas requisições
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        searchCharactersByName(_searchQuery, page: 1);
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
    if (_isSearchMode) {
      searchCharactersByName(_searchQuery, page: 1);
    } else {
      loadCharacters(refresh: true);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
