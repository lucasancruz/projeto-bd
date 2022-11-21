import 'package:app/models/editora.dart';
import 'package:app/models/manga.dart';
import 'package:app/shared/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditoraRepository {
  final client = Http('${dotenv.env['BASE_URL']!}/editora');

  Future<bool> create(Map<String, dynamic> data) async {
    try {
      final response = await client.post('/', data: data);

      return response.data['success'];
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<List<Editora>> findAll() async {
    List<Editora> editoras = [];  

    try {
      final response = await client.get('/');

      if (response.data['success']) {
        final data = response.data['data'];

        editoras = data.map<Editora>((manga) => Editora.fromJson(manga)).toList();
      }
    } catch (e) {
      print(e);
    }
    
    return editoras;
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
}
