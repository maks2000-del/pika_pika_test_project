part of 'detailed_info_bloc.dart';

abstract class DetailedInfoEvent {}

class PockemonPicked extends DetailedInfoEvent {
  PockemonPicked(this.id);

  final String id;
}
