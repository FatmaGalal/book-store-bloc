import 'package:book_store/src/features/home/data/models/image_link_model.dart';

class VolumeInfo {
  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final num? pageCount;
  final List<String>? categories;
  final ImageLinks? imageLinks;
  final String? language;
  final String? previewLink;

  VolumeInfo({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.categories,
    this.imageLinks,
    this.language,
    this.previewLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'],
      authors: (json['authors'] as List?)?.cast<String>(),
      publisher: json['publisher'],
      publishedDate: json['publishedDate'],
      pageCount: json['pageCount'] as num,
      categories: (json['categories'] as List?)?.cast<String>(),
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'])
          : null,
      language: json['language'],
      previewLink: json['previewLink'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'authors': authors,
    'publishedDate': publishedDate,
    'pageCount': pageCount,
    'publisher': publisher,
    'categories': categories,
    'imageLinks': imageLinks?.toJson(),
    'language': language,
    'previewLink': previewLink,
  };
}
