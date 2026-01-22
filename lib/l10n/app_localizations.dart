import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LONI Admin'**
  String get appTitle;

  /// No description provided for @adminSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Administrative Dashboard'**
  String get adminSubtitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated successfully'**
  String get updatedSuccessfully;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get updateFailed;

  /// No description provided for @invalidJsonPayload.
  ///
  /// In en, this message translates to:
  /// **'Invalid JSON payload'**
  String get invalidJsonPayload;

  /// No description provided for @lastResult.
  ///
  /// In en, this message translates to:
  /// **'Last result'**
  String get lastResult;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @moderation.
  ///
  /// In en, this message translates to:
  /// **'Moderation'**
  String get moderation;

  /// No description provided for @catalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get catalog;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @audit.
  ///
  /// In en, this message translates to:
  /// **'Audit'**
  String get audit;

  /// No description provided for @systemStatus.
  ///
  /// In en, this message translates to:
  /// **'System Status'**
  String get systemStatus;

  /// No description provided for @systemFeatures.
  ///
  /// In en, this message translates to:
  /// **'System Features'**
  String get systemFeatures;

  /// No description provided for @systemRoles.
  ///
  /// In en, this message translates to:
  /// **'System Roles'**
  String get systemRoles;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @refunds.
  ///
  /// In en, this message translates to:
  /// **'Refunds'**
  String get refunds;

  /// No description provided for @refundId.
  ///
  /// In en, this message translates to:
  /// **'Refund ID'**
  String get refundId;

  /// No description provided for @updateRefund.
  ///
  /// In en, this message translates to:
  /// **'Update refund'**
  String get updateRefund;

  /// No description provided for @economics.
  ///
  /// In en, this message translates to:
  /// **'Economics'**
  String get economics;

  /// No description provided for @currentEconomics.
  ///
  /// In en, this message translates to:
  /// **'Current economics'**
  String get currentEconomics;

  /// No description provided for @updateEconomics.
  ///
  /// In en, this message translates to:
  /// **'Update economics'**
  String get updateEconomics;

  /// No description provided for @markets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get markets;

  /// No description provided for @regionPresets.
  ///
  /// In en, this message translates to:
  /// **'Region presets'**
  String get regionPresets;

  /// No description provided for @updateRegionPresets.
  ///
  /// In en, this message translates to:
  /// **'Update region presets'**
  String get updateRegionPresets;

  /// No description provided for @reporting.
  ///
  /// In en, this message translates to:
  /// **'Reporting'**
  String get reporting;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportStarted.
  ///
  /// In en, this message translates to:
  /// **'Export started'**
  String get exportStarted;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get exportFailed;

  /// No description provided for @backorders.
  ///
  /// In en, this message translates to:
  /// **'Backorders'**
  String get backorders;

  /// No description provided for @backordersSummary.
  ///
  /// In en, this message translates to:
  /// **'Backorders summary'**
  String get backordersSummary;

  /// No description provided for @payouts.
  ///
  /// In en, this message translates to:
  /// **'Payouts'**
  String get payouts;

  /// No description provided for @payoutBalances.
  ///
  /// In en, this message translates to:
  /// **'Payout balances'**
  String get payoutBalances;

  /// No description provided for @payoutPending.
  ///
  /// In en, this message translates to:
  /// **'Pending payouts'**
  String get payoutPending;

  /// No description provided for @payoutStatements.
  ///
  /// In en, this message translates to:
  /// **'Payout statements'**
  String get payoutStatements;

  /// No description provided for @payoutBatches.
  ///
  /// In en, this message translates to:
  /// **'Payout batches'**
  String get payoutBatches;

  /// No description provided for @createBatch.
  ///
  /// In en, this message translates to:
  /// **'Create batch'**
  String get createBatch;

  /// No description provided for @runScheduler.
  ///
  /// In en, this message translates to:
  /// **'Run scheduler'**
  String get runScheduler;

  /// No description provided for @exportBatch.
  ///
  /// In en, this message translates to:
  /// **'Export batch'**
  String get exportBatch;

  /// No description provided for @batchId.
  ///
  /// In en, this message translates to:
  /// **'Batch ID'**
  String get batchId;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @run.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get run;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @revenueSplits.
  ///
  /// In en, this message translates to:
  /// **'Revenue splits'**
  String get revenueSplits;

  /// No description provided for @revenueSplitId.
  ///
  /// In en, this message translates to:
  /// **'Revenue split ID'**
  String get revenueSplitId;

  /// No description provided for @loadDetail.
  ///
  /// In en, this message translates to:
  /// **'Load detail'**
  String get loadDetail;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @ledger.
  ///
  /// In en, this message translates to:
  /// **'Ledger'**
  String get ledger;

  /// No description provided for @ledgerAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Ledger adjustment'**
  String get ledgerAdjustment;

  /// No description provided for @readingReport.
  ///
  /// In en, this message translates to:
  /// **'Reading Report'**
  String get readingReport;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @viewJson.
  ///
  /// In en, this message translates to:
  /// **'View JSON'**
  String get viewJson;

  /// No description provided for @copyJson.
  ///
  /// In en, this message translates to:
  /// **'Copy JSON'**
  String get copyJson;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @jsonPayload.
  ///
  /// In en, this message translates to:
  /// **'JSON payload'**
  String get jsonPayload;

  /// No description provided for @jsonPayloadHint.
  ///
  /// In en, this message translates to:
  /// **'\"key\": \"value\"'**
  String get jsonPayloadHint;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchQuery.
  ///
  /// In en, this message translates to:
  /// **'Search query'**
  String get searchQuery;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get searchResults;

  /// No description provided for @usersManagement.
  ///
  /// In en, this message translates to:
  /// **'Users Management'**
  String get usersManagement;

  /// No description provided for @ordersManagement.
  ///
  /// In en, this message translates to:
  /// **'Orders Management'**
  String get ordersManagement;

  /// No description provided for @moderationTasks.
  ///
  /// In en, this message translates to:
  /// **'Moderation Tasks'**
  String get moderationTasks;

  /// No description provided for @catalogManagement.
  ///
  /// In en, this message translates to:
  /// **'Catalog Management'**
  String get catalogManagement;

  /// No description provided for @searchUsers.
  ///
  /// In en, this message translates to:
  /// **'Search users'**
  String get searchUsers;

  /// No description provided for @roleOptional.
  ///
  /// In en, this message translates to:
  /// **'Role (optional)'**
  String get roleOptional;

  /// No description provided for @userDetail.
  ///
  /// In en, this message translates to:
  /// **'User detail'**
  String get userDetail;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @updateUser.
  ///
  /// In en, this message translates to:
  /// **'Update user'**
  String get updateUser;

  /// No description provided for @suspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get suspend;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @softDelete.
  ///
  /// In en, this message translates to:
  /// **'Soft delete'**
  String get softDelete;

  /// No description provided for @ordersList.
  ///
  /// In en, this message translates to:
  /// **'Orders list'**
  String get ordersList;

  /// No description provided for @orderKpis.
  ///
  /// In en, this message translates to:
  /// **'Order KPIs'**
  String get orderKpis;

  /// No description provided for @orderDetail.
  ///
  /// In en, this message translates to:
  /// **'Order detail'**
  String get orderDetail;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get cancelOrder;

  /// No description provided for @escalateOrder.
  ///
  /// In en, this message translates to:
  /// **'Escalate order'**
  String get escalateOrder;

  /// No description provided for @reassignPrinter.
  ///
  /// In en, this message translates to:
  /// **'Reassign printer'**
  String get reassignPrinter;

  /// No description provided for @printerId.
  ///
  /// In en, this message translates to:
  /// **'Printer ID'**
  String get printerId;

  /// No description provided for @moderationTasksList.
  ///
  /// In en, this message translates to:
  /// **'Moderation tasks list'**
  String get moderationTasksList;

  /// No description provided for @taskActions.
  ///
  /// In en, this message translates to:
  /// **'Task actions'**
  String get taskActions;

  /// No description provided for @taskId.
  ///
  /// In en, this message translates to:
  /// **'Task ID'**
  String get taskId;

  /// No description provided for @loadEvents.
  ///
  /// In en, this message translates to:
  /// **'Load events'**
  String get loadEvents;

  /// No description provided for @taskDetail.
  ///
  /// In en, this message translates to:
  /// **'Task detail'**
  String get taskDetail;

  /// No description provided for @taskEvents.
  ///
  /// In en, this message translates to:
  /// **'Task events'**
  String get taskEvents;

  /// No description provided for @updateTaskStatus.
  ///
  /// In en, this message translates to:
  /// **'Update task status'**
  String get updateTaskStatus;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @reviewerNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Reviewer notes (optional)'**
  String get reviewerNotesOptional;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @downloadEpub.
  ///
  /// In en, this message translates to:
  /// **'Download EPUB'**
  String get downloadEpub;

  /// No description provided for @catalogFlags.
  ///
  /// In en, this message translates to:
  /// **'Catalog flags'**
  String get catalogFlags;

  /// No description provided for @catalogComplianceRules.
  ///
  /// In en, this message translates to:
  /// **'Catalog compliance rules'**
  String get catalogComplianceRules;

  /// No description provided for @catalogFeatured.
  ///
  /// In en, this message translates to:
  /// **'Catalog featured'**
  String get catalogFeatured;

  /// No description provided for @contentSearch.
  ///
  /// In en, this message translates to:
  /// **'Content search'**
  String get contentSearch;

  /// No description provided for @catalogItem.
  ///
  /// In en, this message translates to:
  /// **'Catalog item'**
  String get catalogItem;

  /// No description provided for @itemId.
  ///
  /// In en, this message translates to:
  /// **'Item ID'**
  String get itemId;

  /// No description provided for @itemCompliance.
  ///
  /// In en, this message translates to:
  /// **'Item compliance'**
  String get itemCompliance;

  /// No description provided for @updateItemCompliance.
  ///
  /// In en, this message translates to:
  /// **'Update item compliance'**
  String get updateItemCompliance;

  /// No description provided for @simulateCompliance.
  ///
  /// In en, this message translates to:
  /// **'Simulate compliance'**
  String get simulateCompliance;

  /// No description provided for @updateFlagStatus.
  ///
  /// In en, this message translates to:
  /// **'Update flag status'**
  String get updateFlagStatus;

  /// No description provided for @flagId.
  ///
  /// In en, this message translates to:
  /// **'Flag ID'**
  String get flagId;

  /// No description provided for @setFeatured.
  ///
  /// In en, this message translates to:
  /// **'Set featured'**
  String get setFeatured;

  /// No description provided for @lifecycle.
  ///
  /// In en, this message translates to:
  /// **'Lifecycle'**
  String get lifecycle;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @unpublish.
  ///
  /// In en, this message translates to:
  /// **'Unpublish'**
  String get unpublish;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @usersManagementScreen.
  ///
  /// In en, this message translates to:
  /// **'Users Management Screen'**
  String get usersManagementScreen;

  /// No description provided for @ordersManagementScreen.
  ///
  /// In en, this message translates to:
  /// **'Orders Management Screen'**
  String get ordersManagementScreen;

  /// No description provided for @moderationTasksScreen.
  ///
  /// In en, this message translates to:
  /// **'Moderation Tasks Screen'**
  String get moderationTasksScreen;

  /// No description provided for @catalogManagementScreen.
  ///
  /// In en, this message translates to:
  /// **'Catalog Management Screen'**
  String get catalogManagementScreen;
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
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
