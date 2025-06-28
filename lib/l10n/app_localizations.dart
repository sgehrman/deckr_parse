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

  /// No description provided for @coding.
  ///
  /// In en, this message translates to:
  /// **'Coding'**
  String get coding;

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

  /// No description provided for @educational.
  ///
  /// In en, this message translates to:
  /// **'Educational'**
  String get educational;

  /// No description provided for @featureLengthMoviesAndShortFilms.
  ///
  /// In en, this message translates to:
  /// **'Feature length movies and short films'**
  String get featureLengthMoviesAndShortFilms;

  /// No description provided for @groovyPsychedelicGoodness.
  ///
  /// In en, this message translates to:
  /// **'Groovy psychedelic goodness'**
  String get groovyPsychedelicGoodness;

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

  /// No description provided for @instructionsHowToBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Instructions, how-to bookmarks'**
  String get instructionsHowToBookmarks;

  /// No description provided for @learningResourcesCollegeCoursesTutoring.
  ///
  /// In en, this message translates to:
  /// **'Learning resources, college courses, tutoring'**
  String get learningResourcesCollegeCoursesTutoring;

  /// No description provided for @memesComedyShowsSillyGoofyWebsites.
  ///
  /// In en, this message translates to:
  /// **'Memes, comedy shows, silly/goofy websites'**
  String get memesComedyShowsSillyGoofyWebsites;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

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

  /// No description provided for @sciTech.
  ///
  /// In en, this message translates to:
  /// **'Sci/Tech'**
  String get sciTech;

  /// No description provided for @spaceLasersComputersQuantumPhysicsEtc.
  ///
  /// In en, this message translates to:
  /// **'Space, lasers, computers, quantum physics, etc.'**
  String get spaceLasersComputersQuantumPhysicsEtc;

  /// No description provided for @trippy.
  ///
  /// In en, this message translates to:
  /// **'Trippy'**
  String get trippy;

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
