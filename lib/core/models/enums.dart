/// Domain enums shared across the data layer, prediction engine and UI.
/// Kept free of Flutter/Drift imports so the pure-Dart engine can use them.
library;

/// Menstrual flow intensity logged for a day.
enum FlowIntensity { none, spotting, light, medium, heavy }

/// Moods a user can tag on a day (multi-select).
enum Mood { happy, calm, energetic, sensitive, sad, irritable, anxious, tired }

/// Symptoms a user can tag on a day (multi-select).
enum Symptom {
  cramps,
  headache,
  backache,
  bloating,
  tenderBreasts,
  acne,
  nausea,
  fatigue,
  cravings,
  insomnia,
  diarrhea,
  constipation,
  dizziness,
}

/// How a custom reminder repeats.
enum ReminderRepeat { once, daily, weekly }

/// App-lock mechanism.
enum AppLockType { none, pin, biometric }

/// User theme preference.
enum ThemeModeSetting { system, light, dark }
