// j'importe le package flutter de base (widgets, material design etc.)
import 'package:flutter/material.dart';

// point d'entrée de mon app
void main() {
  // je lance mon app qui s'appelle Exo6App
  runApp(const Exo6App());
}

// c'est mon widget principal
class Exo6App extends StatelessWidget {
  const Exo6App({super.key}); // constructeur de base

  @override
  Widget build(BuildContext context) {
    // je retourne une MaterialApp (c'est la base de toutes les apps flutter)
    return MaterialApp(
      debugShowCheckedModeBanner: false, // j'enlève le petit bandeau "debug"
      title: 'Exo 6 - Profil', // titre de mon app
      theme: ThemeData(
        useMaterial3: true, // j'active material 3 (nouveau design flutter)
        colorSchemeSeed: const Color(0xFF4A90E2), // couleur principale (bleu)
        fontFamily: 'Roboto', // police du texte
      ),
      home: const ProfilePage(), // la première page affichée est ProfilePage
    );
  }
}

// ma page de profil
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF5F5F5); // couleur gris clair pour le fond

    return Scaffold(
      backgroundColor: bg, // j’applique la couleur du fond
      body: SafeArea( // safe area pour pas que ça touche les bordures (ex: notch)
        child: SingleChildScrollView( // je mets un scroll pour pas déborder
          child: Column(
            children: [
              // j’affiche le header (haut de la page)
              const _ProfileHeader(),

              // espace
              const SizedBox(height: 16),

              // mes 3 cartes de stats (projets, followers, following)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // marge
                child: Row(
                  children: const [
                    Expanded( // 1ere carte
                      child: _StatCard(
                        icon: Icons.folder_open_rounded, // icône dossier
                        iconColor: Color(0xFF2196F3), // bleu foncé
                        value: '12', // valeur affichée
                        label: 'Projets', // label en dessous
                      ),
                    ),
                    SizedBox(width: 12), // espace entre les cartes
                    Expanded( // 2eme carte
                      child: _StatCard(
                        icon: Icons.group_rounded, // icône groupe
                        iconColor: Color(0xFF42A5F5), // bleu moyen
                        value: '1.2k', // valeur
                        label: 'Followers', // label
                      ),
                    ),
                    SizedBox(width: 12), // espace
                    Expanded( // 3eme carte
                      child: _StatCard(
                        icon: Icons.person_add_alt_1_rounded, // icône ajout user
                        iconColor: Color(0xFF64B5F6), // bleu clair
                        value: '340', // valeur
                        label: 'Following', // label
                      ),
                    ),
                  ],
                ),
              ),

              // espace
              const SizedBox(height: 16),

              // le menu des options (paramètres, aide etc.)
              const _OptionsCard(),

              // espace final
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// header en haut avec le dégradé + avatar + nom
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Stack( // je stacke des widgets les uns sur les autres
      clipBehavior: Clip.none,
      alignment: Alignment.center, // centré
      children: [
        // fond bleu dégradé
        Container(
          height: 160,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF6BB3FF)], // bleu foncé -> clair
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // avatar + textes positionnés en bas
        Positioned(
          bottom: -64, // je fais descendre un peu
          child: Column(
            children: [
              // avatar rond
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15), // petite ombre
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 48, // taille avatar externe
                  backgroundColor: Color(0xFFE9D9FF), // halo violet
                  child: CircleAvatar(
                    radius: 44, // cercle interne
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_rounded, // icône utilisateur
                      size: 48,
                      color: Color(0xFF7E57C2), // violet foncé
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Marie Dubois', // nom affiché
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Développeuse Flutter', // sous-titre
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 64), // espace avant les stats
            ],
          ),
        ),
      ],
    );
  }
}

// composant d’une carte statistique (réutilisable)
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card( // une petite carte avec ombre
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar( // icône dans un cercle
              radius: 18,
              backgroundColor: iconColor.withOpacity(0.12),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              value, // j’affiche la valeur
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label, // j’affiche le label
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// carte qui contient toutes les options (liste de menus)
class _OptionsCard extends StatelessWidget {
  const _OptionsCard();

  @override
  Widget build(BuildContext context) {
    final tileColor = Colors.black.withOpacity(0.06); // fond gris pour icônes

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            _OptionTile(
              icon: Icons.settings_rounded,
              bgColor: tileColor,
              title: 'Paramètres',
              trailing: Icons.chevron_right_rounded, // petite flèche
            ),
            _OptionTile(
              icon: Icons.help_outline_rounded,
              bgColor: tileColor,
              title: 'Aide',
              trailing: Icons.chevron_right_rounded,
            ),
            _OptionTile(
              icon: Icons.star_rate_rounded,
              bgColor: tileColor,
              title: "Évaluer l'app",
              trailing: Icons.chevron_right_rounded,
            ),
            _OptionTile(
              icon: Icons.share_rounded,
              bgColor: tileColor,
              title: 'Partager',
              trailing: Icons.chevron_right_rounded,
            ),
            const Divider(height: 0), // séparateur
            _OptionTile(
              icon: Icons.logout_rounded,
              bgColor: tileColor,
              title: 'Déconnexion',
              trailing: null, // pas de flèche
            ),
          ],
        ),
      ),
    );
  }
}

// un seul bouton de menu
class _OptionTile extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final String title;
  final IconData? trailing;

  const _OptionTile({
    required this.icon,
    required this.bgColor,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar( // petit rond à gauche avec icône
        radius: 18,
        backgroundColor: bgColor,
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: trailing != null ? Icon(trailing) : null, // flèche si pas null
      onTap: () {}, // je laisse vide, c’est juste visuel
      dense: true, // compact
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
