# ✅ Listful — Mini Capstone Project

> A clean and minimal **Task Manager App** built with **Flutter** & **Firebase**, featuring full authentication, real-time CRUD operations, and organized state management.

---

## 📋 Table of Contents

- [App Flow](#-app-flow)
- [Features](#-features)
- [Folder Structure](#-folder-structure)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔄 App Flow

```
         ┌──────────────────────┐
         │   Login / Sign Up    │
         │   (Firebase Auth)    │
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │   Task List (Home)   │
         │  • Sort & Filter     │
         │  • Firestore Read    │
         │  • Delete Task       │
         │  • Toggle Complete   │
         └──────┬───────┬───────┘
                │       │
         ┌──────▼──┐ ┌──▼───────────────┐
         │ Add /   │ │    Profile        │
         │ Edit    │ │                   │
         │ Task    │ │ • User Avatar     │
         │         │ │ • User Info       │
         │• Title  │ │ • Logout          │
         │• Desc   │ └──────────────────┘
         │• Priority│
         │• Date   │
         └─────────┘
```

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **User Auth** | Secure login & signup with session persistence using Firebase Authentication. |
| 📝 **Task CRUD** | Real-time Create, Read, Update & Delete tasks with Cloud Firestore. |
| 🗂️ **Task Organisation** | Organize tasks by priority (Low, Medium, High) and an optional due date. |
| 🔍 **Sort & Filter** | Sort tasks by due date or priority, and filter them by completion status. |
| 👤 **User Profile** | A dedicated screen displaying the user's name, email, and a circular avatar. |
| 🔄 **State Management** | Efficient and reactive state handling using the Provider package. |
| 📱 **Responsive UI** | Screens are designed to handle dynamic content and prevent layout overflows. |

---

## 📁 Folder Structure

```
lib/
│
├── main.dart                        # Entry point & routes
│
├── models/
│   └── task_model.dart              # Data model for tasks
│
├── providers/
│   ├── auth_provider.dart           # Manages authentication state
│   └── task_provider.dart           # Manages task data, sorting, and filtering
│
├── services/
│   └── firestore_service.dart       # Handles all Firestore database operations
│
├── screens/
│   ├── login_screen.dart            # User login UI
│   ├── signup_screen.dart           # User registration UI
│   ├── task_list_screen.dart        # Main dashboard for viewing tasks
│   ├── add_task_screen.dart         # Form for creating a new task
│   ├── edit_task_screen.dart        # Form for editing an existing task
│   └── profile_screen.dart          # User profile display
│
├── widgets/
│   └── task_card.dart               # Reusable card widget to display a single task
│
└── utils/
    └── constants.dart               # App-wide constants
```

---

## 🛠️ Tech Stack

```
┌────────────────┬──────────────────────┐
│  Category      │  Technology          │
├────────────────┼──────────────────────┤
│  Framework     │  Flutter (Dart)      │
│  Auth          │  Firebase Auth       │
│  Database      │  Cloud Firestore     │
│  State Mgmt    │  Provider            │
│  Formatting    │  intl                │
│  Platform      │  Android / iOS       │
└────────────────┴──────────────────────┘
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed
- Firebase project configured
- Android Studio / VS Code

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Omkumar7Parmar/Listful.git

# 2. Navigate to the project
cd Listful

# 3. Install dependencies
flutter pub get

# 4. Add Firebase config files
#    → android/app/google-services.json
#    → ios/Runner/GoogleService-Info.plist

# 5. Run the app
flutter run
```

### Firebase Setup Checklist

- [ ] Create a Firebase project
- [ ] Enable **Email/Password** authentication in the Firebase console
- [ ] Create a **Cloud Firestore** database
- [ ] Download and add the necessary config files to the project
- [ ] Ensure all dependencies in `pubspec.yaml` are up to date

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

```bash
# Fork the repository
# Create your feature branch
git checkout -b feature/amazing-feature

# Commit your changes
git commit -m "Add amazing feature"

# Push to the branch
git push origin feature/amazing-feature

# Open a Pull Request
```

---

## 📄 License

This project is licensed under the **MIT License**.

---

<div align="center">

**Built with ❤️ using Flutter & Firebase**

⭐ _Star this repo if you found it helpful!_ ⭐

</div>


Final feature list
Task creation -> Title - Description - Due Date - Priority
Task Display List -> Title - Due Date - Priority - Checkbox
-> Edit and Deletion option
Sort By option -> by Due Date - By priority - By None
Filter by option -> by Completed Task - by Incompleted Task - by All
Profile Screen -> that displays Name - Email - User ID (Firebase Auth)

Screenshots of the app
LoginScreen.png
SignUpScreen.png
TaskListScreen.png
ProfileScreen.png
AddTaskScreen.png
