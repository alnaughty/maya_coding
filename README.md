# 📱 Flutter Firestore Balance Management

This Flutter project allows users to manage balances using **Firebase Firestore**. It provides functions to **add, decrease, and retrieve balances** while ensuring data consistency through **transactions**.

---

## 🚀 Features
- 🔥 **Firestore Integration** (CRUD operations)
- 💰 **Add & Decrease Balance**
- 📡 **Real-time Balance Updates using Streams**
- ✅ **Unit Testing for Transactions**
- 🛠️ **Proper Error Handling**

---

## 📌 Prerequisites

1. **Install Flutter** (if not already installed)  
   - [Download Flutter](https://flutter.dev/docs/get-started/install)

2. **Set up Firebase**
   - Create a Firebase project in [Firebase Console](https://console.firebase.google.com/)
   - Enable **Cloud Firestore**
   - Download and configure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
   - Add Firestore dependency to `pubspec.yaml`:
     ```yaml
     dependencies:
       cloud_firestore: ^4.13.5
       firebase_core: ^2.15.0
     ```

---

## 🔧 Setup & Run the App

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/flutter-firestore-balance.git
   cd flutter-firestore-balance
