import 'package:dfc_flutter/dfc_flutter_web.dart';

class DeckrLinkUtils {
  static void updateAddressBar(String id) {
    WebUtils().historyPushState(linkUrl(id, withOrigin: false));
  }

  static String linkUrl(String id, {bool withOrigin = true}) {
    var url = '/?cmd=link';

    if (id.isNotEmpty) {
      url = '/?cmd=link&id=$id';
    }

    final origin = WebUtils().locationOrigin();

    if (!withOrigin) {
      return url;
    }

    return '$origin$url';
  }
}
