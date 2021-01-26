import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(bodyText1: TextStyle(fontSize: 25))
      ),
      home: UserScreen(title: 'User screen'),
    );
  }
}

class UserScreen extends StatefulWidget {
  UserScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  String _firstName = "Андрей";
  String _lastName = "Колесник";
  final String _phone = "0991233216";
  DateTime _date = DateTime(2000);
  String _mod = "Read";

  final _formKey = GlobalKey<FormState>();

  void _changeMod() {
    setState(() {
      if(_formKey.currentState.validate())
        _mod = _mod == "Read" ? "Change" : "Read";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            circleAvatar(),
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        showFirstName(),
                        showLastName(),
                        showPhone(),
                        showDate(),
                      ],
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeMod,
        tooltip: 'Increment',
        child: Icon(_mod == "Read" ? Icons.auto_fix_high : Icons.save),
      ),

    );
  }

  Widget circleAvatar(){
    return CircleAvatar(
      backgroundImage: NetworkImage('https://ps.w.org/restrict-user-access/assets/icon-256x256.png?rev=1815922'),
    radius: 75,);
  }

  Widget showFirstName(){
    if(_mod == "Read")
      return Text('Имя: $_firstName', style: Theme.of(context).textTheme.bodyText1);
    else
      return Column(
              children: [
                Text('Имя', style: Theme.of(context).textTheme.bodyText1),
                TextFormField(initialValue: _firstName, validator: (value) {
                  if(value.isEmpty) return 'Введите значение';
                  return null;
                }, onChanged: (value) {
                  _firstName = value;
                }),
              ],
            );
  }

  Widget showLastName(){
    if(_mod == "Read")
      return Text('Фамилия: $_lastName', style: Theme.of(context).textTheme.bodyText1);
    else
      return Column(
        children: [
          Text('Фамилия', style: Theme.of(context).textTheme.bodyText1),
          TextFormField(initialValue: _lastName, validator: (value) {
            if(value.isEmpty) return 'Введите значение';
            return null;
          }, onChanged: (value) {
            _lastName = value;
          }),
        ],
      );
  }

  Widget showPhone(){
    if(_mod == "Read")
      return Text(
        'Телефон: $_phone',
        style: Theme.of(context).textTheme.bodyText1,
      );
    else
      return  Text("");
  }

  Widget showDate(){
    if(_mod == "Read")
      return Text('Дата рождения: ${_date.day}.${_date.month}.${_date.year}', style: Theme.of(context).textTheme.bodyText1);
    else
      return Column(
        children: [
          Text('Дата рождения', style: Theme.of(context).textTheme.bodyText1),
          TextFormField(initialValue: makeDateString(_date), validator: (value,) {
            if(value.isEmpty) return 'Введите дату';
            if(DateTime.tryParse(value.split('.').reversed.join()) == null) return 'Введите дату в формате dd.mm.yyyy';
            return null;
          }, onChanged: (value) {
            var date = DateTime.tryParse(value.split('.').reversed.join());
            if(DateTime.tryParse(value.split('.').reversed.join()) != null)
              _date = DateTime.tryParse(value.split('.').reversed.join());
          },)
        ],
      );
  }

  String makeDateString(DateTime date){
    String day = date.day.toString();
    if(day.length < 2) day = '0' + day;

    String month = date.month.toString();
    if(month.length < 2) month = '0' + month;

    return '$day.$month.${date.year}';
  }
}
