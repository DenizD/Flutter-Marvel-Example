import 'package:flutter/material.dart';
import '../models/card_item_model.dart';

class CardItem extends StatelessWidget {
  final CardItemModel cardItem;

  const CardItem({super.key, required this.cardItem});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                cardItem.thumbnailUrl,
                fit: BoxFit.cover,
                height: 500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    textAlign: TextAlign.justify,
                    cardItem.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    textAlign: TextAlign.justify,
                    cardItem.subtitle,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  cardItem.characters.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              textAlign: TextAlign.start,
                              'CHARACTERS',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView(
                                children: cardItem.characters.map((item) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
