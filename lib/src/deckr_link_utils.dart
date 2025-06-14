import 'package:web/web.dart' as web;

class DeckrLinkUtils {
  static void updateAddressBar(String id) {
    web.window.history.pushState(null, '', linkUrl(id, withOrigin: false));
  }

  static String linkUrl(String id, {bool withOrigin = true}) {
    var url = '/?cmd=link';

    if (id.isNotEmpty) {
      url = '/?cmd=link&id=$id';
    }

    final origin = web.window.location.origin;

    if (!withOrigin) {
      return url;
    }

    return '$origin$url';
  }
}
