part of 'locations_bloc.dart';

class LocationsState extends Equatable {
  final LocationsStatus status;
  final List<Location> locations;

  const LocationsState({required this.status, required this.locations});

  LocationsState copyWith({
    LocationsStatus? status,
    List<Location>? locations,
  }) {
    return LocationsState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object> get props => [status, locations];

  factory LocationsState.initial() {
    return const LocationsState(
      status: LocationsStatus.initial,
      locations: [],
    );
  }
}
