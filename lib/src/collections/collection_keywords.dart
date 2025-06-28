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
      NameIdDescription(
        name: l10n.educational,
        id: 'educational',
        description: l10n.learningResourcesCollegeCoursesTutoring,
      ),
      NameIdDescription(
        name: 'AI',
        id: 'ai',
        description: l10n.artificialIntelligence,
      ),
      NameIdDescription(
        name: l10n.adult,
        id: 'adult',
        description: l10n.adultBookmarks,
      ),
      NameIdDescription(
        name: 'Reddit',
        id: 'reddit',
        description: l10n.bestRedditChannelsAndPosts,
      ),
      NameIdDescription(
        name: l10n.philosophy,
        id: 'philosophy',
        description: l10n.philosophicArticlesBooksAndVideos,
      ),
      NameIdDescription(
        name: l10n.videos,
        id: 'videos',
        description: l10n.coolVideos,
      ),
      NameIdDescription(
        name: l10n.paranormal,
        id: 'paranormal',
        description: l10n.paranormalWeirdStuffUfosGhosts,
      ),
      NameIdDescription(
        name: l10n.howTo,
        id: 'how-to',
        description: l10n.instructionsHowToBookmarks,
      ),
      NameIdDescription(
        name: l10n.coding,
        id: 'coding',
        description: l10n.programmingTutorialsAndResources,
      ),
      NameIdDescription(
        name: l10n.movies,
        id: 'movies',
        description: l10n.featureLengthMoviesAndShortFilms,
      ),
      NameIdDescription(
        name: l10n.documentaries,
        id: 'documentaries',
        description: l10n.documentaryBookmarksAndResources,
      ),
      NameIdDescription(
        name: l10n.sciTech,
        id: 'sci-tech',
        description: l10n.spaceLasersComputersQuantumPhysicsEtc,
      ),
      NameIdDescription(
        name: l10n.trippy,
        id: 'trippy',
        description: l10n.groovyPsychedelicGoodness,
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
