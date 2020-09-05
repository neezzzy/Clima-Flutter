import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://www.metaweather.com/api/location/search/?lattlong=${location.latitude.truncateToDouble()},${location.longitude.truncateToDouble()}');

    var locationData = await networkHelper.getData();
    var woeid = locationData[0]['woeid'];

    NetworkHelper weatherHelper =
        NetworkHelper('https://www.metaweather.com/api/location/$woeid');

    var weatherData = await weatherHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://www.metaweather.com/api/location/search/?lattlong=${location.latitude.truncateToDouble()},${location.longitude.truncateToDouble()}');

    var locationData = await networkHelper.getData();

    return locationData;
  }

  String getWeatherIcon(String condition) {
    if (condition == 'lc') {
      return '🌩';
    } else if (condition == 'lr') {
      return '🌧';
    } else if (condition == 's') {
      return '☔️';
    } else if (condition == 'h') {
      return '☃️';
    } else if (condition == 'c') {
      return '☀️';
    } else if (condition == 'hc') {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
