import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:ai_paint/common/event_data.dart';

class EventHelper<T> {
  static EventHelper? _instance;

  static EventHelper? get instance => _getInstance();
  late EventBus eventBus;

  EventHelper._internal(){
    eventBus = EventBus();
  }

  factory EventHelper()=> _getInstance() as EventHelper<T>;

  static EventHelper? _getInstance() {
    if (_instance == null) {
      _instance = EventHelper._internal();
    }
    return _instance;
  }

  void post(dynamic event) {
    eventBus.fire(event);
  }

  StreamSubscription reg<T>(void Function(EventData<T> event) onData) =>
    eventBus.on<EventData<T>>().listen(onData);
}