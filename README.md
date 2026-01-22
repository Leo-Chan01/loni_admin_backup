# LONI Admin Dashboard

A Flutter-based administrative dashboard for the LONI Africa platform. This application provides administrators with tools to manage users, orders, content moderation, and catalog compliance.

## Features

### 1. **Dashboard**
- Overview of key metrics (users, orders, revenue)
- Quick access to major admin functions
- System status monitoring
- Audit logs

### 2. **Users Management**
- Search and filter users
- View detailed user profiles
- Suspend/activate user accounts
- Update user roles and information
- Soft delete (anonymize) user accounts

### 3. **Orders Management**
- List all orders with filtering
- View order details and tracking information
- Cancel orders
- Escalate order issues
- Monitor order KPIs

### 4. **Content Moderation**
- Review submission tasks
- View detailed task information
- Track moderation events
- Update task status (PENDING, IN_REVIEW, APPROVED, REJECTED, ESCALATED)
- Add reviewer notes

### 5. **Catalog Management**
- View compliance flags
- Manage catalog items compliance
- Update compliance rules
- Monitor catalog compliance status

### 6. **Finance & Operations**
- Refunds: list + update
- Economics: view + update
- Markets: view + update region presets
- Reporting: view + export
- Backorders: list + summary
- Payouts: balances/pending/statements/batches + create batch + run scheduler + export batch
- Revenue splits: list/detail + create/update/delete + preview
- Ledger: post adjustments

## Project Structure

```
admin/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── config/
│   │   ├── routes/
│   │   │   └── app_routes.dart   # GoRouter configuration
│   │   └── theme/
│   │       └── app_theme.dart    # Material theme definitions
│   ├── core/
│   │   ├── providers/
│   │   │   └── app_provider.dart # Global app state
│   │   └── services/
│   │       └── api_client.dart   # HTTP client setup
│   └── features/
│       ├── auth/
│       │   ├── data/
│       │   │   └── services/
│       │   │       └── admin_auth_service.dart
│       │   └── presentation/
│       │       └── screens/
│       │           └── login_screen.dart
│       ├── dashboard/
│       │   ├── data/
│       │   │   └── services/
│       │   │       └── admin_dashboard_service.dart
│       │   └── presentation/
│       │       └── screens/
│       │           └── dashboard_screen.dart
│       ├── users/
│       │   ├── data/
│       │   │   └── services/
│       │   │       └── admin_user_service.dart
│       │   └── presentation/
│       │       └── screens/
│       │           └── users_list_screen.dart
│       ├── orders/
│       │   ├── data/
│       │   │   └── services/
│       │   │       └── admin_order_service.dart
│       │   └── presentation/
│       │       └── screens/
│       │           └── orders_list_screen.dart
│       ├── moderation/
│       │   ├── data/
│       │   │   └── services/
│       │   │       └── admin_moderation_service.dart
│       │   └── presentation/
│       │       └── screens/
│       │           └── moderation_tasks_screen.dart
│       └── catalog/
│           ├── data/
│           │   └── services/
│           │       └── admin_catalog_service.dart
│           └── presentation/
│               └── screens/
│                   └── catalog_management_screen.dart
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites
- Flutter 3.10.1 or higher
- Dart 3.10.1 or higher
- iOS 12.0+ or Android API level 21+

### Installation

1. Navigate to the admin app directory:
```bash
cd admin
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## API Integration

The admin app communicates with the LONI API at `https://loni.kouakoudomagni.com/v1`

### Authentication
All requests (except login) require Bearer token authentication via the `Authorization` header:
```
Authorization: Bearer <access_token>
```

### Key Endpoints Used

#### Authentication
- `POST /v1/auth/login` - Admin login
- `POST /v1/auth/token/refresh` - Refresh access token

