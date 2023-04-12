import 'package:flutter/material.dart';
import 'package:lab3/Campus.dart';

class CampusPage extends StatelessWidget {
  final Campus info;
  final String imageUrl;

  CampusPage(this.info, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            info.universityName,
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                colors: <Color>[Color(0xFF5a8bff), Color(0xFF74c3ff)],
              ),
            ),
          ),
          toolbarHeight: 70,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Іконка стрілки "назад"
            onPressed: () {
              Navigator.pop(context); // Функція повернення на попередню сторінку
            },
          ),
        ),
        body: CheckboxWithText(info, imageUrl),
      ),
    );
  }
}

class CheckboxWithText extends StatefulWidget {
  final Campus info;
  final String imageUrl;

  CheckboxWithText(this.info, this.imageUrl);

  @override
  CampusInfo createState() => CampusInfo(info, info.cafeteria, imageUrl);
}

class CampusInfo extends State<CheckboxWithText> {
  bool isChecked;
  final Campus info;
  final String imageUrl;

  CampusInfo(this.info, this.isChecked, this.imageUrl);

  bool _isVisible = false;
  bool _isFullChecked = false;

  void _showText() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _showFullInfo() {
    setState(() {
      _isFullChecked = !_isFullChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 70.0,
              ),
            ),
            SizedBox(width: 20.0),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Payment: ${info.accommodationFee}',
                    style: TextStyle(fontSize: 19.0),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Number of staff: ${info.numberOfStaff}',
                    style: TextStyle(fontSize: 19.0),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Address: ${info.address}',
                    style: TextStyle(fontSize: 19.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0),
              child: Text(
                'Number of rooms:  ${info.numberOfRooms}',
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  info.increaseNumberOfRooms(1);
                });
              },
              child: Text('Add room'),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0),
              child: Text(
                'Number of students: \n${info.numberOfStudents}',
                style: TextStyle(fontSize: 19.0),
              ),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  info.accommodateStudents(1);
                });
              },
              child: Text('Settle'),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  info.evictStudents(1);
                });
              },
              child: Text('Evict'),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                if (value!) {
                  info.addCafeteria();
                } else
                  info.removeCafeteria();
                setState(() {
                  isChecked = value;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (!isChecked) {
                    info.addCafeteria();
                  } else
                    info.removeCafeteria();
                  isChecked = !isChecked;
                });
              },
              child: Text(
                'Dining room:',
                style: TextStyle(
                  fontSize: 19.0,
                  color: isChecked ? Colors.black : Colors.grey,
                ),
              ),
            ),
            if (isChecked)
              Padding(
                padding: EdgeInsets.only(left: 19.0),
                child: Text(
                  'Dining room added',
                  style: TextStyle(fontSize: 19.0),
                ),
              ),
          ],
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _showFullInfo,
          child: SizedBox(
            width: 200,
            height: 70,
            child: Center(
              child: Text(
                'Campus Information',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Visibility(
          visible: _isFullChecked,
          child: Center(
              child: Text(
              "Profit per year: ${info.toString()}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 2000),
          opacity: _isVisible ? 0.0 : 1.0,
          curve: Curves.bounceIn,
          child: InkWell(
            onTap: _showText,
            child: Center(
              child: Text(
                "Profit per year: ${info.calculateIncome().toString()}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
