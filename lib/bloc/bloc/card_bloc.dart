import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pairit/models/card_base.dart';
import 'package:pairit/entity/card_element_key.dart';

import '../../card_element.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../event/card_event.dart';
part '../state/card_states.dart';


class EditCardBloc extends Bloc<CardEditEvent, CardEditState> {
  ElementKey _elementKey;
  static const int _duration = 60;

  StreamSubscription<int> _editorSubscription;

  EditCardBloc({@required ElementKey elementKey})
      : assert(elementKey != null),
        _elementKey = elementKey,
        super(EditInitial(elementKey));

  //EditCardBloc({@required Ticker ticker});

  @override
  void onTransition(Transition<CardEditEvent, CardEditState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<CardEditState> mapEventToState(CardEditEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

/*  @override
  Stream<CardEditState> mapEventToState(
      CardEditEvent event,
      ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    }
  }

  @override
  Future<void> close() {
    _editorSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunInProgress(start.duration);
    _editorSubscription?.cancel();
    _editorSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _editorSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _editorSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _editorSubscription?.cancel();
    yield TimerInitial(_duration);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgress(tick.duration)
        : TimerRunComplete();
  }*/
}