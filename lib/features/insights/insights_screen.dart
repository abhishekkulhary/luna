import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/models/enum_labels.dart';
import '../../core/theme/cycle_colors.dart';
import '../../l10n/app_localizations.dart';
import 'insights_data.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(insightsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).insightsTitle)),
      body: !data.hasData
          ? const _EmptyInsights()
          : ListView(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
              children: [
                _StatCards(data: data),
                const SizedBox(height: 12),
                _ChartCard(data: data),
                const SizedBox(height: 12),
                _SymptomsCard(data: data),
              ],
            ),
    );
  }
}

class _EmptyInsights extends StatelessWidget {
  const _EmptyInsights();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.insights_outlined,
                size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).insightsEmpty,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCards extends StatelessWidget {
  const _StatCards({required this.data});
  final InsightsData data;

  @override
  Widget build(BuildContext context) {
    final cc = context.cycleColors;
    final l10n = AppLocalizations.of(context);
    final std = data.cycleLengthStdDev;
    final regularity = std == null
        ? l10n.keepLogging
        : data.isRegular
            ? l10n.regular
            : l10n.irregular;
    final regularitySub =
        std == null ? '—' : l10n.plusMinusDays(std.toStringAsFixed(1));

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            label: l10n.statAvgCycle,
            value: '${data.avgCycleLength}',
            unit: l10n.daysUnit,
            color: cc.ovulation,
            icon: Icons.autorenew,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            label: l10n.statAvgPeriod,
            value: '${data.avgPeriodLength}',
            unit: l10n.daysUnit,
            color: cc.period,
            icon: Icons.water_drop,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            label: l10n.statRegularity,
            value: regularity,
            unit: regularitySub,
            color: cc.fertile,
            icon: Icons.show_chart,
            valueFontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
    this.valueFontSize = 26,
  });

  final String label;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 10),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(unit,
                style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.data});
  final InsightsData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final completed =
        data.records.where((r) => r.cycleLength != null).toList();
    final shown = completed.length > 8
        ? completed.sublist(completed.length - 8)
        : completed;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chartCycleLength,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            if (shown.length < 2)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  l10n.trackTwoCycles,
                  style: theme.textTheme.bodyMedium,
                ),
              )
            else
              SizedBox(
                height: 200,
                child: _CycleLengthChart(records: shown),
              ),
          ],
        ),
      ),
    );
  }
}

class _CycleLengthChart extends StatelessWidget {
  const _CycleLengthChart({required this.records});
  final List<CycleRecord> records;

  @override
  Widget build(BuildContext context) {
    final cc = context.cycleColors;
    final theme = Theme.of(context);
    final values = records.map((r) => r.cycleLength!).toList();
    final maxY = (values.reduce((a, b) => a > b ? a : b) + 6).toDouble();
    final minY = (values.reduce((a, b) => a < b ? a : b) - 6)
        .clamp(0, 100)
        .toDouble();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: minY,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 7,
          getDrawingHorizontalLine: (v) =>
              FlLine(color: theme.dividerColor, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 7,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= records.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    DateFormat('MMM', AppLocalizations.of(context).localeName)
                        .format(records[i].startDate),
                    style: theme.textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < values.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i].toDouble(),
                  color: cc.ovulation,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _SymptomsCard extends StatelessWidget {
  const _SymptomsCard({required this.data});
  final InsightsData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    if (data.topSymptoms.isEmpty) return const SizedBox.shrink();
    final max = data.topSymptoms.first.value;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.mostCommonSymptoms,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            for (final entry in data.topSymptoms)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(entry.key.label(l10n),
                          style: theme.textTheme.bodyMedium),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: entry.value / max,
                          minHeight: 10,
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                          color: context.cycleColors.pms,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('${entry.value}×', style: theme.textTheme.labelMedium),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
