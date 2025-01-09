# Weather App ☔️⚡️

This is a weather application built using Flutter, providing users with weather details for their selected locations. The app fetches weather data from an API and displays it, along with the current temperature, location, and other relevant weather information.

## Features 🍀

- Weather Data Fetching: Displays real-time weather details including temperature, location, and weather conditions.
- Error Handling: Gracefully handles errors such as no location found.
- State Management: Uses BLoC (Business Logic Component) pattern with Cubit for managing the application state.
- Unit Testing: The app is thoroughly tested using the bloc_test library, with mock data for isolated testing.
- Clean Architecture: The app follows Clean Architecture principles to separate concerns and enhance scalability.
- Dependency Injection: DI is used to inject dependencies such as the WeatherRepository, Usecases, and Cubits into the app to manage dependencies effectively and improve testability.
## Tech Stack 📲
- Flutter: UI toolkit for building natively compiled applications for mobile, web, and desktop.
- BLoC Pattern: Business logic component for separating UI from business logic, using Cubit for state management.
- Dio: A powerful HTTP client for Dart, used for making network requests to external APIs.
- Dartz: Functional programming library for handling Either types, useful for error handling and managing async data flow.
- Mockito: Mocking library for creating mock objects used in testing.
- Hive: Lightweight and fast key-value database used for local storage in the app.
- Cached Network Image: A package for downloading, caching, and displaying images from the network, ensuring faster loading and reduced data usage.
- Build Runner: A tool for generating code in Flutter projects, often used in conjunction with packages like json_serializable to generate model classes.
- Clean Architecture: A software design pattern that separates the system into layers with clear responsibilities to make the codebase more maintainable.
- Dependency Injection: The process of providing dependencies (such as repositories, use cases) from the outside, rather than creating them inside the class, making the app easier to test and manage.
## Architecture Overview 🕍
- The app follows Clean Architecture, which is divided into multiple layers:
1. Presentation Layer
A. This layer is responsible for the UI and user interaction. It consists of:
- Cubits (Business Logic): Handles states and events related to the UI. In this app, WeatherCubit is used to handle the state of weather data.
- Widgets: UI components that interact with Cubits and display data to the user.
2. Domain Layer
A. The domain layer contains business logic and entities. It consists of:
- Usecases: These represent specific actions that can be performed, like fetching weather data. They take in parameters, interact with repositories, and return results.
- Entities: These are simple data structures that represent core business objects. In this app, WeatherEntity is the main entity representing weather data.
- Repository Interface: The domain layer defines the interface for the repository (e.g., WeatherRepository). This interface defines the methods that are needed to interact with the data layer.
3. Data Layer
A. The data layer is responsible for fetching and storing data. It consists of:
- Repositories: These handle the data retrieval logic and provide data to the domain layer. The repository implementation (e.g., WeatherRepositoryImpl) is defined in the data layer and implements the repository interface from the domain layer.
- Data Sources: These interact with external systems (e.g., weather API) to fetch data. In the data layer, you would have classes like WeatherRemoteDataSource which interact with the API.
- Models: In the data layer, we would also define models that represent the response data coming from the external source (e.g., API).
4. Core Layer
- This layer contains foundational utilities and abstractions that can be reused across multiple modules.
- Includes things like base error handling, use cases, failure classes, and base models.
5. Commom Layer
- This layer contains common logic that is shared across different parts of the app, but isn't directly tied to business logic. It can be considered a utility or helper layer.
- Includes shared widgets, helper methods, constants, etc.




## API Reference 📚

#### Get all weather details

```http
  GET http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=$bool
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |
|  `location` | `string`   | location name




## Acknowledgements 🫵🏽

 - [Weather Api](https://www.weatherapi.com)
 


## Setup and Installation 💻

1. Clone the repository:

```bash
git clone https://github.com/Katwal07/weather_api.git
cd weather_app
```
2. Install dependencies:
- Make sure you have Flutter installed. Then run:
```bash
flutter pub get
```
3. Set up the weather API:
- To fetch weather data, you need to obtain an API key from WeatherAPI. Replace the API key in your code where necessary.
4. Run the app:
```bash
flutter run
```
    
## Running Tests 🏃🏼‍♀️

The project includes unit tests and bloc tests to ensure functionality.
1. To run the unit tests:

```bash
flutter test
```
2. Run bloc tests: 
- Bloc testing is essential for verifying that the correct states are emitted. To run bloc tests:
```bash
flutter test test/../bloc/..._test.dart
```


## Contact 📞
- Feel free to reach out if you have any questions or suggestions!
- Email: rohankatwal05@gmail.com

# Additionally 🎉

## Folder Structure Code Figure

lib/
├── common/
│   ├── constant/
│   │   └── textconstant.dart
│   ├── mapper/
│   │   └── mapper.dart
│   └── widgets/
│       └── widgets.dart
│
├── core/
│   ├── config/
│   │   ├── assets/
│   │   │   └── assets.dart
│   │   ├── routes/
│   │   │   ├── routes.dart
│   │   │   └── routes_name.dart
│   │   ├── theme/
│   │   │   ├── theme.dart
│   │   │   └── colors.dart
│   ├── error/
│   │   ├── failure.dart
│   │   ├── exception.dart
│   │   └── mapping.dart
│   ├── network/
│   │   └── dio.dart
│   ├── usecase/
│   │   └── usecase.dart
│   └── utils/
│       └── res.dart
│
├── modules/
│   ├── helper/
│   │   ├── logic/
│   │   │   └── helper_cubit.dart
│   │   ├── pages/
│   │   │   └── helper_page.dart
│   │   └── widgets/
│   │       └── helper_widget.dart
│   └── home/
│       ├── data/
│       │   ├── models/
│       │   │   └── weather_model.dart
│       │   └── repositories/
│       │       └── weather_repository.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── weather_entity.dart
│       │   ├── usecases/
│       │   │   └── get_weather_usecase.dart
│       ├── presentation/
│       │   ├── cubit/
│       │   │   └── weather_cubit.dart
│       │   ├── pages/
│       │   │   └── weather_page.dart
│       │   └── widgets/
│       │       └── weather_widget.dart
│       └── di_container.dart


