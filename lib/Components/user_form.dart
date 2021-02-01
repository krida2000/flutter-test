import 'package:flutter/material.dart';

String defaultValidator(value){
  if(value.isEmpty) return 'Введите значение';
  return null;
}

class ChangeForm extends StatelessWidget {
  const ChangeForm({
    Key key,
    @required GlobalKey<FormState> formKey, String firstName, String lastName, DateTime date,
    Function firstNameSetter, Function lastNameSetter, Function dateSetter
  }) : _formKey = formKey, firstName = firstName, lastName = lastName, date = date,
        firstNameSetter = firstNameSetter, lastNameSetter = lastNameSetter, dateSetter = dateSetter, super(key: key);

  final GlobalKey<FormState> _formKey;
  final String firstName;
  final String lastName;
  final DateTime date;
  final Function firstNameSetter;
  final Function lastNameSetter;
  final Function dateSetter;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Имя', style: Theme.of(context).textTheme.bodyText1),
          TextFormField(initialValue: firstName, validator: defaultValidator, onChanged: (value) {
            firstNameSetter(value);
          }),
          Text('Фамилия', style: Theme.of(context).textTheme.bodyText1),
          TextFormField(initialValue: lastName, validator: defaultValidator, onChanged: (value) {
            lastNameSetter(value);
          }),
          Text('Дата рождения', style: Theme.of(context).textTheme.bodyText1),
          TextFormField(initialValue: date.toString(), validator: (value,) {
            if(value.isEmpty) return 'Введите дату';
            if(DateTime.tryParse(value) == null) return 'Введите дату в формате yyyy-mm-dd hh:mm:ss.ms';
            return null;
          }, onChanged: (value) {
            if(DateTime.tryParse(value) != null)
              dateSetter(DateTime.parse(value));
          },),
        ],
      ),
    );
  }
}