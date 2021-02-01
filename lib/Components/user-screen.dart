import 'package:flutter/material.dart';
import 'package:test_flutter/Bloc/user_screen_bloc.dart';
import 'package:test_flutter/Components/user_form.dart';

import '../Const.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserScreenBloc userScreenBloc = UserScreenBloc();

  String _firstName = "Андрей";
  String _lastName = "Колесник";
  final String phone = "0991233216";
  DateTime _date = DateTime(2000);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
                radius: 75,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              StreamBuilder<Mods>(
                  stream: userScreenBloc.mod,
                  builder: (context, snapshot) {
                    return snapshot.data == Mods.Read
                        ? Center(
                            child: Column(children: [
                              Text('Имя: $_firstName',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text('Фамилия: $_lastName',
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text(
                                'Телефон: $phone',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                  'Дата рождения: ${_date.day}.${_date.month}.${_date.year}',
                                  style: Theme.of(context).textTheme.bodyText1)
                            ]),
                          )
                        : ChangeForm(
                            formKey: _formKey,
                            firstName: _firstName,
                            lastName: _lastName,
                            date: _date,
                            firstNameSetter: (value) {
                              _firstName = value;
                            },
                            lastNameSetter: (value) {
                              _lastName = value;
                            },
                            dateSetter: (value) {
                              _date = value;
                            },
                          );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userScreenBloc.changeMod.add(null);
        },
        tooltip: 'Increment',
        child: StreamBuilder<Mods>(
            stream: userScreenBloc.mod,
            builder: (context, snapshot) {
              return Icon(snapshot.data == Mods.Read ? Icons.edit : Icons.save);
            }),
      ),
    );
  }
}
