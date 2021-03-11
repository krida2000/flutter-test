import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../Const.dart';

class UserScreenBloc {
  Mods _mod;

  UserScreenBloc() {
    _mod = Mods.Read;
    _actionController.stream.listen(_changeModStream);
  }

  final _modStream = BehaviorSubject<Mods>.seeded(Mods.Read);

  Stream get mod => _modStream.stream;
  Sink get _addValue => _modStream.sink;

  StreamController _actionController = StreamController();
  StreamSink get changeMod => _actionController.sink;

  void _changeModStream(data) {
    _mod = _mod == Mods.Read ? Mods.Change : Mods.Read;
    _addValue.add(_mod);
  }

  void dispose() {
    _modStream.close();
    _actionController.close();
  }
}