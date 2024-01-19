enum Status {
  success,
  error,
}

class ResponseWeatherModel {
  WeatherModel? weatherInfo;
  Status responseStatus;

  ResponseWeatherModel({
    required this.weatherInfo,
    required this.responseStatus,
  });
}

class WeatherModel {
  CordModel cord;
  List<CurrentWeatherModel> weather;
  String base;
  MainModel main;
  double visibility;
  WindModel wind;
  RainModel? rain;
  SnowModel? snow;
  CloudsModel clouds;
  double dt;
  SysModel sys;
  double timezone;
  int id;
  String name;
  int cod;

  WeatherModel({
    required this.cord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.snow,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'coord': Map<String, dynamic> cord,
        'weather': List<dynamic> weather,
        'base': String base,
        'main': Map<String, dynamic> main,
        'visibility': num visibility,
        'wind': Map<String, dynamic> wind,
        'rain': Map<String, dynamic>? rain,
        'snow': Map<String, dynamic>? snow,
        'clouds': Map<String, dynamic> clouds,
        'dt': num dt,
        'sys': Map<String, dynamic> sys,
        'timezone': num timezone,
        'id': int id,
        'name': String name,
        'cod': int cod,
      } => WeatherModel(
          cord: CordModel.fromJson(cord),
          weather:
            List<CurrentWeatherModel>.from(
              weather.map((json) => CurrentWeatherModel.fromJson(json))
            ),
          base: base,
          main: MainModel.fromJson(main),
          visibility: visibility.toDouble(),
          wind: WindModel.fromJson(wind),
          rain: rain != null? RainModel.fromJson(rain): null,
          snow: snow != null? SnowModel.fromJson(snow): null,
          clouds: CloudsModel.fromJson(clouds),
          dt: dt.toDouble(),
          sys: SysModel.fromJson(sys),
          timezone: timezone.toDouble(),
          id: id,
          name: name,
          cod: cod
        ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class CordModel {
  double lon;
  double lat;

  CordModel({
    required this.lon,
    required this.lat,
  });

  factory CordModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'lon': num lon,
        'lat': num lat
      } => CordModel(
        lon: lon.toDouble(),
        lat: lat.toDouble(),
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class CurrentWeatherModel {
  int id;
  String main;
  String description;
  String icon;

  CurrentWeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'id': int id,
        'main': String main,
        'description': String description,
        'icon': String icon
      } => CurrentWeatherModel(
        id: id,
        main: main,
        description: description,
        icon: icon,
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class MainModel {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  double pressure;
  double humidity;
  double seaLevel;
  double grndLevel;

  MainModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'temp': num temp,
        'feels_like': num feelsLike,
        'temp_min': num tempMin,
        'temp_max': num tempMax,
        'pressure': num pressure,
        'humidity': num humidity,
        'sea_level': num seaLevel,
        'grnd_level': num grndLevel,
      } => MainModel(
        temp: temp.toDouble(),
        feelsLike: feelsLike.toDouble(),
        tempMin: tempMin.toDouble(),
        tempMax: tempMax.toDouble(),
        pressure: pressure.toDouble(),
        humidity: humidity.toDouble(),
        seaLevel: seaLevel.toDouble(),
        grndLevel: grndLevel.toDouble()
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class WindModel {
  double speed;
  double deg;
  double gust;

  WindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'speed': num speed,
        'deg': num deg,
        'gust': num gust
      } => WindModel(
        speed: speed.toDouble(),
        deg: deg.toDouble(),
        gust: gust.toDouble(),
      ),
      _ => throw const FormatException('Failed to load'),
    };
  }
}

class RainModel {
  double? oneH;
  double? threeH;

  RainModel({
    required this.oneH,
    required this.threeH,
  });

  factory RainModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        '1h': num oneH,
        '3h': num threeH
      } => RainModel(
        oneH: oneH.toDouble(),
        threeH: threeH.toDouble()
      ),
      _ => throw const FormatException('Failed to load')
    };
  }
}

class SnowModel {
  double? oneH;
  double? threeH;

  SnowModel({
    required this.oneH,
    required this.threeH,
  });

  factory SnowModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        '1h': num oneH,
        '3h': num threeH
      } => SnowModel(
        oneH: oneH.toDouble(),
        threeH: threeH.toDouble()
      ),
      _ => throw const FormatException('Failed to load')
    };
  }
}

class CloudsModel {
  double all;

  CloudsModel({
    required this.all
  });

  factory CloudsModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'all': num all
      } => CloudsModel(
        all: all.toDouble()
      ),
      _ => throw const FormatException('Failed to load')
    };
  }
}

class SysModel {
  int type;
  int id;
  String country;
  double sunrise;
  double sunset;

  SysModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset
  });

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'type': int type,
        'id': int id,
        'country': String country,
        'sunrise': num sunrise,
        'sunset': num sunset,
      } => SysModel(
        type: type,
        id: id,
        country: country,
        sunrise: sunrise.toDouble(),
        sunset: sunset.toDouble()
      ),
      _ => throw const FormatException('Failed to load')
    };
  }
}