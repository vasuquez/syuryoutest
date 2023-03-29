import 'package:flutter/material.dart';

class tuika extends StatefulWidget {
  @override
  _TuikaState createState() => _TuikaState();
}

class _TuikaState extends State<tuika> {
  bool _isAllDay = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  void _onAllDaySwitchChanged(bool value) {
    setState(() {
      _isAllDay = value;
    });
  }

  void _onStartDateChanged(DateTime value) {
    setState(() {
      _startDate = value;
    });
  }

  void _onEndDateChanged(DateTime value) {
    setState(() {
      _endDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('予定の追加'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(30, 30),
                ),
                child: Text(
                  '保存',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                onPressed: () {
                  // ボタンが押された時の処理
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'タイトルを入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ListTile(
                title: Text('終日'),
                trailing: Switch(
                  value: _isAllDay,
                  onChanged: _onAllDaySwitchChanged,
                ),
              ),
              ListTile(
                title: Text('開始時間'),
                trailing: TextButton(
                  child: Text('${_startDate.toString()}'),
                  onPressed: () async {
                    final selectedDate =
                    await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (selectedDate != null) {
                      _onStartDateChanged(selectedDate);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text('終了時間'),
                trailing: TextButton(
                  child: Text('${_endDate.toString()}'),
                  onPressed: () async {
                    final selectedDate =
                    await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (selectedDate != null) {
                      _onEndDateChanged(selectedDate);
                    }
                  },
                ),
              ),
              ListTile(
                subtitle: TextField(
                  decoration: InputDecoration(
                    labelText: 'コメントを入力してください',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}