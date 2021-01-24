import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_weather_app/services/networking.dart';
import 'location.dart';

var apiKey = FlutterConfig.get('FABRIC_ID');
var weatherUrl=FlutterConfig.get('API_URL');
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async{
    var url='$weatherUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherData =await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather()async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper('$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 40) {
      return 'It\'s 🍦 time';
    } else if (temp > 25) {
      return 'Time for shorts and 👕';
    } else if (temp < 15) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 ';
    }
  }
}
