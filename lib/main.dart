import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      title: 'Kindacode.com',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The list that contains information about photos
  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const apiUrl = 'https://jsonplaceholder.typicode.com/photos';

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _loadedPhotos = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vijay Flutter Developer'),
        ),
        body: SafeArea(
            child: _loadedPhotos.isEmpty
                ? Center(
                    child: ElevatedButton(
                      onPressed: _fetchData,
                      child: const Text('Call API'),
                    ),
                  )
                // The ListView that displays photos
                : ListView.builder(
                    itemCount: _loadedPhotos.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ListTile(
                        leading: Image.network(
                          _loadedPhotos[index]["thumbnailUrl"],
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        title: Text(_loadedPhotos[index]['title']),
                        subtitle:
                            Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
                      );
                    },
                  )));
  }
}
