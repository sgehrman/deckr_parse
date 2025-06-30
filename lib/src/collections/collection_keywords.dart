import 'package:deckr_parse/l10n/app_localizations.dart';
import 'package:dfc_flutter/dfc_flutter_web.dart';
import 'package:flutter/widgets.dart';

class CollectionKeywords {
  factory CollectionKeywords() {
    return _instance ??= CollectionKeywords._();
  }

  CollectionKeywords._();
  static CollectionKeywords? _instance;

  final _listCache = <NameIdDescription>[];
  final _mapCache = <String, NameIdDescription>{};

  Map<String, NameIdDescription> keywordsMap(BuildContext context) {
    if (_mapCache.isEmpty) {
      for (final keyword in keywords(context)) {
        _mapCache[keyword.id] = keyword;
      }
    }

    return _mapCache;
  }

  List<NameIdDescription> keywords(BuildContext context) {
    if (_listCache.isEmpty) {
      final l10n = AppLocalizations.of(context);

      _listCache.addAll([
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
        NameIdDescription(
          name: l10n.religion,
          id: 'religion',
          description: l10n.occultNewAgeChristianitySpiritualBookmarks,
        ),
        NameIdDescription(
          name: l10n.rightWingNews,
          id: 'rw-mews',
          description: l10n.conservativePropaganda,
        ),
        NameIdDescription(
          name: l10n.leftWingNews,
          id: 'lw-news',
          description: l10n.leftWingPropaganda,
        ),
        NameIdDescription(
          name: l10n.interesting,
          id: 'interesting',
          description: l10n.interestingAndFascinatingFacts,
        ),
        NameIdDescription(
          name: l10n.news,
          id: 'news',
          description: l10n.miscellaneousNews,
        ),
        NameIdDescription(
          name: l10n.conspiracy,
          id: 'conspiracy',
          description: l10n.conspiracyTheoriesAndEvidence,
        ),
        NameIdDescription(
          name: l10n.sports,
          id: 'sports',
          description: l10n.footballBaseballBoxingMmaSkateboarding,
        ),
        NameIdDescription(
          name: l10n.nsfw,
          id: 'nsfw',
          description: l10n.notSafeForWork,
        ),
        NameIdDescription(
          name: l10n.entertainment,
          id: 'entertainment',
          description: l10n.moviesTvShowsMusicAndMore,
        ),
        NameIdDescription(
          name: l10n.videoGames,
          id: 'video-games',
          description: l10n.videoGameNewsReviews,
        ),
        NameIdDescription(
          name: l10n.softwareDevelopment,
          id: 'software-dev',
          description: l10n.softwareDevelopmentTutorialsAndResources,
        ),
        NameIdDescription(
          name: l10n.hobbies,
          id: 'hobbies',
          description: l10n.hobbiesAndLeisureActivities,
        ),
        NameIdDescription(
          name: l10n.music,
          id: 'music',
          description: l10n.musicCollectionsPlaylistsAndArtists,
        ),
        NameIdDescription(
          name: l10n.literature,
          id: 'literature',
          description: l10n.literaryWorksPoetryAndEssays,
        ),
        NameIdDescription(
          name: l10n.history,
          id: 'history',
          description: l10n.historicalEventsFiguresAndAnalysis,
        ),
        NameIdDescription(
          name: l10n.gore,
          id: 'gore',
          description: l10n.graphicContentViolenceAndDisturbingImagery,
        ),
        NameIdDescription(
          name: l10n.drugs,
          id: 'drugs',
          description: l10n.informationForSafeUsageAndEducationAboutDrugs,
        ),
        NameIdDescription(
          name: l10n.blogs,
          id: 'blogs',
          description: l10n.coolBloggersWithInterestingIdeas,
        ),
        NameIdDescription(
          name: l10n.shopping,
          id: 'shopping',
          description: l10n.coolProductsAffiliateLinksObscureFinds,
        ),
        NameIdDescription(
          name: l10n.celebrities,
          id: 'celebrities',
          description: l10n.famousPeopleDoingCoolStuff,
        ),
      ]);
    }

    return _listCache;
  }
}
