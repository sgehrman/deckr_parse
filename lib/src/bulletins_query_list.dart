import 'dart:math' as math;

import 'package:deckr_parse/src/bulletin_utils.dart';
import 'package:deckr_parse/src/db_models/bulletin_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:flutter/material.dart';

class BulletinsQueryList extends StatefulWidget {
  const BulletinsQueryList({required this.onTap, super.key});

  final void Function(BulletinModel model) onTap;

  @override
  State<BulletinsQueryList> createState() => _BulletinsQueryListState();
}

class _BulletinsQueryListState extends State<BulletinsQueryList> {
  ParseLiveQuery<BulletinModel>? _query;
  Stream<List<BulletinModel>>? _stream;

  @override
  void initState() {
    super.initState();

    _updateQuery();
  }

  @override
  void dispose() {
    _query?.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BulletinsQueryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.keyword != oldWidget.keyword) {
    //   _updateQuery();
    // }
  }

  void _updateQuery() {
    _query?.dispose();

    _query = BulletinUtils.liveQuery();

    _stream = _query!.stream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BulletinModel>>(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return LoadingWidget(color: context.primary);
          default:
            if (snapshot.hasError) {
              return const NothingFound(message: 'Error occurred');
            } else if (!snapshot.hasData) {
              return const NothingFound();
            } else {
              final listOShit = snapshot.data!;

              return ListView.separated(
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemCount: listOShit.length,
                itemBuilder: (context, index) {
                  final model = listOShit[index];

                  final title =
                      'message: ${model.message.substring(0, math.min(40, model.message.length))}';

                  return ListTile(
                    key: Key(model.objectId),
                    title: Text(
                      title,
                      style: const TextStyle(fontWeight: Font.bold),
                    ),
                    subtitle: Text('${model.createdAt}'),
                    onTap: () {
                      widget.onTap(model);
                    },
                    trailing: DFIconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () async {
                        await BulletinUtils.delete(
                          await BulletinUtils.parseObjectForModel(model),
                        );
                      },
                    ),
                  );
                },
              );
            }
        }
      },
    );
  }
}
