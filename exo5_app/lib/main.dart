import 'package:flutter/material.dart'; // j'importe flutter pour utiliser les widgets

void main() => runApp(const MyApp()); // point d'entrée de mon app, j'appelle MyApp

// ma classe principale
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // constructeur de base

  @override
  Widget build(BuildContext context) {
    // je définis mon app
    return MaterialApp(
      debugShowCheckedModeBanner: false, // j'enlève le bandeau rouge "debug"
      theme: ThemeData(
        useMaterial3: true, // j'utilise la version material 3
        brightness: Brightness.dark, // je mets un thème sombre
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF13161B), // couleur des cartes
        ),
      ),
      home: const DashboardScreen(), // ma page d'accueil c'est DashboardScreen
    );
  }
}

// écran principal
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key}); // constructeur

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF0E1116); // couleur fond général
    final card = Theme.of(context).colorScheme.surface; // récupère la couleur des cartes

    return Scaffold(
      backgroundColor: bg, // j'applique mon fond
      body: SafeArea( // pour pas que ça dépasse la barre du haut
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430), // largeur max comme un téléphone
            child: Padding(
              padding: const EdgeInsets.all(16), // marge autour
              child: Container(
                decoration: BoxDecoration(
                  color: card, // couleur de la carte
                  borderRadius: BorderRadius.circular(16), // coins arrondis
                ),
                padding: const EdgeInsets.all(16), // marge interne
                child: Column(
                  children: [
                    // ---------- HEADER ----------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // aligné en haut
                      children: [
                        Expanded( // prend tout l'espace dispo
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Bonsoir...',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 13)), // texte gris
                              SizedBox(height: 2), // petit espace
                              Text(
                                'Bechir ✨',
                                style: TextStyle(
                                  fontSize: 20, // taille plus grande
                                  fontWeight: FontWeight.w700, // en gras
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36, // carré notif
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white10, // fond transparent
                            borderRadius: BorderRadius.circular(10), // arrondi
                          ),
                          child: const Icon(Icons.notifications_none, size: 20), // icône notif
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // espace après header

                    // ---------- GRID 2x2 ----------
                    GridView.count(
                      crossAxisCount: 2, // 2 colonnes
                      crossAxisSpacing: 12, // espace horizontal
                      mainAxisSpacing: 12, // espace vertical
                      childAspectRatio: 1.25, // ratio largeur/hauteur
                      physics: const NeverScrollableScrollPhysics(), // pas scrollable
                      shrinkWrap: true, // prend juste la place des items
                      children: const [
                        _CategoryCard(
                          color: Color(0xFFE06AA6), // rose
                          icon: Icons.music_note,
                          title: 'Musique',
                          subtitle: '23 playlists',
                        ),
                        _CategoryCard(
                          color: Color(0xFF41C6C5), // turquoise
                          icon: Icons.camera_alt,
                          title: 'Photos',
                          subtitle: '156 images',
                        ),
                        _CategoryCard(
                          color: Color(0xFFF1C94A), // jaune
                          icon: Icons.book,
                          title: 'Lecture',
                          subtitle: '5 livres',
                        ),
                        _CategoryCard(
                          color: Color(0xFFE16666), // rouge
                          icon: Icons.fitness_center,
                          title: 'Sport',
                          subtitle: '12 exercices',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8), // espace

                    // ---------- LISTE ACTIVITÉS ----------
                    const _SectionTitle('Activité récente'), // titre section
                    const SizedBox(height: 8),

                    Expanded(
                      child: ListView(
                        children: const [
                          _ActivityTile(
                            color: Color(0xFFE06AA6),
                            icon: Icons.album,
                            title: 'Playlist Chill',
                            subtitle: 'Écoutée il y a 2h',
                          ),
                          _ActivityTile(
                            color: Color(0xFF41C6C5),
                            icon: Icons.photo,
                            title: 'Photo de vacances',
                            subtitle: 'Ajoutée hier',
                          ),
                          _ActivityTile(
                            color: Color(0xFFF1C94A),
                            icon: Icons.menu_book,
                            title: 'Chapitre 5 terminé',
                            subtitle: 'Il y a 3 jours',
                          ),
                        ],
                      ),
                    ),

                    // ---------- BOUTON ----------
                    SizedBox(
                      width: double.infinity, // prend toute la largeur
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () {}, // pour l'instant il fait rien
                        icon: const Icon(Icons.explore), // icône explorer
                        label: const Text('Explorer'), // texte bouton
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B62FF), // couleur violet
                          foregroundColor: Colors.white, // texte en blanc
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // coins arrondis
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ====== WIDGETS RÉUTILISABLES ======
class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Color color; // couleur de l'icône
  final IconData icon; // icône
  final String title; // titre
  final String subtitle; // sous titre

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14), // marge interne
      decoration: BoxDecoration(
        color: Colors.white10, // fond transparent
        borderRadius: BorderRadius.circular(14), // arrondi
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // petit badge rond coloré
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(.18), // cercle transparent
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color), // l'icône colorée
          ),
          const Spacer(), // pousse le texte en bas
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {super.key});
  final String text; // texte du titre

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // aligné à gauche
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700, // gras
          fontSize: 16,
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), // espace entre items
      padding: const EdgeInsets.all(12), // marge interne
      decoration: BoxDecoration(
        color: Colors.white10, // fond transparent
        borderRadius: BorderRadius.circular(12), // arrondi
      ),
      child: Row(
        children: [
          // avatar coloré
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(.18),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12), // espace entre avatar et texte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)), // titre
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 12)), // sous titre
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white30, size: 20), // flèche à droite
        ],
      ),
    );
  }
}
