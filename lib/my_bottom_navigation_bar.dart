import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Xin chào",
      debugShowCheckedModeBanner: false,
      home: MyButtonNavigationBar()
    );
  }
}

class MyButtonNavigationBar extends StatefulWidget {
  const MyButtonNavigationBar({super.key});

  @override
  State<MyButtonNavigationBar> createState() => _MyButtonNavigationBarState();
}

class _MyButtonNavigationBarState extends State<MyButtonNavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Trang chu', style: optionStyle),
    Text('Lich hoc', style: optionStyle),
    Text('Diem danh', style: optionStyle),
    Text('Ca nhan', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigationBar Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: "Trang chu",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
            label: "Lich hoc",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note, color: Colors.black),
            label: "Diem danh",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: "Ca nhan",
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 55, 63, 215),
        onTap: _onItemTapped
      ),
    );
  }
}
