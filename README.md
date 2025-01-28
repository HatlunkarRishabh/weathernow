# weathernow

A beautiful and functional Flutter weather application that displays current weather conditions, a 5-day forecast, and allows searching for weather data in different locations. This app leverages the WeatherAPI, local caching, and a clean UI to provide an intuitive user experience.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Key Implementation Details](#key-implementation-details)
  - [Weather API Integration](#weather-api-integration)
  - [State Management](#state-management)
  - [Data Persistence](#data-persistence)
  - [UI Components](#ui-components)
- [Error Handling](#error-handling)
- [Testing](#testing)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

## Features

-   **Current Weather:** Displays current temperature, humidity, wind speed, and other relevant details for a location.
-   **5-Day Forecast:** Shows a horizontal list of the 5-day forecast data.
-   **Location Search:** Enables users to search for weather information by city name.
-   **Current Location:** Allows users to quickly switch back to weather information of the current location.
-   **Offline Support:** Caches weather data locally, allowing access even without a network connection.
-   **Clean UI:** Employs a user-friendly interface with clear layouts and informative icons.
-   **Responsive Design:** Works effectively on different screen sizes.
-   **Skeleton Loading:** Provides a visual loading effect using `skeletonizer` to simulate data loading.

## Architecture

This app follows a layered architecture:

-   **UI Layer:** Contains all the widgets, screens, and layouts responsible for rendering the user interface.
-   **State Management Layer:** Utilizes the `Provider` package to manage the application state, making data accessible across different parts of the app.
-   **Service Layer:** Handles API calls to the WeatherAPI using the `http` package and implements data parsing. It also contains the network service to verify the connectivity status.
-   **Data Layer:** The data layer is implemented using `Hive` for local storage and caching.
-   **Model Layer:** Defines the data models for weather and forecast data.

## Project Structure
weathernow/
├── lib/
│ ├── main.dart # Entry point of the application
│ ├── models/
│ │ ├── weather_model.dart # Data model for current weather
│ │ └── daily_forecast_model.dart # Data model for daily forecast
│ ├── services/
│ │ ├── weather_service.dart # Handles API requests and data parsing
│ │ └── network_service.dart # Network connection verifier
│ ├── providers/
│ │ └── weather_provider.dart # Manages app state and data fetching
│ ├── widgets/
│ │ ├── weather_card.dart # Displays current weather info
│ │ ├── daily_forecast_card.dart # Displays daily forecast card
│ │ ├── error_widget.dart # Display error messages
│ │ ├── weather_icon.dart # Displays the weather icons
│ │ └── skeleton_widget.dart # Displays the skeletons when loading
│ ├── utils/
│ │ └── constants.dart # API Key and other constants
│ └── screens/
│ ├── home_screen.dart # Main weather screen
│ ├── search_screen.dart # Screen for searching weather data
│ └── splash_screen.dart # Splash screen for initial loading
├── test/ # Unit tests
│ └── ...
├── pubspec.yaml # Flutter dependencies
├── README.md # This file
└── ...


## Getting Started

Follow these steps to set up and run the application on your local machine.

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter plugins
-   A WeatherAPI account and API key. You can get it at [WeatherAPI](https://www.weatherapi.com/api-explorer.aspx)

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
    cd your_repo_name
    ```

2.  Install dependencies:
    ```bash
    flutter pub get
    ```

### Execution
1.  Replace `"YOUR_API_KEY"` in `lib/utils/constants.dart` with your actual WeatherAPI key:
    ```dart
    const String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
    ```

2. Run the code generator:
   ```dart
    flutter run
    ```

## Usage

-   Upon launching, the app will attempt to load the weather for your current location, or a saved location. If none is available, it will take you to the search screen.
-   Use the search button in the floating action button to find a city and display its weather.
-   Click the location icon on the app bar to load the weather data of the user's current location.
-   Use the refresh button on the app bar to refresh the current data.

## Key Implementation Details

### Weather API Integration

-   Uses the `http` package for making API requests to the WeatherAPI.
-   The `WeatherService` class handles building and executing API calls.
-   The application uses the `current.json` and `forecast.json` endpoints.
-   The API response is parsed into `WeatherModel` and `DailyForecastModel` objects.

### State Management

-   The `Provider` package is used for state management.
-   The `WeatherProvider` class extends `ChangeNotifier` to manage app state and trigger UI updates.
-   This enables the widgets to respond to changes in weather data dynamically.

### Data Persistence

-   `Hive` is used as a local database solution.
-   It caches weather data for offline access.
-   The `weather_box`, `daily_forecast_box`, and `settings` boxes are used to store data.
-   Generated adapters are used to correctly serialize and deserialize the data into a binary format.

### UI Components

-   `WeatherCard`: Displays current weather details.
-   `DailyForecastCard`: Displays forecast information for each day.
-   `WeatherIcon`: Dynamically displays weather icons using `Image.network`.
-   `ErrorDisplay`: Displays error messages to the user when issues occur.
-   `WeatherSkeleton`: Displays the loading state of the application.

### Error Handling

-   Robust error handling is implemented to catch API failures, network issues, and parsing errors.
-   Error messages are displayed in the UI to provide feedback to the user.
-   Try/catch blocks are used when loading data, parsing, or rendering.

### Testing

-   Basic error handling and logging have been added to improve the app's quality and allow better error detection.
-   Unit tests for the API call have been added to verify the correct implementation of this functionality.

## Future Enhancements

-   Implement more detailed error handling with specific error messages.
-   Add more weather parameters (e.g., sunrise, sunset times).
-   Implement a settings page to allow users to change the app's theme and other preferences.
-   Explore background location update for better automatic updates.
-   Explore different state management solutions.
-   Explore better caching strategies.
-   Add unit tests to improve the quality of code.

## Contributing

Contributions are welcome! Feel free to fork the repository and submit pull requests with your improvements.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.

## Credits

-   [WeatherAPI](https://www.weatherapi.com/) for providing the weather data.
-   [Flutter](https://flutter.dev/) for creating the beautiful framework.
-   All the amazing libraries used in this project.

