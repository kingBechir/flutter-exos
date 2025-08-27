import 'package:flutter/material.dart'; // j'importe le package flutter de base pour faire mon app

void main() {
  runApp(MyApp()); // je lance mon application en appelant la classe MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // je crée mon application Material
      debugShowCheckedModeBanner: false, // j’enlève le petit bandeau "debug"
      home: TaskPage(), // je mets la page principale de mon app (TaskPage)
    );
  }
}

class Task {
  String title; // le nom de la tâche
  bool isCompleted; // savoir si elle est terminée ou pas
  Color color; // la couleur du petit point à droite

  Task({required this.title, this.isCompleted = false, required this.color}); // constructeur de la classe
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState(); // je crée l’état de la page
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [ // je mets une liste de tâches pour l’exemple
    Task(title: "Apprendre Flutter", color: Colors.blue),
    Task(title: "Faire les courses", isCompleted: true, color: Colors.green),
    Task(title: "Terminer le projet", color: Colors.orange),
    Task(title: "Lire un livre", color: Colors.purple),
    Task(title: "Faire du sport", isCompleted: true, color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( // le squelette principal de mon app
      appBar: AppBar( // la barre en haut (violette)
        backgroundColor: Colors.purple, // je mets la couleur violette
        title: Text("Mes Tâches"), // le titre affiché dans la barre
        actions: [ // j’ajoute des icônes à droite
          Icon(Icons.search), // la petite loupe de recherche
          SizedBox(width: 10), // j’ajoute un espace
        ],
      ),
      body: Column( // je mets le contenu en vertical
        children: [
          Container( // le haut violet avec les infos
            padding: EdgeInsets.all(16), // je mets de l’espace dedans
            decoration: BoxDecoration( // je fais le design
              color: Colors.purple, // fond violet
              borderRadius: BorderRadius.only( // coins arrondis en bas
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column( // je mets le texte et les stats en vertical
              crossAxisAlignment: CrossAxisAlignment.start, // je mets le texte à gauche
              children: [
                Row( // première ligne : Bonjour Marie et l’avatar
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // un à gauche, un à droite
                  children: [
                    Column( // je mets Bonjour Marie et le texte en dessous
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bonjour Marie!", // texte en gras
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text("Vous avez ${tasks.length} tâches à faire", // je montre combien de tâches il y a
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    CircleAvatar( // le rond pour l’avatar
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.purple), // l’icône utilisateur
                    ),
                  ],
                ),
                SizedBox(height: 20), // espace
                Row( // deuxième ligne : stats terminées et en cours
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple[700], // un violet un peu plus foncé
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text("${tasks.where((t) => t.isCompleted).length}", // je compte les tâches terminées
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("Terminées", style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // espace
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple[700], // pareil mais pour en cours
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text("${tasks.where((t) => !t.isCompleted).length}", // je compte les tâches pas terminées
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("En cours", style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded( // ici je mets la liste qui prend tout l’espace
            child: ListView.builder( // je fais une liste automatique
              itemCount: tasks.length, // le nombre d’items = nombre de tâches
              itemBuilder: (context, index) {
                final task = tasks[index]; // je prends une tâche de la liste
                return Card( // une carte pour chaque tâche
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile( // chaque ligne
                    leading: Checkbox( // case à cocher
                      value: task.isCompleted, // si elle est terminée ou pas
                      onChanged: (val) { // quand je clique dessus
                        setState(() { // je mets à jour
                          task.isCompleted = val!;
                        });
                      },
                    ),
                    title: Text(
                      task.title, // j’écris le titre
                      style: TextStyle(
                        decoration: task.isCompleted // si terminée -> barré
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row( // les icônes à droite
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: task.color, size: 12), // le petit rond coloré
                        SizedBox(width: 10),
                        Icon(Icons.delete, color: Colors.red), // l’icône poubelle
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton( // bouton flottant +
        backgroundColor: Colors.purple, // couleur violette
        child: Icon(Icons.add), // icône +
        onPressed: () {}, // pour l’instant je ne mets rien
      ),
    );
  }
}
