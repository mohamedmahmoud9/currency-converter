# Currency Converter App

![Currency Converter App](app_demo.gif)

## Description

Currency Converter App is a simple mobile application that allows users to convert currencies and check exchange rates. With this app, users can easily convert between different currencies and view exchange rates for the past 7 days.

## Features

- Currency conversion: Convert between different currencies.
- Exchange rate history: View the exchange rate between USD and EUR for the past 7 days.

## How to Run

To run the Currency Converter App on your machine, follow these steps:

1. Clone the repository:
git clone https://github.com/mohamedmahmoud9/currency-converter.git

2. Open the project in your preferred IDE or text editor.

3. Ensure you have Flutter and Dart installed on your machine.

4. Run the following command to install the dependencies:
flutter pub get

5. Connect your physical device or start an emulator.

6. Run the app using the following command: flutter run

This will launch the app on your device or emulator.

## Architecture and Design Patterns

The Currency Converter App follows the clean architecture principles and incorporates the following design patterns:

- Repository Pattern: Separates the data access layer from the presentation layer, providing a clean and consistent API for data operations.
- Observer Pattern: Implements a subscription-based model to notify UI components of data changes, ensuring a reactive and efficient user interface.
- Singleton Pattern: Ensures a single instance of essential classes, such as the API client or data repository, throughout the app's lifecycle.

## Database

The app utilizes Shared Preferences as the database for simplicity and to efficiently save currency preferences.

## Image Loading

The app employs the Flutter `Image.network` widget for efficient image loading from network sources.

For more information about Flutter and getting started with Flutter development, please refer to the official [Flutter documentation](https://flutter.dev/docs).
