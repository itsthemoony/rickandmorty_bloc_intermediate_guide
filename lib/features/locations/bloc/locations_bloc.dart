import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/repositories/locations_repository.dart';
import '../models/location.dart';
part 'locations_event.dart';
part 'locations_state.dart';

enum LocationsStatus {
  initial,
  loading,
  detailLoading,
  loaded,
  failed,
}

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final LocationsRepository repository;
  int currentPage = 1;
  LocationsBloc({required this.repository}) : super(LocationsState.initial()) {
    on<GetAllLocations>(_getAllLocations);
    on<GetMoreLocations>(_getMoreLocation);
    on<GetLocationDetails>(_getLocationDetails);
  }
  FutureOr<void> _getAllLocations(event, Emitter<LocationsState> emit) async {
    if (state.locations.isEmpty) {
      emit(state.copyWith(status: LocationsStatus.loading));
      final result = await repository.getAllLocations(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: LocationsStatus.failed));
      }, (locations) {
        emit(state.copyWith(
            status: LocationsStatus.loaded, locations: locations));
      });
    }
  }

  FutureOr<void> _getMoreLocation(event, Emitter<LocationsState> emit) async {
    currentPage++;
    if (currentPage <= 7) {
      final result = await repository.getAllLocations(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: LocationsStatus.failed));
      }, (newLocations) {
        emit(state.copyWith(
            status: LocationsStatus.loaded,
            locations: state.locations + newLocations));
      });
    }
  }

  FutureOr<void> _getLocationDetails(
      GetLocationDetails event, Emitter<LocationsState> emit) async {
    if (state.locations[event.index].residentsDetail == null) {
      emit(state.copyWith(status: LocationsStatus.detailLoading));
      final result =
          await repository.getLocationDetail(state.locations[event.index]);
      result.fold((failed) {
        emit(state.copyWith(status: LocationsStatus.failed));
      }, (location) {
        emit(state.copyWith(
            status: LocationsStatus.loaded,
            locations: state.locations..[event.index] = location));
      });
    }
  }
}