#### Admin Operations
- `GET /v1/admin/health` - System health check
- `GET /v1/admin/overview` - Dashboard overview
- `GET /v1/admin/summary` - Admin summary
- `GET /v1/admin/audit` - Audit logs
- `GET /v1/admin/system/status` - System status
- `GET /v1/admin/system/features` - Feature flags
- `GET /v1/admin/system/roles` - Roles
- `GET /v1/admin/system/settings` - Settings

#### Users
- `GET /v1/admin/users` - List users (searchable)
- `GET /v1/admin/users/:userId` - Get user detail
- `PATCH /v1/admin/users/:userId` - Update user
- `POST /v1/admin/users/:userId/suspend` - Suspend user
- `POST /v1/admin/users/:userId/activate` - Activate user
- `POST /v1/admin/users/:userId/soft-delete` - Soft delete (anonymize) user

#### Orders
- `GET /v1/admin/orders` - List orders
- `GET /v1/admin/orders/:orderId` - Get order detail
- `POST /v1/admin/orders/:orderId/cancel` - Cancel order
- `POST /v1/admin/orders/:orderId/escalate` - Escalate order
- `GET /v1/admin/orders/kpis` - Order KPIs
- `POST /v1/admin/orders/:orderId/reassign-printer` - Reassign printer

#### Moderation
- `GET /v1/admin/moderation/tasks` - List moderation tasks
- `GET /v1/admin/moderation/tasks/:taskId` - Get task detail
- `GET /v1/admin/moderation/tasks/:taskId/events` - Get task events
- `PATCH /v1/admin/moderation/tasks/:taskId` - Update task status
- `GET /v1/admin/moderation/tasks/:taskId/epub` - Download EPUB

#### Catalog
- `GET /v1/admin/catalog/flags` - List compliance flags
- `GET /v1/admin/catalog/compliance` - List compliance rules
- `POST /v1/admin/catalog/compliance` - Create compliance rule
- `PATCH /v1/admin/catalog/compliance/:ruleId` - Update compliance rule
- `DELETE /v1/admin/catalog/compliance/:ruleId` - Delete compliance rule
- `POST /v1/admin/catalog/compliance/simulate` - Simulate compliance
- `GET /v1/admin/catalog/featured` - List featured
- `POST /v1/admin/catalog/featured/:itemId` - Set featured
- `GET /v1/admin/content/search` - Search content
- `GET /v1/admin/catalog/items/:itemId` - Get item detail
- `GET /v1/admin/catalog/items/:itemId/compliance` - Get item compliance
- `POST /v1/admin/catalog/items/:itemId/compliance` - Update compliance
- `POST /v1/admin/catalog/flags/:flagId/status` - Update flag status
- `PUT /v1/admin/catalog/items/:itemId/lifecycle/schedule` - Schedule lifecycle
- `POST /v1/admin/catalog/items/:itemId/lifecycle/publish` - Publish lifecycle
- `POST /v1/admin/catalog/items/:itemId/lifecycle/unpublish` - Unpublish lifecycle
- `POST /v1/admin/catalog/items/:itemId/lifecycle/cancel` - Cancel lifecycle

#### Refunds
- `GET /v1/admin/refunds` - List refunds
- `PATCH /v1/admin/refunds/:refundId` - Update refund

#### Economics
- `GET /v1/admin/economics` - Get economics
- `PUT /v1/admin/economics` - Update economics

#### Markets
- `GET /v1/admin/markets/region-presets` - Get region presets
- `PUT /v1/admin/markets/region-presets` - Update region presets

#### Reporting
- `GET /v1/admin/reporting` - Get reporting
- `GET /v1/admin/reporting/export` - Export reporting

#### Backorders
- `GET /v1/admin/backorders/summary` - Backorders summary
- `GET /v1/admin/backorders` - List backorders

