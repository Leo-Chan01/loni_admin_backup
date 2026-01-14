import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/l10n_extensions.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.usersManagement),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
      ),
      body: Center(
        child: Text(context.l10n.usersManagementScreen),
      ),
    );
  }
}
