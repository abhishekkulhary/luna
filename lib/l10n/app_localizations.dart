import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// The application name.
  ///
  /// In en, this message translates to:
  /// **'Luna'**
  String get appName;

  /// Generic Save button label.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Generic Cancel button label.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic Delete button label.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Generic Done button label that dismisses a dialog.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Acknowledge button that dismisses an informational dialog.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// Generic OK confirmation button label.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Title of the wheel time-picker dialog.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get pickTimeTitle;

  /// Unit suffix after a number of days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysUnit;

  /// Bottom navigation label for the calendar tab.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// Bottom navigation label for the insights tab.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// Bottom navigation label for the reminders tab.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get navReminders;

  /// Bottom navigation label for the settings tab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Menstrual flow intensity: none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get flowNone;

  /// Menstrual flow intensity: spotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get flowSpotting;

  /// Menstrual flow intensity: light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get flowLight;

  /// Menstrual flow intensity: medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get flowMedium;

  /// Menstrual flow intensity: heavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get flowHeavy;

  /// Symptom chip: cramps.
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get symptomCramps;

  /// Symptom chip: headache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symptomHeadache;

  /// Symptom chip: backache.
  ///
  /// In en, this message translates to:
  /// **'Backache'**
  String get symptomBackache;

  /// Symptom chip: bloating.
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get symptomBloating;

  /// Symptom chip: tender breasts.
  ///
  /// In en, this message translates to:
  /// **'Tender breasts'**
  String get symptomTenderBreasts;

  /// Symptom chip: acne.
  ///
  /// In en, this message translates to:
  /// **'Acne'**
  String get symptomAcne;

  /// Symptom chip: nausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symptomNausea;

  /// Symptom chip: fatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symptomFatigue;

  /// Symptom chip: food cravings.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get symptomCravings;

  /// Symptom chip: insomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get symptomInsomnia;

  /// Symptom chip: diarrhea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get symptomDiarrhea;

  /// Symptom chip: constipation.
  ///
  /// In en, this message translates to:
  /// **'Constipation'**
  String get symptomConstipation;

  /// Symptom chip: dizziness.
  ///
  /// In en, this message translates to:
  /// **'Dizziness'**
  String get symptomDizziness;

  /// Mood chip: happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get moodHappy;

  /// Mood chip: calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get moodCalm;

  /// Mood chip: energetic.
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get moodEnergetic;

  /// Mood chip: sensitive.
  ///
  /// In en, this message translates to:
  /// **'Sensitive'**
  String get moodSensitive;

  /// Mood chip: sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get moodSad;

  /// Mood chip: irritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get moodIrritable;

  /// Mood chip: anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get moodAnxious;

  /// Mood chip: tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get moodTired;

  /// Cycle phase: menstruation.
  ///
  /// In en, this message translates to:
  /// **'Menstruation'**
  String get phaseMenstruation;

  /// Cycle phase: follicular phase.
  ///
  /// In en, this message translates to:
  /// **'Follicular phase'**
  String get phaseFollicular;

  /// Cycle phase: fertile window.
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get phaseFertile;

  /// Cycle phase: ovulation.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get phaseOvulation;

  /// Cycle phase: luteal phase.
  ///
  /// In en, this message translates to:
  /// **'Luteal phase'**
  String get phaseLuteal;

  /// App bar title of the calendar screen.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get calendarTitle;

  /// Tooltip on the action that jumps the calendar to today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Floating button label when today is selected.
  ///
  /// In en, this message translates to:
  /// **'Log today'**
  String get logToday;

  /// Floating button label when a non-today day is selected.
  ///
  /// In en, this message translates to:
  /// **'Log day'**
  String get logDay;

  /// Calendar format toggle: month view.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get calendarFormatMonth;

  /// Calendar format toggle: week view.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get calendarFormatWeek;

  /// Empty-state prompt shown before any period is logged.
  ///
  /// In en, this message translates to:
  /// **'Log your first period to start seeing predictions.'**
  String get noPredictionsYet;

  /// Header showing which day of the current cycle today is.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of your cycle'**
  String cycleDayOf(int day);

  /// Countdown until the next predicted period start.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Next period in 1 day} other{Next period in {count} days}}'**
  String nextPeriodIn(int count);

  /// Shown when the period is predicted to start today.
  ///
  /// In en, this message translates to:
  /// **'Period expected today'**
  String get periodExpectedToday;

  /// Shown when the period is overdue by a number of days.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Period 1 day late} other{Period {count} days late}}'**
  String periodLateBy(int count);

  /// Calendar legend / tag for actual period days.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get legendPeriod;

  /// Calendar legend for predicted period days.
  ///
  /// In en, this message translates to:
  /// **'Predicted'**
  String get legendPredicted;

  /// Calendar legend / tag for fertile days.
  ///
  /// In en, this message translates to:
  /// **'Fertile'**
  String get legendFertile;

  /// Calendar legend / tag for the ovulation day.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get legendOvulation;

  /// Selected-day tag for a predicted period day.
  ///
  /// In en, this message translates to:
  /// **'Predicted period'**
  String get tagPredictedPeriod;

  /// Shown on the day detail when nothing is logged.
  ///
  /// In en, this message translates to:
  /// **'No log for this day.'**
  String get noLogForDay;

  /// Logged flow value on the day detail.
  ///
  /// In en, this message translates to:
  /// **'Flow: {flow}'**
  String flowValueLabel(String flow);

  /// Button that opens the editor for the selected day's log.
  ///
  /// In en, this message translates to:
  /// **'Edit log'**
  String get editLog;

  /// Tooltip on the delete action in the log editor.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get deleteLog;

  /// Section header for the flow selector in the log editor.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get sectionFlow;

  /// Section header for the symptom chips in the log editor.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get sectionSymptoms;

  /// Section header for the mood chips in the log editor.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get sectionMood;

  /// Section header for the notes field in the log editor.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get sectionNotes;

  /// Placeholder text for the notes text field.
  ///
  /// In en, this message translates to:
  /// **'Anything you want to remember…'**
  String get notesHint;

  /// Toggle label for logging intimacy on a day.
  ///
  /// In en, this message translates to:
  /// **'Intimacy'**
  String get intimacy;

  /// App bar title of the insights screen.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// Empty-state text on the insights screen.
  ///
  /// In en, this message translates to:
  /// **'Log a couple of cycles to unlock insights about your patterns.'**
  String get insightsEmpty;

  /// Regularity value shown before enough cycles are logged.
  ///
  /// In en, this message translates to:
  /// **'Keep logging'**
  String get keepLogging;

  /// Regularity value: cycles are regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regular;

  /// Regularity value: cycles are irregular.
  ///
  /// In en, this message translates to:
  /// **'Irregular'**
  String get irregular;

  /// Stat card label: average cycle length.
  ///
  /// In en, this message translates to:
  /// **'Avg cycle'**
  String get statAvgCycle;

  /// Stat card label: average period length.
  ///
  /// In en, this message translates to:
  /// **'Avg period'**
  String get statAvgPeriod;

  /// Stat card label: cycle regularity.
  ///
  /// In en, this message translates to:
  /// **'Regularity'**
  String get statRegularity;

  /// Cycle-length variability shown under the regularity stat.
  ///
  /// In en, this message translates to:
  /// **'±{value} days'**
  String plusMinusDays(String value);

  /// Title of the cycle-length chart card.
  ///
  /// In en, this message translates to:
  /// **'Cycle length over time'**
  String get chartCycleLength;

  /// Shown when there is not enough data for the chart.
  ///
  /// In en, this message translates to:
  /// **'Track at least two cycles to see your trend.'**
  String get trackTwoCycles;

  /// Title of the symptom-frequency card.
  ///
  /// In en, this message translates to:
  /// **'Most common symptoms'**
  String get mostCommonSymptoms;

  /// App bar title of the reminders screen.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// Floating button label to add a custom reminder.
  ///
  /// In en, this message translates to:
  /// **'Add reminder'**
  String get addReminder;

  /// Notice shown on web explaining scheduled notifications are unavailable.
  ///
  /// In en, this message translates to:
  /// **'Scheduled notifications run on the mobile and desktop apps. They are not available in the web version.'**
  String get webNotice;

  /// Header for the cycle-notification toggles.
  ///
  /// In en, this message translates to:
  /// **'Cycle notifications'**
  String get cycleNotifications;

  /// Row label for the time of day notifications fire.
  ///
  /// In en, this message translates to:
  /// **'Notification time'**
  String get notificationTime;

  /// Header above the list of custom reminders.
  ///
  /// In en, this message translates to:
  /// **'Your reminders'**
  String get yourReminders;

  /// Empty-state text when there are no custom reminders.
  ///
  /// In en, this message translates to:
  /// **'No custom reminders yet.'**
  String get noCustomReminders;

  /// Toggle: notify one day before the period.
  ///
  /// In en, this message translates to:
  /// **'Period coming up (1 day before)'**
  String get togglePeriodSoon;

  /// Toggle: notify on the predicted period start day.
  ///
  /// In en, this message translates to:
  /// **'Period start day'**
  String get togglePeriodStart;

  /// Toggle: notify when the fertile window starts.
  ///
  /// In en, this message translates to:
  /// **'Fertile window start'**
  String get toggleFertileStart;

  /// Toggle: notify on the ovulation day.
  ///
  /// In en, this message translates to:
  /// **'Ovulation day'**
  String get toggleOvulation;

  /// Toggle: notify during the PMS window.
  ///
  /// In en, this message translates to:
  /// **'PMS reminder'**
  String get togglePms;

  /// Toggle: notify when the period is late.
  ///
  /// In en, this message translates to:
  /// **'Period late reminder'**
  String get togglePeriodLate;

  /// Reminder repeat option: once.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get repeatOnce;

  /// Reminder repeat option: daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get repeatDaily;

  /// Reminder repeat option: weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get repeatWeekly;

  /// Reminder list subtitle combining the time and repeat rule.
  ///
  /// In en, this message translates to:
  /// **'{time} · {repeat}'**
  String reminderSubtitle(String time, String repeat);

  /// Title of the reminder editor when creating a reminder.
  ///
  /// In en, this message translates to:
  /// **'New reminder'**
  String get newReminder;

  /// Title of the reminder editor when editing a reminder.
  ///
  /// In en, this message translates to:
  /// **'Edit reminder'**
  String get editReminder;

  /// Label for the reminder title text field.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitle;

  /// Placeholder text for the reminder title field.
  ///
  /// In en, this message translates to:
  /// **'e.g. Take the pill'**
  String get titleHint;

  /// Label for the optional reminder note field.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// Label for the reminder time row.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// Button that saves the reminder being edited.
  ///
  /// In en, this message translates to:
  /// **'Save reminder'**
  String get saveReminder;

  /// Abbreviated weekday: Monday.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get weekdayMon;

  /// Abbreviated weekday: Tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get weekdayTue;

  /// Abbreviated weekday: Wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get weekdayWed;

  /// Abbreviated weekday: Thursday.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get weekdayThu;

  /// Abbreviated weekday: Friday.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get weekdayFri;

  /// Abbreviated weekday: Saturday.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get weekdaySat;

  /// Abbreviated weekday: Sunday.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get weekdaySun;

  /// App bar title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings section header: cycle defaults.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get sectionCycle;

  /// Settings section header: appearance and language.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get sectionAppearance;

  /// Settings section header: privacy and security.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get sectionPrivacySecurity;

  /// Settings section header: data export/import/delete.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get sectionData;

  /// Settings section header: about the app.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// Setting/onboarding label for average cycle length.
  ///
  /// In en, this message translates to:
  /// **'Average cycle length'**
  String get avgCycleLength;

  /// Setting/onboarding label for average period length.
  ///
  /// In en, this message translates to:
  /// **'Average period length'**
  String get avgPeriodLength;

  /// Setting label for the luteal phase length.
  ///
  /// In en, this message translates to:
  /// **'Luteal phase length'**
  String get lutealPhaseLength;

  /// Toggle label: adapt predictions from logged cycles.
  ///
  /// In en, this message translates to:
  /// **'Adapt to my history'**
  String get adaptToHistory;

  /// Subtitle for the adapt-to-history toggle.
  ///
  /// In en, this message translates to:
  /// **'Refine predictions from your logged cycles automatically'**
  String get adaptToHistorySub;

  /// Theme option: follow the system setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Theme option: light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Theme option: dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Setting row label for the app lock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get appLock;

  /// App lock value: disabled.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get lockOff;

  /// App lock value: PIN only.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get lockPin;

  /// App lock value: biometric with PIN fallback.
  ///
  /// In en, this message translates to:
  /// **'Biometric + PIN'**
  String get lockBiometric;

  /// Data action: export a backup file.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackup;

  /// Subtitle for the export backup action.
  ///
  /// In en, this message translates to:
  /// **'Save your data as a .json file on this device'**
  String get exportBackupSub;

  /// Data action: import a backup file.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get importBackup;

  /// Subtitle for the import backup action.
  ///
  /// In en, this message translates to:
  /// **'Restore data from a .json backup file'**
  String get importBackupSub;

  /// Data action: copy all data to the clipboard as JSON.
  ///
  /// In en, this message translates to:
  /// **'Copy as JSON'**
  String get copyAsJson;

  /// Subtitle for the copy-as-JSON action.
  ///
  /// In en, this message translates to:
  /// **'Copy all data to the clipboard'**
  String get copyAsJsonSub;

  /// Data action: import JSON from the clipboard.
  ///
  /// In en, this message translates to:
  /// **'Import from clipboard'**
  String get importFromClipboard;

  /// Subtitle for the import-from-clipboard action.
  ///
  /// In en, this message translates to:
  /// **'Paste JSON data to restore'**
  String get importFromClipboardSub;

  /// Destructive data action: delete everything.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get deleteAllData;

  /// Subtitle under the app name in About, including the app version.
  ///
  /// In en, this message translates to:
  /// **'Private, on-device cycle tracking · v{version}'**
  String aboutSubtitle(String version);

  /// About row that opens the privacy dialog.
  ///
  /// In en, this message translates to:
  /// **'Privacy & data'**
  String get privacyData;

  /// Subtitle for the privacy & data row.
  ///
  /// In en, this message translates to:
  /// **'No account, no cloud — everything stays on this device'**
  String get privacyDataSub;

  /// Privacy reassurance paragraph in the About section.
  ///
  /// In en, this message translates to:
  /// **'Luna doesn\'t collect, transmit, or sell any of your data. Everything is stored and managed locally on your device.'**
  String get privacyNote;

  /// About row / dialog title for the medical disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Medical disclaimer'**
  String get medicalDisclaimer;

  /// Subtitle for the medical disclaimer row.
  ///
  /// In en, this message translates to:
  /// **'Predictions are estimates, not medical advice'**
  String get medicalDisclaimerSub;

  /// Short medical disclaimer paragraph in the About section.
  ///
  /// In en, this message translates to:
  /// **'Predictions are estimates and may not be perfectly accurate. Luna is not a medical device — please consult your doctor for medical advice or accurate results.'**
  String get medicalDisclaimerNote;

  /// Full body text of the medical disclaimer dialog.
  ///
  /// In en, this message translates to:
  /// **'Luna helps you track and understand your cycle, but its predictions — period dates, the fertile window and ovulation — are estimates based on the data you log. They may not be perfectly accurate and can be affected by many factors.\n\nLuna is not a medical device and does not provide medical advice, diagnosis, or contraception guidance. Please don\'t rely on it to prevent or achieve pregnancy.\n\nFor medical advice or accurate results, consult your doctor or a qualified healthcare professional.'**
  String get disclaimerDialogBody;

  /// Title of the privacy dialog.
  ///
  /// In en, this message translates to:
  /// **'Your privacy'**
  String get privacyDialogTitle;

  /// Full body text of the privacy dialog.
  ///
  /// In en, this message translates to:
  /// **'Luna is private by design.\n\n•  We don\'t collect, transmit, or sell any of your data.\n\n•  There is no account and no server — everything is stored locally on this device and never leaves it.\n\n•  Your information is protected by the app lock and your device\'s own security.\n\nYou stay in control: export or permanently delete your data anytime from Settings.'**
  String get privacyDialogBody;

  /// Snackbar when biometrics are unavailable and PIN is used.
  ///
  /// In en, this message translates to:
  /// **'Biometrics unavailable — PIN lock enabled instead.'**
  String get biometricsUnavailable;

  /// Snackbar after copying data to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'Data copied to clipboard as JSON.'**
  String get dataCopiedToClipboard;

  /// Snackbar when a backup file can't be written and falls back to clipboard.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save a file here — copied to clipboard instead.'**
  String get couldntSaveFile;

  /// Title of the dialog confirming a backup was saved.
  ///
  /// In en, this message translates to:
  /// **'Backup saved'**
  String get backupSaved;

  /// Button that copies the saved backup file path.
  ///
  /// In en, this message translates to:
  /// **'Copy path'**
  String get copyPath;

  /// File-type group label in the import file picker.
  ///
  /// In en, this message translates to:
  /// **'Luna backup'**
  String get backupFileTypeLabel;

  /// Snackbar when importing from an empty clipboard.
  ///
  /// In en, this message translates to:
  /// **'Clipboard is empty.'**
  String get clipboardEmpty;

  /// Snackbar when the imported data isn't a valid backup.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a Luna backup.'**
  String get notLunaBackup;

  /// Title of the import confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Import backup?'**
  String get importBackupQuestion;

  /// Body of the import confirmation dialog, with the number of days to import.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{This adds 1 logged day from the backup, overwriting any day with the same date. Your other days are kept.} other{This adds {count} logged days from the backup, overwriting any days with the same date. Your other days are kept.}}'**
  String importBackupBody(int count);

  /// Confirm button in the import dialog.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importAction;

  /// Snackbar after a successful import, with the number of days imported.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Imported 1 day.} other{Imported {count} days.}}'**
  String importedDays(int count);

  /// Title of the delete-all confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get deleteAllQuestion;

  /// Body of the delete-all confirmation dialog.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes every logged day, reminder and setting from this device. This cannot be undone.'**
  String get deleteAllBody;

  /// Confirm button in the delete-all dialog.
  ///
  /// In en, this message translates to:
  /// **'Delete everything'**
  String get deleteEverything;

  /// Settings row label and picker title for the app language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language option that follows the device language.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// Title on the lock screen PIN pad.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPin;

  /// Subtitle on the lock screen.
  ///
  /// In en, this message translates to:
  /// **'Your data is locked'**
  String get dataLocked;

  /// Error shown after an incorrect PIN entry.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN, try again'**
  String get incorrectPin;

  /// App bar title of the PIN setup screen.
  ///
  /// In en, this message translates to:
  /// **'Set app PIN'**
  String get setAppPin;

  /// PIN pad title for the first PIN entry during setup.
  ///
  /// In en, this message translates to:
  /// **'Create a PIN'**
  String get createPin;

  /// PIN pad title for confirming the PIN during setup.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// Subtitle prompting the user to choose a PIN.
  ///
  /// In en, this message translates to:
  /// **'Choose a 4-digit PIN'**
  String get choosePinHint;

  /// Subtitle prompting the user to re-enter the PIN.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your PIN'**
  String get reenterPin;

  /// Onboarding button to advance to the next page.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// Onboarding button on the last page that finishes setup.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// Heading on the onboarding welcome page.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Luna'**
  String get welcomeTitle;

  /// Intro paragraph on the onboarding welcome page.
  ///
  /// In en, this message translates to:
  /// **'Track your period, ovulation and symptoms with a calm, modern calendar and helpful reminders.'**
  String get welcomeBody;

  /// Privacy reassurance on the onboarding welcome page.
  ///
  /// In en, this message translates to:
  /// **'Your data stays private on this device — no account, no cloud.'**
  String get welcomePrivacy;

  /// Label above the language options in onboarding.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// Hint under the onboarding language options.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in Settings.'**
  String get chooseLanguageSub;

  /// Heading on the onboarding details page.
  ///
  /// In en, this message translates to:
  /// **'A few details'**
  String get aFewDetails;

  /// Field label for the last period start date.
  ///
  /// In en, this message translates to:
  /// **'Last period start'**
  String get lastPeriodStart;

  /// Toggle label to enable reminders during onboarding.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get enableReminders;

  /// Subtitle for the enable-reminders toggle.
  ///
  /// In en, this message translates to:
  /// **'Period, fertile window and ovulation alerts'**
  String get enableRemindersSub;

  /// Notification title: period is coming up soon.
  ///
  /// In en, this message translates to:
  /// **'Period coming up'**
  String get notifPeriodSoonTitle;

  /// Notification body: period may start tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Your period may start tomorrow.'**
  String get notifPeriodSoonBody;

  /// Notification title: period expected today.
  ///
  /// In en, this message translates to:
  /// **'Period expected today'**
  String get notifPeriodStartTitle;

  /// Notification body: period predicted to start today.
  ///
  /// In en, this message translates to:
  /// **'Your period is predicted to start today.'**
  String get notifPeriodStartBody;

  /// Notification title: PMS window.
  ///
  /// In en, this message translates to:
  /// **'PMS window'**
  String get notifPmsTitle;

  /// Notification body: PMS symptoms may begin soon.
  ///
  /// In en, this message translates to:
  /// **'PMS symptoms may begin over the next few days.'**
  String get notifPmsBody;

  /// Notification title: period may be late.
  ///
  /// In en, this message translates to:
  /// **'Period late?'**
  String get notifPeriodLateTitle;

  /// Notification body prompting the user to log a late period.
  ///
  /// In en, this message translates to:
  /// **'Your period hasn\'t been logged yet. Tap to log.'**
  String get notifPeriodLateBody;

  /// Notification title: fertile window starting.
  ///
  /// In en, this message translates to:
  /// **'Fertile window'**
  String get notifFertileTitle;

  /// Notification body: fertile window starting.
  ///
  /// In en, this message translates to:
  /// **'Your fertile window is starting.'**
  String get notifFertileBody;

  /// Notification title: ovulation day.
  ///
  /// In en, this message translates to:
  /// **'Ovulation day'**
  String get notifOvulationTitle;

  /// Notification body: estimated ovulation today.
  ///
  /// In en, this message translates to:
  /// **'Estimated ovulation is today.'**
  String get notifOvulationBody;
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
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
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
