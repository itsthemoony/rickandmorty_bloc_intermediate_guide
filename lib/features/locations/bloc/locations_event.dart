part of 'locations_bloc.dart';

sealed class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class GetAllLocations extends LocationsEvent {}

class GetMoreLocations extends LocationsEvent {}

class GetLocationDetails extends LocationsEvent {
  final int index;
  const GetLocationDetails({required this.index});
}
