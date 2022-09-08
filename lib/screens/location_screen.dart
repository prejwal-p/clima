import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  Icon? weatherIcon;
  String? cityName;
  Widget? weatherImage;
  String? weatherText;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = WeatherModel().getWeatherIcon(0);
        weatherText = 'Unable To Get Weather Data';
        weatherImage = WeatherModel().getWeatherSVG(0);
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      int condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = WeatherModel().getWeatherIcon(condition);
      weatherText = WeatherModel().getWeatherMessage(condition);
      weatherImage = WeatherModel().getWeatherSVG(condition);
    });
  }

  final Widget svgIcon = SvgPicture.asset('assets/Cactus.svg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Night@2x.png'), fit: BoxFit.fill),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.near_me,
                        size: 40,
                      ),
                      onTap: () async {
                        var weatherData =
                            await WeatherModel().getLocationWeather();
                        updateUI(weatherData);
                      },
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.location_city,
                        size: 40,
                      ),
                      onTap: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );

                        if (typedName != null) {
                          var weatherData =
                              await WeatherModel().getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                    ),
                  ],
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 40,
                        ),
                        Text(
                          cityName!,
                          style: TextStyle(fontSize: 40),
                        )
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          weatherIcon!,
                          Text(
                            '${temperature.toString()}° C',
                            style: TextStyle(
                              fontSize: 110.0,
                            ),
                          ),
                          Text(
                            weatherText!,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 300,
                    width: 300,
                    child: weatherImage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
