import 'package:flutter/material.dart';
import 'package:lab3/Campus.dart';
import 'package:lab3/InfoPage.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Example',
      home: CardScreen(),
    );
  }
}

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  // Кількість пар Card, які будуть відображатися
  String _universityName = '';
  String _residenceAddress = '';
  int _numberOfRooms = 0;
  int _numberOfStaff = 0;
  int _numberOfStudents = 0;
  double _accommodationFee = 0;

  void _showModal() {
    showAnimatedDialog(
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Add new card',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'University name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _universityName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Residence address',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _residenceAddress = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Number Of Rooms',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _numberOfRooms = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Number Of Staff',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _numberOfStaff = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Number Of Students',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _numberOfStudents = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Accommodation Fee',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _accommodationFee = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _addCards(Campus(
                          _numberOfRooms,
                          _numberOfStaff,
                          _universityName,
                          _numberOfStudents,
                          _accommodationFee,
                          _residenceAddress));
                      // Збережіть дані та закрийте модальний
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addCards(Campus tmp) {
    setState(() {
      // Додаємо нові пари Card при натисканні на кнопку "Плюс"
      campuses.add(tmp);
    });
  }

  final List<Campus> campuses = <Campus>[
    Campus(200, 10, "NURE", 150, 800, "Adddress 1"),
    Campus(300, 20, "KKNU", 150, 900, "Adddress 2"),
    Campus(400, 30, "NTU KPI", 150, 100, "Adddress 3"),
    Campus(500, 40, "NURE", 150, 700, "Adddress 4"),
    Campus(600, 50, "NURE", 150, 800, "Adddress 5"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter 3-4 laba",
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 16), // Пропуск для відступу
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Встановлюємо кількість кард в рядку
                    ),
                    itemCount: campuses.length,
                    // Встановлюємо кількість карток
                    itemBuilder: (BuildContext context, int index) {
                      if (index < 5) {
                        return CardWidget("assets/img/Campus${index + 1}.png",
                            campuses[index], _addCards);
                      } else {
                        return CardWidget("assets/img/Default.png",
                            campuses[index], _addCards);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showModal,
            // Викликаємо метод _addCards при натисканні на кнопку "Плюс"
            child: Icon(Icons.add),
          ),
        ));
  }
}

class CardWidget extends StatelessWidget {
  final String imageUrl; // Додали параметр для зображення
  final Campus _info;
  final Function(Campus) addCardsCallback;

  CardWidget(this.imageUrl, this._info,
      this.addCardsCallback); // Конструктор з параметром

  void _onCardPressed(BuildContext context) {
    // Обробник натискання на картку
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade, // Вид анімації під час переходу
        duration: Duration(milliseconds: 900), // Тривалість анімації
        child: CampusPage(_info, imageUrl),
      ),
    );
  }

  void _onCardLongPressed(BuildContext context) {
    // Обробник довгого натискання на картку
    addCardsCallback(_info);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Закруглення кутів
      ),
      child: InkWell(
        onTap: () => _onCardPressed(context), // Обробник натискання на картку
        onLongPress: () => _onCardLongPressed(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imageUrl != null && imageUrl.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageUrl,
                      height: 108,
                      fit: BoxFit.cover, // Масштабування картинки
                    ),
                  )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _info.universityName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _info.address,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