#### Payouts
- `GET /v1/admin/payouts/balances` - Payout balances
- `GET /v1/admin/payouts/pending` - Pending payouts
- `GET /v1/admin/payouts/statements` - Payout statements
- `GET /v1/admin/payouts/batches` - Payout batches
- `POST /v1/admin/payouts/batch` - Create payout batch
- `POST /v1/admin/payouts/scheduler/run` - Run scheduler
- `GET /v1/admin/payouts/batches/:batchId/export` - Export batch

#### Revenue Splits
- `GET /v1/admin/revenue-splits` - List revenue splits
- `GET /v1/admin/revenue-splits/:splitId` - Get split
- `POST /v1/admin/revenue-splits` - Create split
- `PUT /v1/admin/revenue-splits/:splitId` - Update split
- `DELETE /v1/admin/revenue-splits/:splitId` - Delete split
- `POST /v1/admin/revenue-splits/preview` - Preview split

#### Ledger
- `POST /v1/admin/ledger/adjustment` - Post ledger adjustment

### API Implementation Status

Status key:
- ✅ Implemented end-to-end (service + provider + screen)
- ⚠️ Implemented, but export/download bytes are currently surfaced as metadata (e.g., `bytesLength`) rather than being saved to a file

As of 2026-01-14:
- ✅ Auth: login + refresh
- ✅ Dashboard: overview widgets and navigation
- ✅ System: health/overview/summary/audit + system status/features/roles/settings
- ✅ Users: search/detail/update + suspend/activate/soft-delete
- ✅ Orders: list/detail/KPIs + cancel/escalate + reassign printer
- ✅ Moderation: tasks/detail/events + update status + EPUB download ⚠️
- ✅ Catalog: flags/rules/featured + content search + item detail/compliance + simulate + lifecycle ops
- ✅ Refunds: list + update
- ✅ Economics: get + update
- ✅ Markets: get + update region presets
- ✅ Reporting: get + export ⚠️
- ✅ Backorders: summary + list
- ✅ Payouts: balances/pending/statements/batches + create batch + run scheduler + export ⚠️
- ✅ Revenue splits: list/detail + create/update/delete + preview
- ✅ Ledger: adjustment

## Architecture

The admin app follows **Clean Architecture** principles:

### Layer Structure
- **Presentation Layer**: UI screens and widgets
- **Data Layer**: API services and data models
- **Domain Layer**: Business logic and entities
- **Core Layer**: Utilities, constants, and shared services

### Key Patterns
- **Provider Pattern**: State management via `provider` package
- **Repository Pattern**: Abstraction of data sources
- **Service Locator**: Dependency injection via `get_it`
- **GoRouter**: Type-safe navigation

## Dependencies

### Core
- `flutter`: Flutter framework
- `provider`: State management
- `go_router`: Navigation and routing
- `dio`: HTTP client

### UI
- `flutter_screenutil`: Responsive design
- `hugeicons`: Icon library
- `data_table_2`: Advanced data tables

### Utilities
- `intl`: Internationalization
- `shared_preferences`: Local storage
- `logger`: Logging

## Running Tests

```bash
flutter test
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Environment Configuration

Create a `.env` file in the admin directory:
```
API_BASE_URL=https://loni.kouakoudomagni.com/v1
LOG_LEVEL=debug
```

## Troubleshooting

### Build Issues
- Run `flutter clean` if build fails
- Ensure dependencies are up to date: `flutter pub upgrade`

### Runtime Issues
- Check API credentials in login screen
- Verify API base URL in `api_client.dart`
- Review logs for detailed error messages

## Contributing

When adding new features:

1. Create new feature folder under `features/`
2. Follow the data → presentation layer structure
3. Add corresponding API service in `data/services/`
4. Implement screens in `presentation/screens/`
5. Update routing in `config/routes/app_routes.dart`

## Support

For issues or questions, refer to:
- [Flutter Documentation](https://flutter.dev/docs)
- [LONI API Documentation](../API-DOCUMENTATION.md)
- Project maintainers

## License

LONI Admin © 2024. All rights reserved.
