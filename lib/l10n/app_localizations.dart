import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @adult.
  ///
  /// In en, this message translates to:
  /// **'Adult'**
  String get adult;

  /// No description provided for @adultBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Adult bookmarks'**
  String get adultBookmarks;

  /// No description provided for @artificialIntelligence.
  ///
  /// In en, this message translates to:
  /// **'Artificial Intelligence'**
  String get artificialIntelligence;

  /// No description provided for @bestRedditChannelsAndPosts.
  ///
  /// In en, this message translates to:
  /// **'Best Reddit channels and posts'**
  String get bestRedditChannelsAndPosts;

  /// No description provided for @blogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get blogs;

  /// No description provided for @celebrities.
  ///
  /// In en, this message translates to:
  /// **'Celebrities'**
  String get celebrities;

  /// No description provided for @coding.
  ///
  /// In en, this message translates to:
  /// **'Coding'**
  String get coding;

  /// No description provided for @conservativePropaganda.
  ///
  /// In en, this message translates to:
  /// **'Conservative propaganda'**
  String get conservativePropaganda;

  /// No description provided for @conspiracy.
  ///
  /// In en, this message translates to:
  /// **'Conspiracy'**
  String get conspiracy;

  /// No description provided for @conspiracyTheoriesAndEvidence.
  ///
  /// In en, this message translates to:
  /// **'Conspiracy theories and evidence'**
  String get conspiracyTheoriesAndEvidence;

  /// No description provided for @coolBloggersWithInterestingIdeas.
  ///
  /// In en, this message translates to:
  /// **'Cool bloggers with interesting ideas'**
  String get coolBloggersWithInterestingIdeas;

  /// No description provided for @coolProductsAffiliateLinksObscureFinds.
  ///
  /// In en, this message translates to:
  /// **'Cool products, affiliate links, obscure finds'**
  String get coolProductsAffiliateLinksObscureFinds;

  /// No description provided for @coolVideos.
  ///
  /// In en, this message translates to:
  /// **'Cool videos'**
  String get coolVideos;

  /// No description provided for @documentaries.
  ///
  /// In en, this message translates to:
  /// **'Documentaries'**
  String get documentaries;

  /// No description provided for @documentaryBookmarksAndResources.
  ///
  /// In en, this message translates to:
  /// **'Documentary bookmarks and resources'**
  String get documentaryBookmarksAndResources;

  /// No description provided for @drugs.
  ///
  /// In en, this message translates to:
  /// **'Drugs'**
  String get drugs;

  /// No description provided for @educational.
  ///
  /// In en, this message translates to:
  /// **'Educational'**
  String get educational;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @famousPeopleDoingCoolStuff.
  ///
  /// In en, this message translates to:
  /// **'Famous people doing cool stuff'**
  String get famousPeopleDoingCoolStuff;

  /// No description provided for @featureLengthMoviesAndShortFilms.
  ///
  /// In en, this message translates to:
  /// **'Feature length movies and short films'**
  String get featureLengthMoviesAndShortFilms;

  /// No description provided for @footballBaseballBoxingMmaSkateboarding.
  ///
  /// In en, this message translates to:
  /// **'Football, baseball, boxing, MMA, skateboarding'**
  String get footballBaseballBoxingMmaSkateboarding;

  /// No description provided for @gore.
  ///
  /// In en, this message translates to:
  /// **'Gore'**
  String get gore;

  /// No description provided for @graphicContentViolenceAndDisturbingImagery.
  ///
  /// In en, this message translates to:
  /// **'Graphic content, violence, and disturbing imagery'**
  String get graphicContentViolenceAndDisturbingImagery;

  /// No description provided for @groovyPsychedelicGoodness.
  ///
  /// In en, this message translates to:
  /// **'Groovy psychedelic goodness'**
  String get groovyPsychedelicGoodness;

  /// No description provided for @historicalEventsFiguresAndAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Historical events, figures, and analysis'**
  String get historicalEventsFiguresAndAnalysis;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @hobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get hobbies;

  /// No description provided for @hobbiesAndLeisureActivities.
  ///
  /// In en, this message translates to:
  /// **'Hobbies and leisure activities'**
  String get hobbiesAndLeisureActivities;

  /// No description provided for @howTo.
  ///
  /// In en, this message translates to:
  /// **'How-to'**
  String get howTo;

  /// No description provided for @humor.
  ///
  /// In en, this message translates to:
  /// **'Humor'**
  String get humor;

  /// No description provided for @informationForSafeUsageAndEducationAboutDrugs.
  ///
  /// In en, this message translates to:
  /// **'Information for safe usage and education about drugs'**
  String get informationForSafeUsageAndEducationAboutDrugs;

  /// No description provided for @instructionsHowToBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Instructions, how-to bookmarks'**
  String get instructionsHowToBookmarks;

  /// No description provided for @interesting.
  ///
  /// In en, this message translates to:
  /// **'Interesting'**
  String get interesting;

  /// No description provided for @interestingAndFascinatingFacts.
  ///
  /// In en, this message translates to:
  /// **'Interesting and fascinating facts'**
  String get interestingAndFascinatingFacts;

  /// No description provided for @learningResourcesCollegeCoursesTutoring.
  ///
  /// In en, this message translates to:
  /// **'Learning resources, college courses, tutoring'**
  String get learningResourcesCollegeCoursesTutoring;

  /// No description provided for @leftWingNews.
  ///
  /// In en, this message translates to:
  /// **'Left Wing News'**
  String get leftWingNews;

  /// No description provided for @leftWingPropaganda.
  ///
  /// In en, this message translates to:
  /// **'Left wing propaganda'**
  String get leftWingPropaganda;

  /// No description provided for @literaryWorksPoetryAndEssays.
  ///
  /// In en, this message translates to:
  /// **'Literary works, poetry, and essays'**
  String get literaryWorksPoetryAndEssays;

  /// No description provided for @literature.
  ///
  /// In en, this message translates to:
  /// **'Literature'**
  String get literature;

  /// No description provided for @memesComedyShowsSillyGoofyWebsites.
  ///
  /// In en, this message translates to:
  /// **'Memes, comedy shows, silly/goofy websites'**
  String get memesComedyShowsSillyGoofyWebsites;

  /// No description provided for @miscellaneousNews.
  ///
  /// In en, this message translates to:
  /// **'Miscellaneous news'**
  String get miscellaneousNews;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @moviesTvShowsMusicAndMore.
  ///
  /// In en, this message translates to:
  /// **'Movies, TV shows, music, and more'**
  String get moviesTvShowsMusicAndMore;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @musicCollectionsPlaylistsAndArtists.
  ///
  /// In en, this message translates to:
  /// **'Music collections, playlists, and artists'**
  String get musicCollectionsPlaylistsAndArtists;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @notSafeForWork.
  ///
  /// In en, this message translates to:
  /// **'Not Safe For Work'**
  String get notSafeForWork;

  /// No description provided for @nsfw.
  ///
  /// In en, this message translates to:
  /// **'NSFW'**
  String get nsfw;

  /// No description provided for @occultNewAgeChristianitySpiritualBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Occult, New Age, Christianity, spiritual bookmarks'**
  String get occultNewAgeChristianitySpiritualBookmarks;

  /// No description provided for @paranormal.
  ///
  /// In en, this message translates to:
  /// **'Paranormal'**
  String get paranormal;

  /// No description provided for @paranormalWeirdStuffUfosGhosts.
  ///
  /// In en, this message translates to:
  /// **'Paranormal, weird stuff, ufos, ghosts'**
  String get paranormalWeirdStuffUfosGhosts;

  /// No description provided for @philosophicArticlesBooksAndVideos.
  ///
  /// In en, this message translates to:
  /// **'Philosophic articles, books and videos'**
  String get philosophicArticlesBooksAndVideos;

  /// No description provided for @philosophy.
  ///
  /// In en, this message translates to:
  /// **'Philosophy'**
  String get philosophy;

  /// No description provided for @programmingTutorialsAndResources.
  ///
  /// In en, this message translates to:
  /// **'Programming tutorials and resources'**
  String get programmingTutorialsAndResources;

  /// No description provided for @religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religion;

  /// No description provided for @rightWingNews.
  ///
  /// In en, this message translates to:
  /// **'Right Wing News'**
  String get rightWingNews;

  /// No description provided for @sciTech.
  ///
  /// In en, this message translates to:
  /// **'Sci/Tech'**
  String get sciTech;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @softwareDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Software Development'**
  String get softwareDevelopment;

  /// No description provided for @softwareDevelopmentTutorialsAndResources.
  ///
  /// In en, this message translates to:
  /// **'Software development tutorials and resources'**
  String get softwareDevelopmentTutorialsAndResources;

  /// No description provided for @spaceLasersComputersQuantumPhysicsEtc.
  ///
  /// In en, this message translates to:
  /// **'Space, lasers, computers, quantum physics, etc.'**
  String get spaceLasersComputersQuantumPhysicsEtc;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @trippy.
  ///
  /// In en, this message translates to:
  /// **'Trippy'**
  String get trippy;

  /// No description provided for @videoGameNewsReviews.
  ///
  /// In en, this message translates to:
  /// **'Video game news, reviews'**
  String get videoGameNewsReviews;

  /// No description provided for @videoGames.
  ///
  /// In en, this message translates to:
  /// **'Video Games'**
  String get videoGames;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
