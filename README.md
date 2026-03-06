# ✅ TaskMaster — Mini Capstone Project

> A clean and minimal **Task Manager App** built with **Flutter** & **Firebase**, featuring full authentication, real-time CRUD operations, and organized state management.

---

## 📋 Table of Contents

- [App Flow](#-app-flow)
- [Features](#-features)
- [Folder Structure](#-folder-structure)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)

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
         │                      │
         │  • Firestore Read    │
         │  • Delete (Dismiss)  │
         │  • CheckBox Toggle   │
         │  • ListView          │
         └──────┬───────┬───────┘
                │       │
         ┌──────▼──┐ ┌──▼───────────────┐
         │ Add /   │ │    Profile        │
         │ Edit    │ │                   │
         │ Task    │ │ • User Info       │
         │         │ │ • Logout          │
         │• Title  │ │ • Firebase Auth   │
         │• Desc   │ │                   │
         │• Priority│ └──────────────────┘
         │• Date   │
         └─────────┘
```

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔐 **User Auth** | Secure login & signup using Firebase Authentication |
| 📝 **Task CRUD** | Create, Read, Update & Delete tasks with Cloud Firestore |
| 🗂️ **Task Organisation** | Organize by priority, due date & completion status |
| 🔄 **State Management** | Efficient state handling using Provider |
| 🧭 **Navigation** | Smooth screen transitions with named routes |

---

## 📁 Folder Structure

```
lib/
│
├── main.dart                        # Entry point
│
├── models/
│   └── task_model.dart              # Task data model
│
├── providers/
│   ├── auth_provider.dart           # Auth state management
│   └── task_provider.dart           # Task state management
│
├── services/
│   ├── auth_service.dart            # Firebase Auth logic
│   └── firestore_service.dart       # Firestore CRUD logic
│
├── screens/
│   ├── login_screen.dart            # Login UI
│   ├── signup_screen.dart           # Sign Up UI
│   ├── task_list_screen.dart        # Home — Task List
│   ├── add_task_screen.dart         # Add / Edit Task
│   └── profile_screen.dart          # User Profile + Logout
│
├── widgets/
│   ├── task_card.dart               # Reusable Task Card
│   ├── custom_button.dart           # Reusable Button
│   └── loading_widget.dart          # Loading Indicator
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
git clone https://github.com/yourusername/taskmaster.git

# 2. Navigate to the project
cd taskmaster

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
- [ ] Enable **Email/Password** authentication
- [ ] Create a **Cloud Firestore** database
- [ ] Download and add config files
- [ ] Add Firebase dependencies in `pubspec.yaml`

---

## 📸 Screenshots

> _Coming soon..._

| Login | Task List | Add Task | Profile |
|-------|-----------|----------|---------|
| 📱 | 📱 | 📱 | 📱 |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

```bash
# Fork it
# Create your branch
git checkout -b feature/amazing-feature

# Commit changes
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