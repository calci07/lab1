# bitago_advmobprog

State management keeps changing data and the Flutter UI in sync.

Ephemeral state belongs to a particular widget. The counter in `lib/main.dart` stores its value in a State object and calls setState to rebuild the UI after incrementing it. Ordinary rebuilds do not reset the counter. Discarding and recreating its State, or restarting the app, resets it to zero.

App state is shared across the application. In `lib/main.dart`, ChangeNotifierProvider owns a ThemeModel above MaterialApp, reusing the model from `lib/app_state.dart`. The switch calls toggleTheme, notifyListeners informs consumers, and MaterialApp rebuilds with the selected light or dark theme. This example keeps the preference in memory only; it does not save it across app restarts.

The main app combines the local counter and shared theme. Switching themes preserves the counter value, and incrementing the counter preserves the selected theme.

Run the combined activity:

```sh
flutter run
```

Run the earlier standalone app state example:

```sh
flutter run -t lib/app_state.dart
```

Press + repeatedly to observe the counter, then toggle the switch in the app bar. The whole app changes theme while the counter keeps its value.

Validate:

```sh
flutter analyze
flutter test
```

Reference: [Flutter state management](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app).
