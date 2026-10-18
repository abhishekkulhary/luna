import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../cycle/cycle_models.dart';
import 'enums.dart';

/// Localized labels and icons for the domain enums, used across the UI.
/// The `label(...)` methods take [AppLocalizations] so they translate with the
/// active locale; the icon/emoji getters are language-independent.

extension FlowIntensityX on FlowIntensity {
  String label(AppLocalizations l) => switch (this) {
        FlowIntensity.none => l.flowNone,
        FlowIntensity.spotting => l.flowSpotting,
        FlowIntensity.light => l.flowLight,
        FlowIntensity.medium => l.flowMedium,
        FlowIntensity.heavy => l.flowHeavy,
      };

  IconData get icon => switch (this) {
        FlowIntensity.none => Icons.block,
        FlowIntensity.spotting => Icons.water_drop_outlined,
        FlowIntensity.light => Icons.water_drop,
        FlowIntensity.medium => Icons.opacity,
        FlowIntensity.heavy => Icons.bloodtype,
      };
}

extension SymptomX on Symptom {
  String label(AppLocalizations l) => switch (this) {
        Symptom.cramps => l.symptomCramps,
        Symptom.headache => l.symptomHeadache,
        Symptom.backache => l.symptomBackache,
        Symptom.bloating => l.symptomBloating,
        Symptom.tenderBreasts => l.symptomTenderBreasts,
        Symptom.acne => l.symptomAcne,
        Symptom.nausea => l.symptomNausea,
        Symptom.fatigue => l.symptomFatigue,
        Symptom.cravings => l.symptomCravings,
        Symptom.insomnia => l.symptomInsomnia,
        Symptom.diarrhea => l.symptomDiarrhea,
        Symptom.constipation => l.symptomConstipation,
        Symptom.dizziness => l.symptomDizziness,
      };
}

extension MoodX on Mood {
  String label(AppLocalizations l) => switch (this) {
        Mood.happy => l.moodHappy,
        Mood.calm => l.moodCalm,
        Mood.energetic => l.moodEnergetic,
        Mood.sensitive => l.moodSensitive,
        Mood.sad => l.moodSad,
        Mood.irritable => l.moodIrritable,
        Mood.anxious => l.moodAnxious,
        Mood.tired => l.moodTired,
      };

  String get emoji => switch (this) {
        Mood.happy => '😊',
        Mood.calm => '😌',
        Mood.energetic => '⚡',
        Mood.sensitive => '🥺',
        Mood.sad => '😔',
        Mood.irritable => '😠',
        Mood.anxious => '😰',
        Mood.tired => '😴',
      };
}

extension CyclePhaseX on CyclePhase {
  String label(AppLocalizations l) => switch (this) {
        CyclePhase.menstruation => l.phaseMenstruation,
        CyclePhase.follicular => l.phaseFollicular,
        CyclePhase.fertile => l.phaseFertile,
        CyclePhase.ovulation => l.phaseOvulation,
        CyclePhase.luteal => l.phaseLuteal,
      };
}
