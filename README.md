# 📋 Smart Task Management App

A professional Flutter-based task management application with real-time API integration, advanced filtering, and a beautiful, intuitive UI. Built with GetX state management and Material Design 3 principles.

![Main Screen](app%20screenshorts/main%20screen.png)

---

## 🌟 Features

### Core Functionality

- **Task CRUD Operations**: Create, read, update, and delete tasks seamlessly
- **Real-time Synchronization**: Automatic task list refresh after updates without manual reload
- **Smart Filtering**: Multi-criteria filtering by status, category, and priority
- **Advanced Search**: Quick search functionality to find tasks instantly
- **Responsive UI**: Beautiful card-based layout with Material Design 3

### Task Management

- **Status Tracking**: `Pending`, `In Progress`, `Completed`
- **Priority Levels**: `Low`, `Medium`, `High` with color-coded indicators
- **Categories**: `Scheduling`, `Finance`, `Technical`, `Safety`, `General`
- **Due Date Management**: Calendar picker for deadline assignment
- **Task Assignment**: Assign tasks to team members

### UI/UX Highlights

- **Swipe Actions**: Slidable task cards for quick delete operations
- **Chip-based Filters**: Visual, interactive filter chips for better UX
- **Dialog-based Workflows**: Non-intrusive update and detail views
- **Adaptive Sizing**: Dialogs sized to content for optimal space usage
- **Color-coded Elements**: Visual indicators for categories and priorities

---

## 📸 Screenshots

### Main Interface

The home screen displays all tasks in a scrollable card layout with status, category, and priority indicators.

![Main Screen](app%20screenshorts/main%20screen.png)

### Creating Tasks with Auto-Suggestions

Smart category and priority auto-suggestions while creating new tasks.

![Create Task with Auto-Suggestions](app%20screenshorts/update%20priority%20iwhile%20creating.png)
![Auto Category and Priority](app%20screenshorts/Update%20screen%20with%20auto%20category%20and%20priority.png)

### Task Update Interface

Beautiful, compact dialog for updating task details without leaving the main screen.

![Update Task Dialog](app%20screenshorts/update%20task.png)
![Updated Task UI](app%20screenshorts/Updated%20task%20UI.png)
![Updated Task List](app%20screenshorts/Updated%20task%20list.png)

### Advanced Filtering

Multi-criteria filtering with visual chip-based UI for status, category, and priority.

![Filter Interface](app%20screenshorts/filter.png)
![Filter UI](app%20screenshorts/filter_ui.png)

### Task Search

Real-time search functionality to quickly find specific tasks.

![Search](app%20screenshorts/search.png)

### Delete Operations

Swipe-to-delete with confirmation dialogs to prevent accidental deletions.

![Delete Task](app%20screenshorts/delete%20task.png)
![Delete Task UI](app%20screenshorts/delete%20task%20UI.png)

---

## 🏗️ Architecture

### Project Structure

```
lib/
├── core/
│   ├── api/
│   │   └── api_service.dart          # API client with Dio
│   └── constants/
│       └── app_constants.dart         # API endpoints & constants
├── features/
│   └── tasks/
│       ├── controller/
│       │   ├── task_controller.dart        # Main task state management
│       │   ├── update_controller.dart      # Update dialog logic
│       │   └── date_picker_controller.dart # Date selection
│       ├── model/
│       │   └── task_model.dart            # Task data model
│       └── view/
│           ├── task_home_view.dart        # Main screen
│           ├── task_detailed_view.dart    # Detailed task dialog
│           ├── helper/
│           │   └── helper.dart            # UI utilities & colors
│           └── widget/
│               ├── update_alert_box.dart  # Update dialog
│               ├── filter_widget.dart     # Filter UI
│               └── bottom_sheet.dart      # Bottom sheets
└── main.dart                              # App entry point
```

### Design Patterns

- **MVC Architecture**: Clear separation of concerns
- **GetX State Management**: Reactive programming with minimal boilerplate
- **Repository Pattern**: Centralized API service layer
- **Observer Pattern**: Real-time UI updates via GetX observables

---

## 🛠️ Tech Stack

### Framework & Language

- **Flutter** `3.5.4+` - Cross-platform UI framework
- **Dart** `3.5.4+` - Programming language

