import 'package:flutter/material.dart'; 
import 'package:myapp/src/pages/HomePage/tabs/movies.dart'; 
import 'package:myapp/src/pages/HomePage/tabs/series.dart'; 
import 'package:myapp/src/pages/HomePage/tabs/top.dart'; 

class homePage extends StatelessWidget {
  const homePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Widget padre que controla las pestañas (tabs).
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 228, 211, 64), // Define el color de fondo del AppBar.
          title: const Text('IMBXD'), // Título centrado que aparece en el AppBar.
          centerTitle: true, // Alinea el título en el centro del AppBar.
          bottom: const TabBar(
            // Crea la barra de pestañas en la parte inferior del AppBar.
            tabs: [
              Tab(icon: Icon(Icons.movie)), // Primera pestaña con un icono de película.
              Tab(icon: Icon(Icons.tv)), // Segunda pestaña con un icono de televisión.
              Tab(icon: Icon(Icons.topic)), // Tercera pestaña con un icono de tema.
            ],
          ),
        ),
        // Cuerpo de la pantalla que cambia dependiendo de la pestaña seleccionada.
        body: const TabBarView(children: [
          Movies(), // Muestra el widget Movies cuando la primera pestaña está seleccionada.
          Series(), // Muestra el widget Series cuando la segunda pestaña está seleccionada.
          Top(), // Muestra el widget Top cuando la tercera pestaña está seleccionada.
        ]),
      ),
    );
  }
}
