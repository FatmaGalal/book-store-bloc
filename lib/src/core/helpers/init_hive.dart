import 'package:book_store/src/core/constants/constants.dart';
import 'package:book_store/src/features/home/domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(BookEntityAdapter());
  }

  if (!Hive.isBoxOpen(kBookBox)) {
    await Hive.openBox<BookEntity>(kBookBox);
  }
  if (!Hive.isBoxOpen(kfavoriteBooksBox)) {
    await Hive.openBox<BookEntity>(kfavoriteBooksBox);
  }
}
