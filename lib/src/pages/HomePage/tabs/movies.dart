import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/movie.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  // Petición HTTP para obtener la lista de películas populares desde la API de The Movie Database (TMDb)
  Future<List<Movie>> _getMovies() async {
    final String apiKey = 'de41cb42556ebb1f1033892b3cf7a9d2'; // Tu clave de API
    final String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'; // URL de la API para obtener películas populares

    // Realiza la petición HTTP GET
    final response = await http.get(Uri.parse(url));

    // Si la respuesta es exitosa (código 200)
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body); // Decodifica el cuerpo de la respuesta en formato JSON
      List<Movie> movies = []; // Lista que almacenará las películas

      // Recorre los resultados del JSON y crea objetos Movie
      for (var movieData in jsonData['results']) {
        Movie movie = Movie(
          title: movieData['title'], // Título de la película
          posterPath:
              'https://image.tmdb.org/t/p/w500${movieData['poster_path']}', // Ruta completa del póster de la película
          voteAverage: movieData['vote_average'].toDouble(), // Puntuación de la película
        );
        movies.add(movie); // Añade la película a la lista
      }
      return movies; // Devuelve la lista de películas
    } else {
      throw Exception('Error al cargar las películas'); // Lanza una excepción si la petición falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: FutureBuilder<List<Movie>>(
        future: _getMovies(), // Llama a la función que obtiene las películas
        builder: (context, snapshot) {

          // Si ocurre un error durante la petición, muestra un mensaje de error
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las películas'));
          }
          // Si los datos están disponibles, crea un GridView con las películas
          else if (snapshot.hasData) {
            List<Movie> movies = snapshot.data!; // Obtiene la lista de películas

            // GridView.builder: Crea una rejilla de películas (2 columnas)
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos columnas de películas por fila
                crossAxisSpacing: 10.0, // Espacio horizontal entre las columnas
                mainAxisSpacing: 10.0, // Espacio vertical entre las filas
                childAspectRatio: 0.7, // Relación de aspecto entre el ancho y el alto de cada película
              ),
              itemCount: movies.length, // Número total de películas
              itemBuilder: (context, index) {
                // Stack: Superpone la imagen del póster y la puntuación
                return Stack(
                  children: [
                    // Muestra el póster de la película
                    Image.network(
                      movies[index].posterPath,
                      fit: BoxFit.cover, // Ajusta la imagen para llenar el contenedor
                      width: double.infinity, // Usa todo el ancho disponible
                      height: double.infinity, // Usa todo el alto disponible
                    ),
                    // Posiciona la puntuación en el centro de la imagen
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.black54, // Fondo semitransparente detrás de la puntuación
                          child: Text(
                            movies[index].voteAverage.toString(), // Muestra la puntuación de la película
                            style: const TextStyle(
                              color: Colors.white, // Texto en blanco
                              fontSize: 24, // Tamaño de la fuente de la puntuación
                              fontWeight: FontWeight.bold, // Puntuación en negrita
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: Text('No hay datos')); // Si no hay datos, muestra un mensaje
          }
        },
      ),
    );
  }
}
