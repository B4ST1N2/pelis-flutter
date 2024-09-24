import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/tv_series.dart'; // Puedes renombrar esta clase a "tv_series.dart" si prefieres

class Series extends StatelessWidget {
  const Series({super.key});

  // Petición HTTP para obtener las series
  Future<List<Serie>> _getSeries() async {
    final String apiKey = 'de41cb42556ebb1f1033892b3cf7a9d2';
    List<Serie> series = [];

    // Pedimos varias páginas para mostrar al menos 50 series
    for (int page = 1; page <= 3; page++) {
      final String url =
          'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&page=$page';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        for (var seriesData in jsonData['results']) {
          Serie serie = Serie(
            title: seriesData['name'],  // Cambiamos 'title' por 'name' porque así se llama el campo en series
            posterPath: 'https://image.tmdb.org/t/p/w500${seriesData['poster_path']}',
            voteAverage: seriesData['vote_average'].toDouble(),
          );
          series.add(serie);
        }
      } else {
        throw Exception('Error al cargar las series');
      }
    }
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Serie>>(
        future: _getSeries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las series'));
          } else if (snapshot.hasData) {
            List<Serie> series = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos columnas
                childAspectRatio: 0.7, // Ajustamos la relación de aspecto para las imágenes
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: series.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        series[index].posterPath,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: Colors.black54,
                          child: Text(
                            series[index].voteAverage.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No hay datos'));
          }
        },
      ),
    );
  }
}
