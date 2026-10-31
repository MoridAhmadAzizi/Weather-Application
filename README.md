# Weather Application

A simple weather app built with Flutter. It shows live weather for your current location, a forecast for the coming hours and days, and lets you search the weather in any city.

## Features

- **Current weather** for your location: city name, date, condition icon, description, temperature, wind speed and humidity.
- **Hourly forecast** shown as a horizontal list (3-hour steps).
- **Daily forecast** with the day, date, high temperature and a weather icon.
- **City search** by name, with a quick-access grid of famous cities (London, Paris, New York, Sydney).
- **Loading skeletons** while data is being fetched.
- **Error views with a retry button** when something goes wrong.

## App screens

The app has a bottom navigation bar with three tabs:

| Tab | Screen | What it shows |
| --- | --- | --- |
| Home | `WeatherScreen` | Current weather for your location and today's hourly forecast |
| Search | `SearchScreen` | Search box, famous cities, and the result for a searched city |
| Forecast | `ForecastScreen` | Today's hourly forecast and the daily forecast |

Tapping a city (from the famous cities grid or a search result) opens `WeatherDetailScreen` with that city's weather.

## Tech stack

- [Flutter](https://flutter.dev) and Dart (SDK `^3.10.1`)
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) for state management
- [dio](https://pub.dev/packages/dio) for HTTP requests
- [geolocator](https://pub.dev/packages/geolocator) to get the device location
- [skeletonizer](https://pub.dev/packages/skeletonizer) for loading skeletons
- [jiffy](https://pub.dev/packages/jiffy) for date formatting

## Data sources

| Data | Source | API key needed |
| --- | --- | --- |
| Current weather (by location or city name) | [OpenWeatherMap](https://openweathermap.org/api) `/weather` | Yes |
| Hourly forecast | [OpenWeatherMap](https://openweathermap.org/api) `/forecast` | Yes |
| Daily forecast | [Open-Meteo](https://open-meteo.com) | No |

## Getting started

### Requirements

- Flutter installed and set up ([install guide](https://docs.flutter.dev/get-started/install)). Your Dart SDK must satisfy `^3.10.1`.
- A free OpenWeatherMap API key. You can create one at [openweathermap.org/api](https://openweathermap.org/api).
- An Android or iOS device or emulator (the project also contains a `web` folder).

### 1. Clone the project

```bash
git clone https://github.com/MoridAhmadAzizi/Weather-Application.git
cd Weather-Application
```

### 2. Install the packages

```bash
flutter pub get
```

### 3. Add your API key

The real keys file is ignored by Git, so you need to create it yourself from the example file.

1. Copy `lib/constants/constants.example.dart` to `lib/constants/constants.dart`.
2. Open `lib/constants/constants.dart` and replace `YOUR DEFAULT API KEY` with your OpenWeatherMap key:

```dart
class Constants {
  static const String apiKey = 'your-openweathermap-key-here';
  static const String apiKey2 = 'YOUR GENERATED API KEY';
}
```

`apiKey` is the one the app uses. `apiKey2` is not used by the code at the moment, so you can leave it as it is.

### 4. Run the app

```bash
flutter run
```

## Permissions

The app needs two things to work:

- **Internet access** to call the weather APIs.
- **Location permission** to show the weather for where you are. The app asks for it the first time you open the Home tab. If you deny it, the Home tab shows an error with a retry button, but city search still works.

Both permissions are already set up in the Android manifest and the iOS `Info.plist`.

## Project structure

```
lib/
├── main.dart            # App entry point (Riverpod ProviderScope + MaterialApp)
├── constants/           # Colors, text styles, API keys (constants.dart is not committed)
├── extensions/          # Small helpers for DateTime, String, int and double
├── models/              # Data classes: Weather, HourlyWeather, WeeklyWeather, FamousCity
├── providers/           # Riverpod providers that load weather data
├── screens/             # Full screens (Home, Search, Forecast, Weather detail)
├── services/            # api_helper.dart (API calls) and geolocator.dart (device location)
├── skeletons/           # Loading placeholders for each screen
├── utils/               # Weather icon helpers and logging
├── views/               # Larger parts of a screen (hourly list, weekly list, error view, ...)
└── widgets/             # Small reusable widgets (nav bar item, text field, city tile, ...)
assets/
└── icons/               # Weather condition icons
```

## How it works

1. `ApiHelper` (in `lib/services/api_helper.dart`) asks `geolocator.dart` for the device location.
2. It builds the API URL with that location (or with the city name for searches) and fetches the data with `dio`.
3. The JSON response is converted into a model class from `lib/models/`.
4. A Riverpod provider exposes the result, and the screen shows a loading skeleton, the data, or an error view with a retry button.
