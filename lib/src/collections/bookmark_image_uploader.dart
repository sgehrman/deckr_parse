import 'package:deckr_parse/src/models/indexed_bookmark_model.dart';
import 'package:deckr_parse/src/parse_utils.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class BookmarkImageUploader {
  static Future<Map<String, ParseFileBase>> uploadBookmarkImages({
    required List<IndexedBookmarkModel> bookmarks,
    required Uri? Function(IndexedBookmarkModel) imageUri,
  }) async {
    final images = <String, ParseFileBase>{};

    for (final bookmark in bookmarks) {
      final uri = imageUri(bookmark);

      if (uri != null) {
        final parseFile = await _upload(uri);

        if (parseFile != null) {
          images[bookmark.bookmark.key] = parseFile;
        }
      }
    }

    return images;
  }

  static Future<ParseFileBase?> _upload(Uri imageUri) async {
    try {
      final data = await HttpUtils.httpGetStream(imageUri);

      if (data.isNotEmpty) {
        final png = await ImageProcessor.pngFromBytes(data, maxSize: 256);

        if (png.bytes.isNotEmpty) {
          final parseFile = ParseWebFile(
            png.bytes,
            name: 'bm-${Utils.uniqueFirestoreId()}.png',
          );

          final response = await parseFile.save();

          if (response.success) {
            return parseFile;
          } else {
            ParseUtils.printParseError(
              response,
              contextInfo: 'BookmarkImageUploader _upload failed',
            );
          }
        }
      }
    } catch (err) {
      print('BookmarkImageUploader _upload catch: $err');
    }

    print('BookmarkImageUploader _upload failed: Image data is empty.');

    return null;
  }
}
