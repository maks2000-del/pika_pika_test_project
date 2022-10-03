part of 'detailed_info_bloc.dart';

abstract class DetailedInfoEvent {}

class PockemonPicked extends DetailedInfoEvent {
  final String id;

  PockemonPicked(this.id);
}

class DetailedInfoConnectionChecked extends DetailedInfoEvent {}
