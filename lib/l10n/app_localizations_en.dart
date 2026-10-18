// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Luna';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get done => 'Done';

  @override
  String get gotIt => 'Got it';

  @override
  String get ok => 'OK';

  @override
  String get pickTimeTitle => 'Select time';

  @override
  String get daysUnit => 'days';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navInsights => 'Insights';

  @override
  String get navReminders => 'Reminders';

  @override
  String get navSettings => 'Settings';

  @override
  String get flowNone => 'None';

  @override
  String get flowSpotting => 'Spotting';

  @override
  String get flowLight => 'Light';

  @override
  String get flowMedium => 'Medium';

  @override
  String get flowHeavy => 'Heavy';

  @override
  String get symptomCramps => 'Cramps';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomBackache => 'Backache';

  @override
  String get symptomBloating => 'Bloating';

  @override
  String get symptomTenderBreasts => 'Tender breasts';

  @override
  String get symptomAcne => 'Acne';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get symptomFatigue => 'Fatigue';

  @override
  String get symptomCravings => 'Cravings';

  @override
  String get symptomInsomnia => 'Insomnia';

  @override
  String get symptomDiarrhea => 'Diarrhea';

  @override
  String get symptomConstipation => 'Constipation';

  @override
  String get symptomDizziness => 'Dizziness';

  @override
  String get moodHappy => 'Happy';

  @override
  String get moodCalm => 'Calm';

  @override
  String get moodEnergetic => 'Energetic';

  @override
  String get moodSensitive => 'Sensitive';

  @override
  String get moodSad => 'Sad';

  @override
  String get moodIrritable => 'Irritable';

  @override
  String get moodAnxious => 'Anxious';

  @override
  String get moodTired => 'Tired';

  @override
  String get phaseMenstruation => 'Menstruation';

  @override
  String get phaseFollicular => 'Follicular phase';

  @override
  String get phaseFertile => 'Fertile window';

  @override
  String get phaseOvulation => 'Ovulation';

  @override
  String get phaseLuteal => 'Luteal phase';

  @override
  String get calendarTitle => 'Cycle';

  @override
  String get today => 'Today';

  @override
  String get logToday => 'Log today';

  @override
  String get logDay => 'Log day';

  @override
  String get calendarFormatMonth => 'Month';

  @override
  String get calendarFormatWeek => 'Week';

  @override
  String get noPredictionsYet =>
      'Log your first period to start seeing predictions.';

  @override
  String cycleDayOf(int day) {
    return 'Day $day of your cycle';
  }

  @override
  String nextPeriodIn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Next period in $count days',
      one: 'Next period in 1 day',
    );
    return '$_temp0';
  }

  @override
  String get periodExpectedToday => 'Period expected today';

  @override
  String periodLateBy(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Period $count days late',
      one: 'Period 1 day late',
    );
    return '$_temp0';
  }

  @override
  String get legendPeriod => 'Period';

  @override
  String get legendPredicted => 'Predicted';

  @override
  String get legendFertile => 'Fertile';

  @override
  String get legendOvulation => 'Ovulation';

  @override
  String get tagPredictedPeriod => 'Predicted period';

  @override
  String get noLogForDay => 'No log for this day.';

  @override
  String flowValueLabel(String flow) {
    return 'Flow: $flow';
  }

  @override
  String get editLog => 'Edit log';

  @override
  String get deleteLog => 'Delete log';

  @override
  String get sectionFlow => 'Flow';

  @override
  String get sectionSymptoms => 'Symptoms';

  @override
  String get sectionMood => 'Mood';

  @override
  String get sectionNotes => 'Notes';

  @override
  String get notesHint => 'Anything you want to remember…';

  @override
  String get intimacy => 'Intimacy';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsEmpty =>
      'Log a couple of cycles to unlock insights about your patterns.';

  @override
  String get keepLogging => 'Keep logging';

  @override
  String get regular => 'Regular';

  @override
  String get irregular => 'Irregular';

  @override
  String get statAvgCycle => 'Avg cycle';

  @override
  String get statAvgPeriod => 'Avg period';

  @override
  String get statRegularity => 'Regularity';

  @override
  String plusMinusDays(String value) {
    return '±$value days';
  }

  @override
  String get chartCycleLength => 'Cycle length over time';

  @override
  String get trackTwoCycles => 'Track at least two cycles to see your trend.';

  @override
  String get mostCommonSymptoms => 'Most common symptoms';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get addReminder => 'Add reminder';

  @override
  String get webNotice =>
      'Scheduled notifications run on the mobile and desktop apps. They are not available in the web version.';

  @override
  String get cycleNotifications => 'Cycle notifications';

  @override
  String get notificationTime => 'Notification time';

  @override
  String get yourReminders => 'Your reminders';

  @override
  String get noCustomReminders => 'No custom reminders yet.';

  @override
  String get togglePeriodSoon => 'Period coming up (1 day before)';

  @override
  String get togglePeriodStart => 'Period start day';

  @override
  String get toggleFertileStart => 'Fertile window start';

  @override
  String get toggleOvulation => 'Ovulation day';

  @override
  String get togglePms => 'PMS reminder';

  @override
  String get togglePeriodLate => 'Period late reminder';

  @override
  String get repeatOnce => 'Once';

  @override
  String get repeatDaily => 'Daily';

  @override
  String get repeatWeekly => 'Weekly';

  @override
  String reminderSubtitle(String time, String repeat) {
    return '$time · $repeat';
  }

  @override
  String get newReminder => 'New reminder';

  @override
  String get editReminder => 'Edit reminder';

  @override
  String get fieldTitle => 'Title';

  @override
  String get titleHint => 'e.g. Take the pill';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get timeLabel => 'Time';

  @override
  String get saveReminder => 'Save reminder';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionCycle => 'Cycle';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get sectionPrivacySecurity => 'Privacy & security';

  @override
  String get sectionData => 'Data';

  @override
  String get sectionAbout => 'About';

  @override
  String get avgCycleLength => 'Average cycle length';

  @override
  String get avgPeriodLength => 'Average period length';

  @override
  String get lutealPhaseLength => 'Luteal phase length';

  @override
  String get adaptToHistory => 'Adapt to my history';

  @override
  String get adaptToHistorySub =>
      'Refine predictions from your logged cycles automatically';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get appLock => 'App lock';

  @override
  String get lockOff => 'Off';

  @override
  String get lockPin => 'PIN';

  @override
  String get lockBiometric => 'Biometric + PIN';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get exportBackupSub => 'Save your data as a .json file on this device';

  @override
  String get importBackup => 'Import backup';

  @override
  String get importBackupSub => 'Restore data from a .json backup file';

  @override
  String get copyAsJson => 'Copy as JSON';

  @override
  String get copyAsJsonSub => 'Copy all data to the clipboard';

  @override
  String get importFromClipboard => 'Import from clipboard';

  @override
  String get importFromClipboardSub => 'Paste JSON data to restore';

  @override
  String get deleteAllData => 'Delete all data';

  @override
  String aboutSubtitle(String version) {
    return 'Private, on-device cycle tracking · v$version';
  }

  @override
  String get privacyData => 'Privacy & data';

  @override
  String get privacyDataSub =>
      'No account, no cloud — everything stays on this device';

  @override
  String get privacyNote =>
      'Luna doesn\'t collect, transmit, or sell any of your data. Everything is stored and managed locally on your device.';

  @override
  String get medicalDisclaimer => 'Medical disclaimer';

  @override
  String get medicalDisclaimerSub =>
      'Predictions are estimates, not medical advice';

  @override
  String get medicalDisclaimerNote =>
      'Predictions are estimates and may not be perfectly accurate. Luna is not a medical device — please consult your doctor for medical advice or accurate results.';

  @override
  String get disclaimerDialogBody =>
      'Luna helps you track and understand your cycle, but its predictions — period dates, the fertile window and ovulation — are estimates based on the data you log. They may not be perfectly accurate and can be affected by many factors.\n\nLuna is not a medical device and does not provide medical advice, diagnosis, or contraception guidance. Please don\'t rely on it to prevent or achieve pregnancy.\n\nFor medical advice or accurate results, consult your doctor or a qualified healthcare professional.';

  @override
  String get privacyDialogTitle => 'Your privacy';

  @override
  String get privacyDialogBody =>
      'Luna is private by design.\n\n•  We don\'t collect, transmit, or sell any of your data.\n\n•  There is no account and no server — everything is stored locally on this device and never leaves it.\n\n•  Your information is protected by the app lock and your device\'s own security.\n\nYou stay in control: export or permanently delete your data anytime from Settings.';

  @override
  String get biometricsUnavailable =>
      'Biometrics unavailable — PIN lock enabled instead.';

  @override
  String get dataCopiedToClipboard => 'Data copied to clipboard as JSON.';

  @override
  String get couldntSaveFile =>
      'Couldn\'t save a file here — copied to clipboard instead.';

  @override
  String get backupSaved => 'Backup saved';

  @override
  String get copyPath => 'Copy path';

  @override
  String get backupFileTypeLabel => 'Luna backup';

  @override
  String get clipboardEmpty => 'Clipboard is empty.';

  @override
  String get notLunaBackup => 'That doesn\'t look like a Luna backup.';

  @override
  String get importBackupQuestion => 'Import backup?';

  @override
  String importBackupBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'This adds $count logged days from the backup, overwriting any days with the same date. Your other days are kept.',
      one:
          'This adds 1 logged day from the backup, overwriting any day with the same date. Your other days are kept.',
    );
    return '$_temp0';
  }

  @override
  String get importAction => 'Import';

  @override
  String importedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Imported $count days.',
      one: 'Imported 1 day.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllQuestion => 'Delete all data?';

  @override
  String get deleteAllBody =>
      'This permanently removes every logged day, reminder and setting from this device. This cannot be undone.';

  @override
  String get deleteEverything => 'Delete everything';

  @override
  String get language => 'Language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get dataLocked => 'Your data is locked';

  @override
  String get incorrectPin => 'Incorrect PIN, try again';

  @override
  String get setAppPin => 'Set app PIN';

  @override
  String get createPin => 'Create a PIN';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get choosePinHint => 'Choose a 4-digit PIN';

  @override
  String get reenterPin => 'Re-enter your PIN';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get getStarted => 'Get started';

  @override
  String get welcomeTitle => 'Welcome to Luna';

  @override
  String get welcomeBody =>
      'Track your period, ovulation and symptoms with a calm, modern calendar and helpful reminders.';

  @override
  String get welcomePrivacy =>
      'Your data stays private on this device — no account, no cloud.';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get chooseLanguageSub => 'You can change this later in Settings.';

  @override
  String get aFewDetails => 'A few details';

  @override
  String get lastPeriodStart => 'Last period start';

  @override
  String get enableReminders => 'Enable reminders';

  @override
  String get enableRemindersSub =>
      'Period, fertile window and ovulation alerts';

  @override
  String get notifPeriodSoonTitle => 'Period coming up';

  @override
  String get notifPeriodSoonBody => 'Your period may start tomorrow.';

  @override
  String get notifPeriodStartTitle => 'Period expected today';

  @override
  String get notifPeriodStartBody => 'Your period is predicted to start today.';

  @override
  String get notifPmsTitle => 'PMS window';

  @override
  String get notifPmsBody => 'PMS symptoms may begin over the next few days.';

  @override
  String get notifPeriodLateTitle => 'Period late?';

  @override
  String get notifPeriodLateBody =>
      'Your period hasn\'t been logged yet. Tap to log.';

  @override
  String get notifFertileTitle => 'Fertile window';

  @override
  String get notifFertileBody => 'Your fertile window is starting.';

  @override
  String get notifOvulationTitle => 'Ovulation day';

  @override
  String get notifOvulationBody => 'Estimated ovulation is today.';
}
