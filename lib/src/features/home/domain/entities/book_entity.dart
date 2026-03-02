import 'package:hive/hive.dart';
part 'book_entity.g.dart';

@HiveType(typeId: 0)
class BookEntity {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final String? kind;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? authors;
  @HiveField(4)
  final String? categories;
  @HiveField(5)
  final String? imageLink;
  @HiveField(6)
  final String? imageLinkLarg;
  @HiveField(7)
  final String? publisher;
  @HiveField(8)
  final String? publishedDate;
  @HiveField(9)
  final String? language;

  const BookEntity({
    required this.bookId,
    required this.kind,
    required this.title,
    required this.authors,
    required this.categories,
    required this.imageLink,
    this.imageLinkLarg,
    this.publisher,
    this.publishedDate,
    this.language,
  });
}
