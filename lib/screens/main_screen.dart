import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import '../widgets/card_item.dart';
import '../models/card_item_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CardItemModel> cardItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String marvelPublicKey = dotenv.get('MARVEL_PUBLIC_KEY');
    String marvelPrivateKey = dotenv.get('MARVEL_PRIVATE_KEY');
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final input = timestamp + marvelPrivateKey + marvelPublicKey;
    final hash = md5.convert(utf8.encode(input)).toString();

    final apiUrl = Uri.https('gateway.marvel.com', '/v1/public/comics', {
      'format': 'comic',
      'apikey': marvelPublicKey,
      'ts': timestamp,
      'hash': hash,
    });
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['data']['results'];
      for (var data in results) {
        String title = data['title'];
        String subtitle = "";
        String thumbnailUrl =
            data['thumbnail']['path'] + '.' + data['thumbnail']['extension'];
        if (!data['textObjects'].isEmpty) {
          subtitle = data['textObjects'][0]['text'];
        }
        CardItemModel cardItemModel = CardItemModel(
          title: title,
          subtitle: subtitle,
          thumbnailUrl: thumbnailUrl,
        );
        cardItems.add(cardItemModel);
      }
      isLoading = false;
      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Marvel Characters'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: cardItems.length,
            itemBuilder: (context, index) {
              return CardItem(cardItem: cardItems[index]);
            },
          ),
        ),
      ),
    );
  }
}
