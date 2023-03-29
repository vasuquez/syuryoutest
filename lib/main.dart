import 'package:flutter/material.dart';
import 'package:syuryou_test/tuika.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja_JP', null); // 追加
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'カレンダー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<DateTime, List> _eventsList = {};

  DateTime _focused = DateTime.now();
  DateTime? _selected;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();

    _selected = _focused;
    _eventsList = {
      DateTime.now().subtract(Duration(days: 2)): ['Test A', 'Test B'],
      DateTime.now(): ['Test C', 'Test D', 'Test E', 'Test F'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEvent(DateTime day) {
      return _events[day] ?? [];
    }

    void _showModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Selected Date: ${_selected!.day}/${_selected!.month}/${_selected!.year}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Add logic to handle button press
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => tuika(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: getEvent(_selected!).length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(getEvent(_selected!)[index].toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ja_JP',
            firstDay: DateTime.utc(2022, 4, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            eventLoader: getEvent,
            selectedDayPredicate: (day) {
              return isSameDay(_selected, day);
            },
            onDaySelected: (selected, focused) {
              if (!isSameDay(_selected, selected)) {
                setState(() {
                  _selected = selected;
                  _focused = focused;
                  _showModalBottomSheet(context);
                });
              }
            },
            focusedDay: _focused,
          ),
        ],
      ),
    );
  }
}