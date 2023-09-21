import 'package:flutter/material.dart';
import '../widgets/detailed_card_item.dart';
import '../models/card_item_model.dart';

class DetailsScreen extends StatefulWidget {
  final CardItemModel cardItem;

  const DetailsScreen({super.key, required this.cardItem});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cardItem.name),
      ),
      body: Center(
        child: CardItem(cardItem: widget.cardItem),
      ),
    );
  }
}
