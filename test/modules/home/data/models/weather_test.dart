import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_api/common/mapper/weather_mapper.dart';
import 'package:weather_app_api/modules/home/data/models/weather.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';
import '../dummy/json_reader.dart';

void main() {
  final testWeatherModel = WeatherModel(
    location: LocationModel(
      name: "Pokhara",
      region: "Gandaki",
      country: "Nepal",
      lat: 28.2333,
      lon: 83.9833,
      tzId: "Asia/Kathmandu",
      localtimeEpoch: 1736319218,
      localtime: "2025-01-08 12:38",
    ),
    current: CurrentWeatherModel(
      lastUpdatedEpoch: 1736318700,
      lastUpdated: "2025-01-08 12:30",
      tempC: 17.4,
      tempF: 63.3,
      isDay: 1,
      condition: ConditionModel(
        text: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
        code: 1000,
      ),
      windMph: 6.5,
      windKph: 10.4,
      windDegree: 167,
      windDir: "SSE",
      pressureMb: 1014.0,
      pressureIn: 29.94,
      precipMm: 0.0,
      precipIn: 0.0,
      humidity: 43,
      cloud: 6,
      feelslikeC: 17.4,
      feelslikeF: 63.3,
      windchillC: 17.4,
      windchillF: 63.3,
      heatindexC: 17.4,
      heatindexF: 63.3,
      dewpointC: 4.9,
      dewpointF: 40.7,
      visKm: 10.0,
      visMiles: 6.0,
      uv: 4.4,
      gustMph: 7.5,
      gustKph: 12.0,
      airQuality: {
        "co": 2469.75,
        "no2": 18.5,
        "o3": 73.0,
        "so2": 7.4,
        "pm2_5": 61.42,
        "pm10": 63.27,
        "us-epa-index": 3,
        "gb-defra-index": 8,
      },
    ),
  );

  group("check weather model behviour", () {
    test("should be an instance of weather model", () async {
      /// Assert
      expect(testWeatherModel, isA<WeatherModel>());
    });

    test('should map weather model to weather entity correctly', () {
      final weatherEntity = WeatherMapper.toWeatherEntity(testWeatherModel);

      /// Assert
      expect(weatherEntity, isA<WeatherEntity>());
    });

    test("should return a valid model from json", () async {
      /// Arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'modules/home/data/dummy/dummy_weather_response.json',
        ),
      );

      /// Act
      final result = WeatherModel.fromJson(jsonMap);

      /// Assert
      expect(
        result,
        equals(testWeatherModel),
      );
    });
  });

  test(
    "should return a json map containing proper data",
    () async {
      /// Act
      final result = testWeatherModel.toJson();

      /// Assert
      final expectedJsonMap = {
        "location": {
          "name": "Pokhara",
          "region": "Gandaki",
          "country": "Nepal",
          "lat": 28.2333,
          "lon": 83.9833,
          "tz_id": "Asia/Kathmandu",
          "localtime_epoch": 1736319218,
          "localtime": "2025-01-08 12:38"
        },
        "current": {
          "last_updated_epoch": 1736318700,
          "last_updated": "2025-01-08 12:30",
          "temp_c": 17.4,
          "temp_f": 63.3,
          "is_day": 1,
          "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
            "code": 1000
          },
          "wind_mph": 6.5,
          "wind_kph": 10.4,
          "wind_degree": 167,
          "wind_dir": "SSE",
          "pressure_mb": 1014.0,
          "pressure_in": 29.94,
          "precip_mm": 0.0,
          "precip_in": 0.0,
          "humidity": 43,
          "cloud": 6,
          "feelslike_c": 17.4,
          "feelslike_f": 63.3,
          "windchill_c": 17.4,
          "windchill_f": 63.3,
          "heatindex_c": 17.4,
          "heatindex_f": 63.3,
          "dewpoint_c": 4.9,
          "dewpoint_f": 40.7,
          "vis_km": 10.0,
          "vis_miles": 6.0,
          "uv": 4.4,
          "gust_mph": 7.5,
          "gust_kph": 12.0,
          "air_quality": {
            "co": 2469.75,
            "no2": 18.5,
            "o3": 73.0,
            "so2": 7.4,
            "pm2_5": 61.42,
            "pm10": 63.27,
            "us-epa-index": 3,
            "gb-defra-index": 8
          }
        }
      };

      expect(
        result,
        equals(expectedJsonMap),
      );
    },
  );
}
