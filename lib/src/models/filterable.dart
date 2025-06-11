import 'package:json_annotation/json_annotation.dart';

class Filterable {
  Filterable(
    String field, {
    String second = '',
    String third = '',
    String forth = '',
  })  : firstField = field.toLowerCase(),
        secondField = second.toLowerCase(),
        thirdField = third.toLowerCase(),
        forthField = forth.toLowerCase();

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String firstField;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String secondField;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String thirdField;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String forthField;

  bool containsFilter(String filter) {
    return firstField.contains(filter) ||
        secondField.contains(filter) ||
        thirdField.contains(filter) ||
        forthField.contains(filter);
  }

  // assuming filter lowercase already
  static List<T> filter<T extends Filterable>(
      {required String filter,
      required List<T> list,
      bool matchesOnly = true}) {
    if (filter.isNotEmpty) {
      var matches = <T>[];
      final noMatches = <T>[];

      if (matchesOnly) {
        matches = list.where((e) {
          return e.containsFilter(filter);
        }).toList();
      } else {
        for (final e in list) {
          if (e.containsFilter(filter)) {
            matches.add(e);
          } else {
            noMatches.add(e);
          }
        }
      }

      matches.sort((a, b) {
        final aStarts = a.firstField.startsWith(filter);
        final bStarts = b.firstField.startsWith(filter);

        if (aStarts && !bStarts) {
          return -1;
        } else if (!aStarts && bStarts) {
          return 1;
        }

        return a.firstField.compareTo(b.firstField);
      });

      return [...matches, ...noMatches];
    } else {
      return list;
    }
  }
}
