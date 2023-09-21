import 'package:http/http.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Response> fetchMarvelData(String url, String endpoint) async {
  String publicKey = dotenv.get('MARVEL_PUBLIC_KEY');
  String privateKey = dotenv.get('MARVEL_PRIVATE_KEY');

  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final input = timestamp + privateKey + publicKey;
  final hash = md5.convert(utf8.encode(input)).toString();

  final apiUrl = Uri.https(url, endpoint, {
    'format': 'comic',
    'apikey': publicKey,
    'ts': timestamp,
    'hash': hash,
  });
  final response = await get(apiUrl);

  return response;
}
