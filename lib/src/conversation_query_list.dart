import 'package:deckr_parse/src/conversation_utils.dart';
import 'package:deckr_parse/src/db_models/parse_chat_conversation_model.dart';
import 'package:deckr_parse/src/parse_live_query.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:flutter/material.dart';

class ConversationQueryList extends StatefulWidget {
  const ConversationQueryList({required this.onTap, super.key});

  final void Function(ParseChatConversationModel model) onTap;

  @override
  State<ConversationQueryList> createState() => _ConversationQueryListState();
}

class _ConversationQueryListState extends State<ConversationQueryList> {
  ParseLiveQuery<ParseChatConversationModel>? _query;
  Stream<List<ParseChatConversationModel>>? _stream;

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
  void didUpdateWidget(covariant ConversationQueryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.keyword != oldWidget.keyword) {
    //   _updateQuery();
    // }
  }

  void _updateQuery() {
    _query?.dispose();

    _query = ConversationUtils.liveQuery();

    _stream = _query!.stream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ParseChatConversationModel>>(
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

                  final title = 'members: ${model.members}';

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
                    leading: Checkbox(
                      value: model.markedAsRead,
                      onChanged: (value) {
                        ConversationUtils.setMarkedAsRead(
                          markedAsRead: value ?? false,
                          model: model,
                        );
                      },
                    ),
                    trailing: DFIconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        ConversationUtils.deleteWithMessages(model);
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
