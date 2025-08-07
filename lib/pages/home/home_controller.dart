import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ricky_and_martie_app/models/character.dart';
import 'package:ricky_and_martie_app/repositories/rickandmorty_repository.dart';

class HomeController extends ChangeNotifier {
  final RickAndMortyRepository _repository;

  HomeController(this._repository) {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

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
  late ScrollController _scrollController;

  List<Character> get characters => _filteredCharacters;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get hasMorePages => _hasMorePages;
  bool get isSearchMode => _isSearchMode;
  bool get emptyState => isSearchMode && searchQuery.isNotEmpty;
  ScrollController get scrollController => _scrollController;

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMorePages && !_isLoadingMore) {
        loadMoreCharacters();
      }
    }
  }

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
      await searchCharactersByName(_searchQuery, page: _currentPage);
    } else {
      await loadCharacters();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;

    _debounceTimer?.cancel();

    if (_searchQuery.isEmpty) {
      _isSearchMode = false;
      _currentPage = 1;
      _allCharacters.clear();
      _hasMorePages = true;
      _nextPageUrl = null;
      loadCharacters();
    } else {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        searchCharactersByName(_searchQuery);
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
      searchCharactersByName(_searchQuery);
    } else {
      loadCharacters(refresh: true);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
