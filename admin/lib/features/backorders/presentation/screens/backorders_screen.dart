import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_backorders_provider.dart';

class BackordersScreen extends StatefulWidget {
  const BackordersScreen({super.key});

  @override
  State<BackordersScreen> createState() => _BackordersScreenState();
}

class _BackordersScreenState extends State<BackordersScreen> {
  late final AdminBackordersProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AdminBackordersProvider()..load();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.backorders),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminBackordersProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.load,
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminBackordersProvider>(
          builder: (context, provider, _) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (provider.error != null) ...[
                  Text(
                    provider.error!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                JsonPreviewCard(
                  title: context.l10n.backordersSummary,
                  json: provider.summary,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.load,
                ),
                const SizedBox(height: 12),
                JsonPreviewCard(
                  title: context.l10n.backorders,
                  json: provider.backorders,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.load,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
