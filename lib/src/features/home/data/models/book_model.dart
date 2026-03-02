import 'package:book_store/src/features/home/data/models/acess_info.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:book_store/src/features/home/data/models/sale_info.dart';
import 'package:book_store/src/features/home/data/models/search_info.dart';
import 'package:book_store/src/features/home/data/models/volume_model.dart';

class BookModel extends BookEntity {
  @override
  final String? kind;
  final String id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo? volumeInfo;
  final SaleInfo? saleInfo;
  final AccessInfo? accessInfo;
  final SearchInfo? searchInfo;

  BookModel({
    required this.id,
    this.kind,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  }) : super(
         bookId: id,
         kind: kind,
         title: volumeInfo?.title ?? '',
         authors: (volumeInfo?.authors?.isNotEmpty ?? false)
             ? volumeInfo!.authors!.first
             : '',
         categories: (volumeInfo?.categories?.isNotEmpty ?? false)
             ? volumeInfo!.categories!.first
             : '',
         imageLink: volumeInfo?.imageLinks?.smallThumbnail ?? '',
         imageLinkLarg: volumeInfo?.imageLinks?.medium ?? '',
         publisher: volumeInfo?.publisher??'',
         publishedDate: volumeInfo?.publishedDate??'',
         language: volumeInfo?.language??'',
       );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      kind: json['kind'],
      id: json['id'],
      etag: json['etag'],
      selfLink: json['selfLink'],
      volumeInfo: json['volumeInfo'] != null
          ? VolumeInfo.fromJson(json['volumeInfo'])
          : null,
      saleInfo: json['saleInfo'] != null
          ? SaleInfo.fromJson(json['saleInfo'])
          : null,
      accessInfo: json['accessInfo'] != null
          ? AccessInfo.fromJson(json['accessInfo'])
          : null,
      searchInfo: json['searchInfo'] != null
          ? SearchInfo.fromJson(json['searchInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo?.toJson(),
    'saleInfo': saleInfo?.toJson(),
    'accessInfo': accessInfo?.toJson(),
    'searchInfo': searchInfo?.toJson(),
  };
}
