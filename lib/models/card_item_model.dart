class CardItemModel {
  final int id;
  final String name;
  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final List<String> characters;

  CardItemModel({
    required this.id,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.thumbnailUrl,
    required this.characters,
  });
}
