import 'package:flutter/material.dart';
// j'importe la librairie flutter pour utiliser les widgets

void main() => runApp(const MyApp());
// le point d'entrée de mon appli, je lance MyApp

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // je construis mon appli ici
    return MaterialApp(
      debugShowCheckedModeBanner: false, // j'enlève le bandeau debug
      theme: ThemeData(
        useMaterial3: true, // j'active le material design 3
        colorSchemeSeed: Colors.deepPurple, // je mets du violet comme couleur
        brightness: Brightness.light, // thème clair
      ),
      home: const HomeScreen(), // la page principale c'est HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Colors.deepPurple; // j'utilise cette couleur souvent

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB), // fond gris clair
      body: SafeArea( // ça évite que l'écran se colle trop aux bords du tel
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420), // largeur max 420
            child: Padding(
              padding: const EdgeInsets.all(24), // je mets des marges de 24
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // centré
                children: [

                  // Avatar rond avec icône
                  CircleAvatar(
                    radius: 30, // taille du rond
                    backgroundColor: purple, // rond violet
                    child: const Icon(Icons.person, color: Colors.white, size: 32), // icône blanc dedans
                  ),
                  const SizedBox(height: 16), // espace

                  // Texte titre
                  const Text(
                    'Salut Bechir !',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold, // je mets en gras
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Texte sous-titre
                  const Text(
                    'Prêt pour une nouvelle journée ?',
                    style: TextStyle(color: Colors.black54), // texte gris
                  ),
                  const SizedBox(height: 24),

                  // Carte avec tâches
                  Card(
                    elevation: 2, // petite ombre
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // coins arrondis
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), // marges internes
                      child: Row(
                        children: [
                          Container(
                            width: 42, height: 42, // taille du rond
                            decoration: BoxDecoration(
                              color: purple.withOpacity(.12), // violet clair
                              shape: BoxShape.circle, // rond
                            ),
                            child: Icon(Icons.check_circle, color: purple, size: 26), // icône check violet
                          ),
                          const SizedBox(width: 14), // espace

                          // Texte à droite
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tâches du jour',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)), // titre
                                SizedBox(height: 4),
                                Text('Vous avez 4 tâches à compléter',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54)), // sous-titre gris
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // stats en 2 colonnes
                  Row(
                    children: const [
                      Expanded(
                        child: StatCard(
                          value: '12',
                          label: 'Terminées',
                          accent: Colors.deepPurple, // violet
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          value: '4',
                          label: 'En cours',
                          accent: Colors.redAccent, // rouge
                        ),
                      ),
                    ],
                  ),

                  const Spacer(), // pousse le bouton en bas

                  // bouton commencer
                  SizedBox(
                    width: 180,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {}, // rien pour l’instant
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple, // fond violet
                        foregroundColor: Colors.white, // texte blanc
                        shape: const StadiumBorder(), // bouton arrondi
                        elevation: 2, // petite ombre
                      ),
                      child: const Text('Commencer'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// widget pour afficher une petite carte avec chiffre et texte
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.accent,
  });

  final String value; // le chiffre
  final String label; // le texte en dessous
  final Color accent; // couleur

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), // coins arrondis
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: accent, // couleur différente selon la stat
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54), // petit texte gris
            ),
          ],
        ),
      ),
    );
  }
}
