import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const DarkHomeAnimated(),
    );
  }
}

class DarkHomeAnimated extends StatefulWidget {
  const DarkHomeAnimated({super.key});
  @override
  State<DarkHomeAnimated> createState() => _DarkHomeAnimatedState();
}

class _DarkHomeAnimatedState extends State<DarkHomeAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;     // fade-in
  late final Animation<double> _slideUp;  // petite montée

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slideUp = Tween<double>(begin: 12, end: 0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Colors.black;
    const subtitle = Colors.white70;
    final darkCard = Colors.grey[900]!;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fade,
                child: AnimatedBuilder(
                  animation: _slideUp,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _slideUp.value),
                    child: child,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Bonjour',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Votre espace personnel',
                        style: TextStyle(fontSize: 14, color: subtitle),
                      ),
                      const SizedBox(height: 24),

                      // Carte blanche animée (hover/press)
                      _HoverCard(
                        background: Colors.white,
                        child: const _CardContent(
                          title: 'Projets',
                          subtitle: '3 projets en cours',
                          titleColor: Colors.black,
                          subtitleColor: Colors.black54,
                        ),
                        shadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            offset: Offset(0, 6),
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Carte foncée animée
                      _HoverCard(
                        background: darkCard,
                        child: const _CardContent(
                          title: 'Activité',
                          subtitle: 'Dernière connexion : aujourd’hui',
                          titleColor: Colors.white,
                          subtitleColor: Colors.white60,
                        ),
                      ),

                      const Spacer(),

                      // Bouton animé (scale on press + ripple)
                      Center(
                        child: _PressableScale(
                          child: SizedBox(
                            width: 180,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: const StadiumBorder(),
                                elevation: 2,
                              ),
                              child: const Text(
                                'Commencer',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
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
      ),
    );
  }
}

/// Contenu standard des cartes
class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.title,
    required this.subtitle,
    required this.titleColor,
    required this.subtitleColor,
  });

  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: subtitleColor),
        ),
      ],
    );
  }
}

/// Carte avec animation de hover (web) + légère translation et opacité
class _HoverCard extends StatefulWidget {
  const _HoverCard({
    required this.child,
    required this.background,
    this.shadow,
  });

  final Widget child;
  final Color background;
  final List<BoxShadow>? shadow;

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: widget.background.withOpacity(_hover ? 0.96 : 1),
        borderRadius: BorderRadius.circular(14),
        boxShadow: widget.shadow,
      ),
      child: widget.child,
    );

    // Sur web : réagit au survol ; sur mobile : simple container
    return kIsWeb
        ? MouseRegion(
            onEnter: (_) => setState(() => _hover = true),
            onExit: (_) => setState(() => _hover = false),
            child: card,
          )
        : card;
  }
}

/// Petit effet scale pendant l’appui (press)
class _PressableScale extends StatefulWidget {
  const _PressableScale({required this.child});
  final Widget child;

  @override
  State<_PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<_PressableScale> {
  bool _down = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapUp: (_) => setState(() => _down = false),
      onTapCancel: () => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
