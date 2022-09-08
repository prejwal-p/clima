import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icon(
        FontAwesomeIcons.bolt,
        size: 100,
      );
    } else if (condition < 400) {
      return Icon(FontAwesomeIcons.cloudRain, size: 75);
    } else if (condition < 600) {
      return Icon(FontAwesomeIcons.cloudShowersHeavy, size: 75);
    } else if (condition < 700) {
      return Icon(FontAwesomeIcons.snowflake, size: 75);
    } else if (condition < 800) {
      return Icon(FontAwesomeIcons.smog, size: 75);
    } else if (condition == 800) {
      return Icon(FontAwesomeIcons.solidSun, size: 75);
    } else if (condition <= 804) {
      return Icon(FontAwesomeIcons.cloud, size: 75);
    } else {
      return Icon(FontAwesomeIcons.exclamationTriangle, size: 100);
    }
  }

  String getWeatherMessage(int condition) {
    if (condition < 300) {
      return 'Thunderstorm!!';
    } else if (condition < 400) {
      return 'Drizzle';
    } else if (condition < 600) {
      return 'Heavy Rains Expected';
    } else if (condition < 700) {
      return 'Snow Expected';
    } else if (condition < 800) {
      return 'Misty';
    } else if (condition == 800) {
      return 'Clear Sky';
    } else if (condition <= 804) {
      return 'Overcast';
    } else {
      return 'Eror! Could Not Retrieve The Weather Information';
    }
  }

  Widget getWeatherSVG(int condition) {
    if (condition < 300) {
      return SvgPicture.asset('assets/Rain.svg');
    } else if (condition < 400) {
      return SvgPicture.asset('assets/Rain.svg');
    } else if (condition < 600) {
      return SvgPicture.asset('assets/Rain.svg');
    } else if (condition < 700) {
      return SvgPicture.asset('assets/Winter.svg');
    } else if (condition < 800) {
      return SvgPicture.asset('assets/Windmill.svg');
    } else if (condition == 800) {
      return SvgPicture.asset('assets/Tree.svg');
    } else if (condition <= 804) {
      return SvgPicture.asset('assets/Relax.svg');
    } else {
      return SvgPicture.asset('assets/Directions.svg');
    }
  }
}
