import 'package:app/models/manga.dart';
import 'package:app/shared/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MangaRepository {
  final client = Http('${dotenv.env['BASE_URL']!}/manga');

  Future<bool> create(Map<String, dynamic> data) async {
    try {
      final response = await client.post('/', data: data);

      return response.data['success'];
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<List<Manga>> findAll() async {
    List<Manga> mangas = [];  

    try {
      final response = await client.get('/');

      if (response.data['success']) {
        final data = response.data['data'];

        mangas = data.map<Manga>((manga) => Manga.fromJson(manga)).toList();
      }
    } catch (e) {
      print(e);
    }
    
    return mangas;
  }

  Future<Manga?> findById(int id) async {
    try {
      final response = await client.get('/$id');  

      if (response.data['success']) {
        final data = response.data['data'];

        return Manga.fromJson(data);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool> update(int id) async {
    final response = await client.put('/$id');

    if (response.data['success']) {
      return true;
    }

    return false;
  }

  Future<bool> delete(int id) async {
    final response = await client.delete('/$id');

    if (response.data['success']) {
      return true;
    }

    return false;
  }
}
