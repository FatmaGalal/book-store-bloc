// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookEntityAdapter extends TypeAdapter<BookEntity> {
  @override
  final int typeId = 0;

  @override
  BookEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookEntity(
      bookId: fields[0] as String,
      kind: fields[1] as String?,
      title: fields[2] as String?,
      authors: fields[3] as String?,
      categories: fields[4] as String?,
      imageLink: fields[5] as String?,
      imageLinkLarg: fields[6] as String?,
      publisher: fields[7] as String?,
      publishedDate: fields[8] as String?,
      language: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.kind)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.categories)
      ..writeByte(5)
      ..write(obj.imageLink)
      ..writeByte(6)
      ..write(obj.imageLinkLarg)
      ..writeByte(7)
      ..write(obj.publisher)
      ..writeByte(8)
      ..write(obj.publishedDate)
      ..writeByte(9)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
