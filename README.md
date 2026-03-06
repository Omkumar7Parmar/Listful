Mini Capstone Project 

Task Manager App

App flow diagram:- 

Login/SignUp (Firebase Auth)
            |
Task List (Home) (Firestore Read + Delete, ListView, CheckBox, Dismiss)
            |
Add/Edit Task Screen (Firestore Create + Update, Title, Description, Priority, Date)
            |
Profile User Information + Logout (Firebase Auth)


List of features
User Auth
Task CRUD Operations
Task Organisation
State Management 
Navigation


Folder structure plan:-
lib/
├── main.dart
│
├── models/
│   └── task_model.dart
│
├── providers/
│   ├── auth_provider.dart
│   └── task_provider.dart
│
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
│
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── task_list_screen.dart
│   ├── add_task_screen.dart
│   └── profile_screen.dart
│
├── widgets/
│   ├── task_card.dart
│   ├── custom_button.dart
│   └── loading_widget.dart
│
└── utils/ 
    └──constants.dart
 