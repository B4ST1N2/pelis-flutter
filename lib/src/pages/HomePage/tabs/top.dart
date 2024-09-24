import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista combinada de películas y series favoritas
    final List<String> favorites = [
      '🎬 Junto a los dioses (Película)',
      '🎬 El origen (Película)',
      '🎬 Entre navajas y secretos (Película)',
      '🎬 Contratiempo (Película)',
      '📺 Nadie nos va a extrañar (Serie)',
      '📺 Atípico (Serie)',
      '📺 Sabrina (Serie)',
      '📺 The Witcher (Serie)',
    ];

    return Scaffold(
      appBar: AppBar(
        // Título de la pantalla
        title: const Text('Top Personal Películas y Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espacio alrededor del contenido
        child: Center( // Centra el contenido vertical y horizontalmente
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra la columna verticalmente
            children: [
              const Text(
                'Películas y Series Favoritas', // Título de la lista
                style: TextStyle(fontSize: 24), // Aumenta el tamaño del texto
              ),
              const SizedBox(height: 10), // Espacio entre el título y la lista
              // Usando un bucle for para agregar los elementos
              for (String item in favorites)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacio entre los elementos
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 20), // Aumenta el tamaño del texto
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
