import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_orders_provider.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  late final AdminOrdersProvider _provider;

  final _orderIdController = TextEditingController();
  final _printerIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminOrdersProvider()
      ..loadOrders()
      ..loadKPIs();
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _printerIdController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await _provider.loadOrders();
    await _provider.loadKPIs();
  }

  Future<void> _loadDetail() async {
    final id = _orderIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    await _provider.loadOrderDetail(id);
  }

  Future<void> _cancel() async {
    final id = _orderIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    final ok = await _provider.cancelOrder(id);
    if (!mounted) return;
    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadOrderDetail(id);
      await _provider.loadOrders();
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  Future<void> _escalate() async {
    final id = _orderIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    final ok = await _provider.escalateOrder(id);
    if (!mounted) return;
    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadOrderDetail(id);
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  Future<void> _reassignPrinter() async {
    final id = _orderIdController.text.trim();
    final printerId = _printerIdController.text.trim();
    if (id.isEmpty || printerId.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    final ok = await _provider.reassignPrinter(
      orderId: id,
      printerId: printerId,
    );
    if (!mounted) return;
    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadOrderDetail(id);
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.ordersManagement),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminOrdersProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : _refresh,
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminOrdersProvider>(
          builder: (context, provider, _) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                if (provider.error != null) ...[
                  Text(
                    provider.error!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
                JsonPreviewCard(
                  title: context.l10n.ordersList,
                  json: provider.orders,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _refresh,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.orderKpis,
                  json: provider.kpis,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _refresh,
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.orderDetail,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _orderIdController,
                  label: context.l10n.orderId,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _loadDetail,
                    child: Text(context.l10n.loadDetail),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.detail,
                  json: provider.orderDetail,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadDetail,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _cancel,
                          child: Text(context.l10n.cancelOrder),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _escalate,
                          child: Text(context.l10n.escalateOrder),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.reassignPrinter,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _printerIdController,
                  label: context.l10n.printerId,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _reassignPrinter,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.lastResult,
                  json: provider.lastResult,
                  isLoading: false,
                  error: null,
                  onRefresh: null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
