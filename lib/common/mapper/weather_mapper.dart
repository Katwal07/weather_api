import 'package:weather_app_api/modules/home/data/models/weather.dart';
import 'package:weather_app_api/modules/home/domain/entities/weather.dart';

class WeatherMapper {
  static WeatherEntity toWeatherEntity(WeatherModel weatherModel) {
    return WeatherEntity(
      location: toLocationEntity(weatherModel.location!),
      current: toCurrentWeatherEntity(weatherModel.current!),
    );
  }

  static LocationEntity toLocationEntity(LocationModel locationModel) {
    return LocationEntity(
      name: locationModel.name,
      region: locationModel.region,
      country: locationModel.country,
      lat: locationModel.lat,
      lon: locationModel.lon,
      tzId: locationModel.tzId,
      localtimeEpoch: locationModel.localtimeEpoch,
      localtime: locationModel.localtime,
    );
  }

  static CurrentWeatherEntity toCurrentWeatherEntity(
      CurrentWeatherModel currentWeatherModel) {
    return CurrentWeatherEntity(
      lastUpdatedEpoch: currentWeatherModel.lastUpdatedEpoch,
      lastUpdated: currentWeatherModel.lastUpdated,
      tempC: currentWeatherModel.tempC,
      tempF: currentWeatherModel.tempF,
      isDay: currentWeatherModel.isDay,
      condition: toConditionEntity(currentWeatherModel.condition!),
      windMph: currentWeatherModel.windMph,
      windKph: currentWeatherModel.windKph,
      windDegree: currentWeatherModel.windDegree,
      windDir: currentWeatherModel.windDir,
      pressureMb: currentWeatherModel.pressureMb,
      pressureIn: currentWeatherModel.pressureIn,
      precipMm: currentWeatherModel.precipMm,
      precipIn: currentWeatherModel.precipIn,
      humidity: currentWeatherModel.humidity,
      cloud: currentWeatherModel.cloud,
      feelslikeC: currentWeatherModel.feelslikeC,
      feelslikeF: currentWeatherModel.feelslikeF,
      windchillC: currentWeatherModel.windchillC,
      windchillF: currentWeatherModel.windchillF,
      heatindexC: currentWeatherModel.heatindexC,
      heatindexF: currentWeatherModel.heatindexF,
      dewpointC: currentWeatherModel.dewpointC,
      dewpointF: currentWeatherModel.dewpointF,
      visKm: currentWeatherModel.visKm,
      visMiles: currentWeatherModel.visMiles,
      uv: currentWeatherModel.uv,
      gustMph: currentWeatherModel.gustMph,
      gustKph: currentWeatherModel.gustKph,
      airQuality: currentWeatherModel.airQuality,
    );
  }

  static ConditionEntity toConditionEntity(ConditionModel conditionModel) {
    return ConditionEntity(
      text: conditionModel.text,
      icon: conditionModel.icon,
      code: conditionModel.code,
    );
  }
}
