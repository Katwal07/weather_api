class WeatherEntity {
    WeatherEntity({
        required this.location,
        required this.current,
    });

    final LocationEntity? location;
    final CurrentWeatherEntity? current;
}

class CurrentWeatherEntity {
    CurrentWeatherEntity({
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
    final ConditionEntity? condition;
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
}

class ConditionEntity {
    ConditionEntity({
        required this.text,
        required this.icon,
        required this.code,
    });

    final String? text;
    final String? icon;
    final int? code;
}

class LocationEntity {
    LocationEntity({
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
}
