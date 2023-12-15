import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  NewsWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late SharedPreferences _prefs;
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = _prefs.getStringList('favorites') ?? [];
    });
  }

  _saveFavorites() {
    _prefs.setStringList('favorites', favorites);
  }

  _openFavoritesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteNewsPage(
          favorites: favorites,
          onFavoriteSelected: (String selectedUrl) {
            _showAddedToFavoritesMessage(selectedUrl);
          },
        ),
      ),
    );
  }

  _showAddedToFavoritesMessage(String url) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agregado a favoritos: $url'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  _openAllFavoritesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllFavoritesPage(favorites: favorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = favorites.contains(widget.url);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Articulo de noticias"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  favorites.remove(widget.url);
                } else {
                  favorites.add(widget.url);
                  _showAddedToFavoritesMessage(widget.url);
                }
                _saveFavorites();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _openFavoritesPage,
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _openAllFavoritesPage,
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
  
  WebView({required String initialUrl}) {}
}

class FavoriteNewsPage extends StatefulWidget {
  final List<String> favorites;
  final Function(String) onFavoriteSelected;

  FavoriteNewsPage({required this.favorites, required this.onFavoriteSelected});

  @override
  _FavoriteNewsPageState createState() => _FavoriteNewsPageState();
}

class _FavoriteNewsPageState extends State<FavoriteNewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias Favoritas'),
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.favorites[index]),
            onTap: () {
              widget.onFavoriteSelected(widget.favorites[index]);
              Navigator.pop(context);
            },
            // You can customize the list item as needed
          );
        },
      ),
    );
  }
}

class AllFavoritesPage extends StatelessWidget {
  final List<String> favorites;

  AllFavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todas las Noticias Favoritas'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index]),
            // You can customize the list item as needed
          );
        },
      ),
    );
  }
}