### Core Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.3 # State management & navigation
  dio: ^5.9.0 # HTTP client for REST API
  intl: ^0.20.2 # Internationalization & date formatting
  flutter_svg: ^2.1.0 # SVG asset support
  flutter_slidable: ^3.1.2 # Swipe actions on list items
  cupertino_icons: ^1.0.8 # iOS-style icons
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `3.5.4` or higher
- Dart SDK `3.5.4` or higher
- Android Studio / VS Code with Flutter extensions
- An Android/iOS emulator or physical device

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd task_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure API endpoint** (Optional)

   Update the API base URL in `lib/core/constants/app_constants.dart`:

   ```dart
   static const String apiBaseUrl = "https://smart-tasks-api.onrender.com";
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK**

```bash
flutter build apk --release
```

**iOS IPA**

```bash
flutter build ios --release
```

**Web**

```bash
flutter build web --release
```

---

## 🔌 API Integration

### Base URL

```
https://smart-tasks-api.onrender.com
```

### Endpoints

| Method   | Endpoint                                                             | Description       |
| -------- | -------------------------------------------------------------------- | ----------------- |
| `GET`    | `/api/tasks`                                                         | Fetch all tasks   |
| `GET`    | `/api/tasks?status=<status>&category=<category>&priority=<priority>` | Filter tasks      |
| `POST`   | `/api/tasks`                                                         | Create a new task |
| `PATCH`  | `/api/tasks/:id`                                                     | Update task by ID |
| `DELETE` | `/api/tasks/:id`                                                     | Delete task by ID |

### Request/Response Examples

**Create Task (POST)**

```json
{
  "title": "Implement login screen",
  "description": "Create responsive login UI with validation",
  "due_date": "2025-12-30T10:00:00.000Z",
  "assigned_to": "John Doe",
  "status": "pending",
  "category": "technical",
  "priority": "high"
}
```

**Update Task (PATCH)**

```json
{
  "status": "completed",
  "priority": "medium"
}
```

---

## 💡 Key Features Implementation

### 1. Real-time Task Refresh

After any update/delete operation, the task list automatically refreshes without requiring a hot restart:

```dart
await taskController.updateTask(taskId: id, updatedData: data);
// Automatically triggers fetchTasks() to refresh UI
```

### 2. Smart Query Parameter Building

Only non-empty filter values are sent to the API:

```dart
final Map<String, dynamic> queryParameters = {};
if (status != null && status.isNotEmpty) queryParameters['status'] = status;
if (category != null && category.isNotEmpty) queryParameters['category'] = category;
```

### 3. Intrinsic Dialog Sizing

Task detail dialogs adapt to content size rather than occupying full screen:

```dart
Dialog(
  child: IntrinsicWidth(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: TaskDetailedView(taskId: taskId),
    ),
  ),
)
```

---

## 🎨 UI/UX Highlights

### Color System

- **Categories**: Blue (Scheduling), Green (Finance), Purple (Technical), Red (Safety), Gray (General)
- **Priorities**: Red (High), Orange (Medium), Green (Low)
- **Status**: Visual chips with distinct background colors

### Responsive Design

- Adaptive layouts for different screen sizes
- Material Design 3 components
- Consistent spacing and typography
- Smooth animations and transitions

---

## 🐛 Troubleshooting

### Hot Reload Triggers API Calls

**Issue**: "Fetching tasks from API" prints on every hot reload

**Solution**: Removed API call from widget `build()` method. Tasks now load only via `TaskController.onInit()`.

### Task Updates Not Reflecting Immediately

**Issue**: UI doesn't update after modifying a task

**Solution**: `TaskController.updateTask()` now calls `fetchTasks()` to refresh the observable list.

### Query Parameters Include Empty Values

**Issue**: API URL shows `?status=&category=finance`

**Solution**: Only non-null/non-empty parameters are added to query string.

---

## 📝 Development Workflow

### State Management Flow

```
User Action → Controller Method → API Service → Update Observable → UI Reacts
```

### Adding a New Task Field

1. Update `TaskModel` in `lib/features/tasks/model/task_model.dart`
2. Modify API request/response in `ApiService`
3. Update UI forms in `update_alert_box.dart` or bottom sheets
4. Add validation logic in controllers

---

## 🔐 Security Considerations

- Input validation on all forms
- Error handling for network failures
- Safe null handling throughout the app
- Secure API endpoint configuration

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👥 Authors

**Your Name** - Jay Raut

---

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- GetX for simplified state management
- Material Design team for design guidelines
- Smart Tasks API for backend services

---

## 📞 Support

For support, email your-jayraut184@gmail.com or open an issue in the repository.

---

**Built with ❤️ using Flutter**
