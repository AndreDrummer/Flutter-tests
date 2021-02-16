import 'dart:convert';
import 'package:http/http.dart' as http;

class Album {
  dynamic data;
  Album.fromJson(this.data);
}

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Album');
  }
}
