import 'package:deckr_parse/l10n/app_localizations.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:flutter/widgets.dart';

class CollectionKeywords {
  List<NameIdDescription> keywords(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return [
      NameIdDescription(
        name: l10n.humor,
        id: 'humor',
        description: l10n.memesComedyShowsSillyGoofyWebsites,
      ),
      const NameIdDescription(
        name: 'Educational',
        id: 'educational',
        description: 'Philosphy, college courses, tutoring',
      ),
      const NameIdDescription(
        name: 'AI',
        id: 'ai',
        description: 'Artificial Intelligence',
      ),
      const NameIdDescription(
        name: 'Adult',
        id: 'adult',
        description: 'Adult bookmarks',
      ),
      const NameIdDescription(
        name: 'Reddit',
        id: 'reddit',
        description: 'Best Reddit channels and posts',
      ),
      const NameIdDescription(
        name: 'Philosophy',
        id: 'philosophy',
        description: 'Philosophic articles, books and videos',
      ),
      const NameIdDescription(
        name: 'Videos',
        id: 'videos',
        description: 'Cool videos',
      ),
      const NameIdDescription(
        name: 'Paranormal',
        id: 'paranormal',
        description: 'Paranormal, weird stuff, ufos, ghosts',
      ),
      const NameIdDescription(
        name: 'How to',
        id: 'how-to',
        description: 'Instructions, how-to bookmarks',
      ),
      const NameIdDescription(
        name: 'Coding',
        id: 'coding',
        description: 'Programming tutorials and resources',
      ),
      const NameIdDescription(
        name: 'Movies',
        id: 'movies',
        description: 'Feature length movies and short films',
      ),
      const NameIdDescription(
        name: 'Documentaries',
        id: 'documentaries',
        description: 'Documentary bookmarks and resources',
      ),
      const NameIdDescription(
        name: 'Sci/Tech',
        id: 'sci-tech',
        description: 'Space, lasers, computers, quantum physics, etc.',
      ),
      const NameIdDescription(
        name: 'Trippy',
        id: 'trippy',
        description: 'Groovy psychedelic goodness',
      ),
      const NameIdDescription(
        name: 'Religion',
        id: 'religion',
        description: 'Occult, New Age, Christianity, spiritual bookmarks',
      ),
      const NameIdDescription(
        name: 'Right Wing News',
        id: 'rw-mews',
        description: 'Conservative propaganda',
      ),
      const NameIdDescription(
        name: 'Left Wing News',
        id: 'lw-news',
        description: 'Left wing propaganda',
      ),
      const NameIdDescription(
        name: 'Interesting',
        id: 'interesting',
        description: 'Interesting and fascinating facts',
      ),
      const NameIdDescription(
        name: 'News',
        id: 'news',
        description: 'Miscellaneous news',
      ),
      const NameIdDescription(
        name: 'Conspiracy',
        id: 'conspiracy',
        description: 'Conspiracy theories and evidence',
      ),
      const NameIdDescription(
        name: 'Sports',
        id: 'sports',
        description: 'Football, baseball, boxing, MMA, skateboarding',
      ),
      const NameIdDescription(
        name: 'NSFW',
        id: 'nsfw',
        description: 'Not Safe For Work',
      ),
      const NameIdDescription(
        name: 'Entertainment',
        id: 'entertainment',
        description: 'Movies, TV shows, music, and more',
      ),
      const NameIdDescription(
        name: 'Video Games',
        id: 'video-games',
        description: 'Video game news, reviews',
      ),
      const NameIdDescription(
        name: 'Software Development',
        id: 'software-dev',
        description: 'Software development tutorials and resources',
      ),
      const NameIdDescription(
        name: 'Hobbies',
        id: 'hobbies',
        description: 'Hobbies and leisure activities',
      ),
      const NameIdDescription(
        name: 'Music',
        id: 'music',
        description: 'Music collections, playlists, and artists',
      ),
      const NameIdDescription(
        name: 'Literature',
        id: 'literature',
        description: 'Literary works, poetry, and essays',
      ),
      const NameIdDescription(
        name: 'History',
        id: 'history',
        description: 'Historical events, figures, and analysis',
      ),
      const NameIdDescription(
        name: 'Gore',
        id: 'gore',
        description: 'Graphic content, violence, and disturbing imagery',
      ),
      const NameIdDescription(
        name: 'Drugs',
        id: 'drugs',
        description: 'Information for safe usage and education about drugs',
      ),
      const NameIdDescription(
        name: 'Blogs',
        id: 'blogs',
        description: 'Cool bloggers with interesting ideas',
      ),
      const NameIdDescription(
        name: 'Shopping',
        id: 'shopping',
        description: 'Cool products, affiliate links, obscure finds',
      ),
      const NameIdDescription(
        name: 'Celebrities',
        id: 'celebrities',
        description: 'Famous people doing cool stuff',
      ),
    ];
  }
}
