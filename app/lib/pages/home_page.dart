import 'package:app/pages/editoras_page.dart';
import 'package:app/pages/mangas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> pages = const [MangasPage(), EditorasPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mangá App"),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: ((value) {
          setState(() {
            currentIndex = value;
          });
        }),
        backgroundColor: Theme.of(context).primaryColorDark,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Mangás",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Editoras",
          ),
        ],
      ),
    );
  }
}
