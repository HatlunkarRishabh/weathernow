import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _cityController = TextEditingController();
  List<String> _cities = [];
   bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Search City'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _searchCities(value);
                } else {
                    setState(() {
                        _cities = [];
                        _errorMessage = null;
                       });
                }
              },
            ),
             if(_errorMessage != null)
             Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                 child: Text(_errorMessage!, style: const TextStyle(color: Colors.red),),
             ),
           if (_isLoading)
           const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 10), child:  CircularProgressIndicator(),)),
             if(_cities.isNotEmpty)
               Expanded(child: ListView.builder(
                   itemCount: _cities.length,
                   itemBuilder: (context, index) {
                     return ListTile(
                       title: Text(_cities[index]),
                       onTap: () => _selectCity(_cities[index], context),
                     );
                   }
               ))
          ],
        ),
      ),
    );
  }
   Future<void> _searchCities(String city) async {
    setState(() {
      _isLoading = true;
       _errorMessage = null;
    });

    try {
       final String apiUrl = '$baseUrl/search.json?key=$apiKey&q=$city';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
         final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _cities = data.map((item) => item['name'] as String).toList();
        });
      } else {
         setState(() {
              _errorMessage = 'Failed to fetch cities';
               _cities = [];
           });
       }
     }
    catch(e){
        setState(() {
            _errorMessage = e.toString();
           _cities = [];
           });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  void _selectCity(String city, BuildContext context) {
         Provider.of<WeatherProvider>(context, listen: false).setSelectedCity(city);
        Navigator.pop(context);
   }
  @override
  void dispose() {
      _cityController.dispose();
      super.dispose();
   }
}