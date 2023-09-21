import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import './details_screen.dart';
import '../widgets/card_item.dart';
import '../models/card_item_model.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

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
    isLoading = true;
    setState(() {});

    final response =
        await fetchMarvelData(MARVEL_DEVELOPER_URL, MARVEL_COMICS_ENDPOINT);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['data']['results'];
      for (var data in results) {
        int id = data['id'];
        String name = data['series']['name'];
        String title = data['title'];
        String subtitle = "";
        String thumbnailUrl =
            data['thumbnail']['path'] + '.' + data['thumbnail']['extension'];
        if (!data['textObjects'].isEmpty) {
          subtitle = data['textObjects'][0]['text'];
        }
        List<dynamic> characterItems = data['characters']['items'];
        List<String> characters = characterItems
            .map((character) => character['name'].toString())
            .toList();

        CardItemModel cardItemModel = CardItemModel(
          id: id,
          name: name,
          title: title,
          subtitle: subtitle,
          thumbnailUrl: thumbnailUrl,
          characters: characters,
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Marvel Comics'),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  fetchData();
                },
              ),
            ],
          ),
        ),
        body: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: const Center(
                  child: Text(
                    'LOADING',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: cardItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(cardItem: cardItems[index]),
                          ),
                        );
                      },
                      child: CardItem(cardItem: cardItems[index]),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
