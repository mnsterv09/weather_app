import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/models/models.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey.shade500,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_response != null)
                    Column(
                      children: [
                        Image.network(_response.iconUrl),
                        Text(
                          '${_response.tempInfo.temperature}°C',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(_response.weatherInfo.description)
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                          controller: _cityTextController,
                          decoration: InputDecoration(labelText: 'City'),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  ElevatedButton(onPressed: _search, child: Text('Search'))
                ],
              ),
            )));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
