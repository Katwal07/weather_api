import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.location,
    required this.current,
  });

  final LocationModel? location;
  final CurrentWeatherModel? current;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json["location"] == null
          ? null
          : LocationModel.fromJson(json["location"]),
      current: json["current"] == null
          ? null
          : CurrentWeatherModel.fromJson(json["current"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "location": location?.toJson(),
      "current": current?.toJson(),
    };
  }

  @override
  List<Object?> get props => [location, current];
}

class CurrentWeatherModel extends Equatable {
  const CurrentWeatherModel({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    required this.airQuality,
  });

  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final ConditionModel? condition;
  final double? windMph;
  final double? windKph;
  final int? windDegree;
  final String? windDir;
  final double? pressureMb;
  final double? pressureIn;
  final double? precipMm;
  final double? precipIn;
  final int? humidity;
  final int? cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final double? windchillC;
  final double? windchillF;
  final double? heatindexC;
  final double? heatindexF;
  final double? dewpointC;
  final double? dewpointF;
  final double? visKm;
  final double? visMiles;
  final double? uv;
  final double? gustMph;
  final double? gustKph;
  final Map<String, double> airQuality;

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      lastUpdatedEpoch: json["last_updated_epoch"],
      lastUpdated: json["last_updated"],
      tempC: json["temp_c"],
      tempF: json["temp_f"],
      isDay: json["is_day"],
      condition: json["condition"] == null
          ? null
          : ConditionModel.fromJson(json["condition"]),
      windMph: json["wind_mph"],
      windKph: json["wind_kph"],
      windDegree: json["wind_degree"],
      windDir: json["wind_dir"],
      pressureMb: json["pressure_mb"],
      pressureIn: json["pressure_in"],
      precipMm: json["precip_mm"],
      precipIn: json["precip_in"],
      humidity: json["humidity"],
      cloud: json["cloud"],
      feelslikeC: json["feelslike_c"],
      feelslikeF: json["feelslike_f"],
      windchillC: json["windchill_c"],
      windchillF: json["windchill_f"],
      heatindexC: json["heatindex_c"],
      heatindexF: json["heatindex_f"],
      dewpointC: json["dewpoint_c"],
      dewpointF: json["dewpoint_f"],
      visKm: json["vis_km"],
      visMiles: json["vis_miles"],
      uv: json["uv"],
      gustMph: json["gust_mph"],
      gustKph: json["gust_kph"],
      airQuality: json["air_quality"] == null ? {} : Map.from(json["air_quality"]).map(
        (k, v) {
          return MapEntry<String, double>(
            k,
            v is int ? v.toDouble() : v,
          );
        },
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "last_updated_epoch": lastUpdatedEpoch,
      "last_updated": lastUpdated,
      "temp_c": tempC,
      "temp_f": tempF,
      "is_day": isDay,
      "condition": condition?.toJson(),
      "wind_mph": windMph,
      "wind_kph": windKph,
      "wind_degree": windDegree,
      "wind_dir": windDir,
      "pressure_mb": pressureMb,
      "pressure_in": pressureIn,
      "precip_mm": precipMm,
      "precip_in": precipIn,
      "humidity": humidity,
      "cloud": cloud,
      "feelslike_c": feelslikeC,
      "feelslike_f": feelslikeF,
      "windchill_c": windchillC,
      "windchill_f": windchillF,
      "heatindex_c": heatindexC,
      "heatindex_f": heatindexF,
      "dewpoint_c": dewpointC,
      "dewpoint_f": dewpointF,
      "vis_km": visKm,
      "vis_miles": visMiles,
      "uv": uv,
      "gust_mph": gustMph,
      "gust_kph": gustKph,
      "air_quality": airQuality.map((k, v) => MapEntry(k, v)),
    };
  }

  @override
  List<Object?> get props => [
        lastUpdatedEpoch,
        lastUpdated,
        tempC,
        tempF,
        isDay,
        condition,
        windMph,
        windKph,
        windDegree,
        windDir,
        pressureMb,
        pressureIn,
        precipMm,
        precipIn,
        humidity,
        cloud,
        feelslikeC,
        feelslikeF,
        windchillC,
        windchillF,
        heatindexC,
        heatindexF,
        dewpointC,
        dewpointF,
        visKm,
        visMiles,
        uv,
        gustMph,
        gustKph,
        airQuality,
      ];
}

class ConditionModel extends Equatable {
  const ConditionModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  final String? text;
  final String? icon;
  final int? code;

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      text: json["text"],
      icon: json["icon"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "icon": icon,
      "code": code,
    };
  }

  @override
  List<Object?> get props => [text, icon, code];
}

class LocationModel extends Equatable {
  const LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json["name"],
      region: json["region"],
      country: json["country"],
      lat: json["lat"],
      lon: json["lon"],
      tzId: json["tz_id"],
      localtimeEpoch: json["localtime_epoch"],
      localtime: json["localtime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "region": region,
      "country": country,
      "lat": lat,
      "lon": lon,
      "tz_id": tzId,
      "localtime_epoch": localtimeEpoch,
      "localtime": localtime,
    };
  }

  @override
  List<Object?> get props =>
      [name, region, country, lat, lon, tzId, localtimeEpoch, localtime];
}
