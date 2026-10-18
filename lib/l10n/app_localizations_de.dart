// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Luna';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get done => 'Fertig';

  @override
  String get gotIt => 'Verstanden';

  @override
  String get ok => 'OK';

  @override
  String get pickTimeTitle => 'Uhrzeit wählen';

  @override
  String get daysUnit => 'Tage';

  @override
  String get navCalendar => 'Kalender';

  @override
  String get navInsights => 'Einblicke';

  @override
  String get navReminders => 'Erinnerungen';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get flowNone => 'Keine';

  @override
  String get flowSpotting => 'Schmierblutung';

  @override
  String get flowLight => 'Leicht';

  @override
  String get flowMedium => 'Mittel';

  @override
  String get flowHeavy => 'Stark';

  @override
  String get symptomCramps => 'Krämpfe';

  @override
  String get symptomHeadache => 'Kopfschmerzen';

  @override
  String get symptomBackache => 'Rückenschmerzen';

  @override
  String get symptomBloating => 'Blähungen';

  @override
  String get symptomTenderBreasts => 'Brustspannen';

  @override
  String get symptomAcne => 'Akne';

  @override
  String get symptomNausea => 'Übelkeit';

  @override
  String get symptomFatigue => 'Müdigkeit';

  @override
  String get symptomCravings => 'Heißhunger';

  @override
  String get symptomInsomnia => 'Schlaflosigkeit';

  @override
  String get symptomDiarrhea => 'Durchfall';

  @override
  String get symptomConstipation => 'Verstopfung';

  @override
  String get symptomDizziness => 'Schwindel';

  @override
  String get moodHappy => 'Glücklich';

  @override
  String get moodCalm => 'Ruhig';

  @override
  String get moodEnergetic => 'Energiegeladen';

  @override
  String get moodSensitive => 'Empfindlich';

  @override
  String get moodSad => 'Traurig';

  @override
  String get moodIrritable => 'Reizbar';

  @override
  String get moodAnxious => 'Ängstlich';

  @override
  String get moodTired => 'Müde';

  @override
  String get phaseMenstruation => 'Menstruation';

  @override
  String get phaseFollicular => 'Follikelphase';

  @override
  String get phaseFertile => 'Fruchtbares Fenster';

  @override
  String get phaseOvulation => 'Eisprung';

  @override
  String get phaseLuteal => 'Lutealphase';

  @override
  String get calendarTitle => 'Zyklus';

  @override
  String get today => 'Heute';

  @override
  String get logToday => 'Heute eintragen';

  @override
  String get logDay => 'Tag eintragen';

  @override
  String get calendarFormatMonth => 'Monat';

  @override
  String get calendarFormatWeek => 'Woche';

  @override
  String get noPredictionsYet =>
      'Trage deine erste Periode ein, um Vorhersagen zu sehen.';

  @override
  String cycleDayOf(int day) {
    return 'Tag $day deines Zyklus';
  }

  @override
  String nextPeriodIn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nächste Periode in $count Tagen',
      one: 'Nächste Periode in 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get periodExpectedToday => 'Periode heute erwartet';

  @override
  String periodLateBy(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Periode $count Tage überfällig',
      one: 'Periode 1 Tag überfällig',
    );
    return '$_temp0';
  }

  @override
  String get legendPeriod => 'Periode';

  @override
  String get legendPredicted => 'Vorhergesagt';

  @override
  String get legendFertile => 'Fruchtbar';

  @override
  String get legendOvulation => 'Eisprung';

  @override
  String get tagPredictedPeriod => 'Vorhergesagte Periode';

  @override
  String get noLogForDay => 'Kein Eintrag für diesen Tag.';

  @override
  String flowValueLabel(String flow) {
    return 'Blutung: $flow';
  }

  @override
  String get editLog => 'Eintrag bearbeiten';

  @override
  String get deleteLog => 'Eintrag löschen';

  @override
  String get sectionFlow => 'Blutung';

  @override
  String get sectionSymptoms => 'Symptome';

  @override
  String get sectionMood => 'Stimmung';

  @override
  String get sectionNotes => 'Notizen';

  @override
  String get notesHint => 'Alles, woran du dich erinnern möchtest …';

  @override
  String get intimacy => 'Intimität';

  @override
  String get insightsTitle => 'Einblicke';

  @override
  String get insightsEmpty =>
      'Trage ein paar Zyklen ein, um Einblicke in deine Muster zu erhalten.';

  @override
  String get keepLogging => 'Weiter eintragen';

  @override
  String get regular => 'Regelmäßig';

  @override
  String get irregular => 'Unregelmäßig';

  @override
  String get statAvgCycle => 'Ø Zyklus';

  @override
  String get statAvgPeriod => 'Ø Periode';

  @override
  String get statRegularity => 'Regelmäßigkeit';

  @override
  String plusMinusDays(String value) {
    return '±$value Tage';
  }

  @override
  String get chartCycleLength => 'Zykluslänge im Verlauf';

  @override
  String get trackTwoCycles =>
      'Erfasse mindestens zwei Zyklen, um deinen Trend zu sehen.';

  @override
  String get mostCommonSymptoms => 'Häufigste Symptome';

  @override
  String get remindersTitle => 'Erinnerungen';

  @override
  String get addReminder => 'Erinnerung hinzufügen';

  @override
  String get webNotice =>
      'Geplante Benachrichtigungen funktionieren in den Apps für Mobilgeräte und Desktop. In der Webversion sind sie nicht verfügbar.';

  @override
  String get cycleNotifications => 'Zyklus-Benachrichtigungen';

  @override
  String get notificationTime => 'Benachrichtigungszeit';

  @override
  String get yourReminders => 'Deine Erinnerungen';

  @override
  String get noCustomReminders => 'Noch keine eigenen Erinnerungen.';

  @override
  String get togglePeriodSoon => 'Periode steht bevor (1 Tag vorher)';

  @override
  String get togglePeriodStart => 'Erster Tag der Periode';

  @override
  String get toggleFertileStart => 'Beginn des fruchtbaren Fensters';

  @override
  String get toggleOvulation => 'Tag des Eisprungs';

  @override
  String get togglePms => 'PMS-Erinnerung';

  @override
  String get togglePeriodLate => 'Erinnerung bei überfälliger Periode';

  @override
  String get repeatOnce => 'Einmal';

  @override
  String get repeatDaily => 'Täglich';

  @override
  String get repeatWeekly => 'Wöchentlich';

  @override
  String reminderSubtitle(String time, String repeat) {
    return '$time · $repeat';
  }

  @override
  String get newReminder => 'Neue Erinnerung';

  @override
  String get editReminder => 'Erinnerung bearbeiten';

  @override
  String get fieldTitle => 'Titel';

  @override
  String get titleHint => 'z. B. Pille nehmen';

  @override
  String get noteOptional => 'Notiz (optional)';

  @override
  String get timeLabel => 'Uhrzeit';

  @override
  String get saveReminder => 'Erinnerung speichern';

  @override
  String get weekdayMon => 'Mo';

  @override
  String get weekdayTue => 'Di';

  @override
  String get weekdayWed => 'Mi';

  @override
  String get weekdayThu => 'Do';

  @override
  String get weekdayFri => 'Fr';

  @override
  String get weekdaySat => 'Sa';

  @override
  String get weekdaySun => 'So';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get sectionCycle => 'Zyklus';

  @override
  String get sectionAppearance => 'Darstellung';

  @override
  String get sectionPrivacySecurity => 'Datenschutz & Sicherheit';

  @override
  String get sectionData => 'Daten';

  @override
  String get sectionAbout => 'Über';

  @override
  String get avgCycleLength => 'Durchschnittliche Zykluslänge';

  @override
  String get avgPeriodLength => 'Durchschnittliche Periodendauer';

  @override
  String get lutealPhaseLength => 'Länge der Lutealphase';

  @override
  String get adaptToHistory => 'An meinen Verlauf anpassen';

  @override
  String get adaptToHistorySub =>
      'Vorhersagen automatisch anhand deiner erfassten Zyklen verfeinern';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get appLock => 'App-Sperre';

  @override
  String get lockOff => 'Aus';

  @override
  String get lockPin => 'PIN';

  @override
  String get lockBiometric => 'Biometrie + PIN';

  @override
  String get exportBackup => 'Backup exportieren';

  @override
  String get exportBackupSub =>
      'Speichere deine Daten als .json-Datei auf diesem Gerät';

  @override
  String get importBackup => 'Backup importieren';

  @override
  String get importBackupSub =>
      'Daten aus einer .json-Backupdatei wiederherstellen';

  @override
  String get copyAsJson => 'Als JSON kopieren';

  @override
  String get copyAsJsonSub => 'Alle Daten in die Zwischenablage kopieren';

  @override
  String get importFromClipboard => 'Aus Zwischenablage importieren';

  @override
  String get importFromClipboardSub =>
      'JSON-Daten zum Wiederherstellen einfügen';

  @override
  String get deleteAllData => 'Alle Daten löschen';

  @override
  String aboutSubtitle(String version) {
    return 'Private Zyklus-Verfolgung auf dem Gerät · v$version';
  }

  @override
  String get privacyData => 'Datenschutz & Daten';

  @override
  String get privacyDataSub =>
      'Kein Konto, keine Cloud – alles bleibt auf diesem Gerät';

  @override
  String get privacyNote =>
      'Luna sammelt, überträgt oder verkauft keine deiner Daten. Alles wird lokal auf deinem Gerät gespeichert und verwaltet.';

  @override
  String get medicalDisclaimer => 'Medizinischer Hinweis';

  @override
  String get medicalDisclaimerSub =>
      'Vorhersagen sind Schätzungen, kein medizinischer Rat';

  @override
  String get medicalDisclaimerNote =>
      'Vorhersagen sind Schätzungen und möglicherweise nicht völlig genau. Luna ist kein Medizinprodukt – bitte konsultiere für medizinischen Rat oder genaue Ergebnisse deine Ärztin oder deinen Arzt.';

  @override
  String get disclaimerDialogBody =>
      'Luna hilft dir, deinen Zyklus zu verfolgen und zu verstehen, doch die Vorhersagen – Periodentermine, das fruchtbare Fenster und der Eisprung – sind Schätzungen auf Basis der von dir eingetragenen Daten. Sie sind möglicherweise nicht völlig genau und können von vielen Faktoren beeinflusst werden.\n\nLuna ist kein Medizinprodukt und bietet keinen medizinischen Rat, keine Diagnose und keine Verhütungsberatung. Bitte verlasse dich nicht darauf, um eine Schwangerschaft zu verhindern oder herbeizuführen.\n\nFür medizinischen Rat oder genaue Ergebnisse wende dich an deine Ärztin, deinen Arzt oder an qualifiziertes medizinisches Fachpersonal.';

  @override
  String get privacyDialogTitle => 'Deine Privatsphäre';

  @override
  String get privacyDialogBody =>
      'Luna ist von Grund auf privat.\n\n•  Wir sammeln, übertragen oder verkaufen keine deiner Daten.\n\n•  Es gibt kein Konto und keinen Server – alles wird lokal auf diesem Gerät gespeichert und verlässt es nie.\n\n•  Deine Informationen sind durch die App-Sperre und die Sicherheit deines Geräts geschützt.\n\nDu behältst die Kontrolle: Du kannst deine Daten jederzeit in den Einstellungen exportieren oder dauerhaft löschen.';

  @override
  String get biometricsUnavailable =>
      'Biometrie nicht verfügbar – stattdessen PIN-Sperre aktiviert.';

  @override
  String get dataCopiedToClipboard =>
      'Daten als JSON in die Zwischenablage kopiert.';

  @override
  String get couldntSaveFile =>
      'Datei konnte hier nicht gespeichert werden – stattdessen in die Zwischenablage kopiert.';

  @override
  String get backupSaved => 'Backup gespeichert';

  @override
  String get copyPath => 'Pfad kopieren';

  @override
  String get backupFileTypeLabel => 'Luna-Backup';

  @override
  String get clipboardEmpty => 'Zwischenablage ist leer.';

  @override
  String get notLunaBackup => 'Das sieht nicht nach einem Luna-Backup aus.';

  @override
  String get importBackupQuestion => 'Backup importieren?';

  @override
  String importBackupBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Dies fügt $count eingetragene Tage aus dem Backup hinzu und überschreibt alle Tage mit demselben Datum. Deine übrigen Tage bleiben erhalten.',
      one:
          'Dies fügt 1 eingetragenen Tag aus dem Backup hinzu und überschreibt alle Tage mit demselben Datum. Deine übrigen Tage bleiben erhalten.',
    );
    return '$_temp0';
  }

  @override
  String get importAction => 'Importieren';

  @override
  String importedDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage importiert.',
      one: '1 Tag importiert.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllQuestion => 'Alle Daten löschen?';

  @override
  String get deleteAllBody =>
      'Dies entfernt dauerhaft jeden eingetragenen Tag, jede Erinnerung und jede Einstellung von diesem Gerät. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get deleteEverything => 'Alles löschen';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystemDefault => 'Systemstandard';

  @override
  String get enterPin => 'PIN eingeben';

  @override
  String get dataLocked => 'Deine Daten sind gesperrt';

  @override
  String get incorrectPin => 'Falsche PIN, versuche es erneut';

  @override
  String get setAppPin => 'App-PIN festlegen';

  @override
  String get createPin => 'PIN erstellen';

  @override
  String get confirmPin => 'PIN bestätigen';

  @override
  String get choosePinHint => 'Wähle eine 4-stellige PIN';

  @override
  String get reenterPin => 'Gib deine PIN erneut ein';

  @override
  String get onboardingContinue => 'Weiter';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get welcomeTitle => 'Willkommen bei Luna';

  @override
  String get welcomeBody =>
      'Verfolge deine Periode, deinen Eisprung und deine Symptome mit einem ruhigen, modernen Kalender und hilfreichen Erinnerungen.';

  @override
  String get welcomePrivacy =>
      'Deine Daten bleiben privat auf diesem Gerät – kein Konto, keine Cloud.';

  @override
  String get chooseLanguage => 'Wähle deine Sprache';

  @override
  String get chooseLanguageSub =>
      'Du kannst dies später in den Einstellungen ändern.';

  @override
  String get aFewDetails => 'Ein paar Angaben';

  @override
  String get lastPeriodStart => 'Beginn der letzten Periode';

  @override
  String get enableReminders => 'Erinnerungen aktivieren';

  @override
  String get enableRemindersSub =>
      'Hinweise zu Periode, fruchtbarem Fenster und Eisprung';

  @override
  String get notifPeriodSoonTitle => 'Periode steht bevor';

  @override
  String get notifPeriodSoonBody => 'Deine Periode könnte morgen beginnen.';

  @override
  String get notifPeriodStartTitle => 'Periode heute erwartet';

  @override
  String get notifPeriodStartBody =>
      'Deine Periode beginnt voraussichtlich heute.';

  @override
  String get notifPmsTitle => 'PMS-Fenster';

  @override
  String get notifPmsBody =>
      'PMS-Symptome könnten in den nächsten Tagen beginnen.';

  @override
  String get notifPeriodLateTitle => 'Periode überfällig?';

  @override
  String get notifPeriodLateBody =>
      'Deine Periode wurde noch nicht eingetragen. Zum Eintragen tippen.';

  @override
  String get notifFertileTitle => 'Fruchtbares Fenster';

  @override
  String get notifFertileBody => 'Dein fruchtbares Fenster beginnt.';

  @override
  String get notifOvulationTitle => 'Tag des Eisprungs';

  @override
  String get notifOvulationBody => 'Der geschätzte Eisprung ist heute.';
}
