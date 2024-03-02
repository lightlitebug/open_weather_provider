import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather/weather_provider.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              // to avoid async gap warning
              // aka use_build_context_synchronously lint rule
              final weatherContext = context.read<WeatherProvider>();

              _city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }),
              );
              print('city: $_city');
              if (_city != null) {
                weatherContext.fetchWeather(_city!);
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
