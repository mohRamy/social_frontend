import 'package:get_storage/get_storage.dart';

class FavoriteLocal {
  final _getStorage = GetStorage();
  final favoritesKey = 'favorites';
  
  void saveFavorites(List<String> favorites) async {
    _getStorage.write(favoritesKey, favorites);
  }

  List<String?> getFavorites() {
    var response = _getStorage.read(favoritesKey);    
    if (response != null) {
      List<String> favorites = [];
      List rawData = response;
      favorites = List<String>.from(rawData);
      return favorites;
    }
    return [];
  }

  void clearFavorites() async {
    _getStorage.remove(favoritesKey);
  }
}
