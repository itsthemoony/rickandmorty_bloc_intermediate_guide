import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/models/location.dart';

import '../bloc/locations_bloc.dart';

abstract class LocationsRepository {
  Future<Either<LocationsStatus, List<Location>>> getAllLocations(
      {required int pageIndex});

  Future<Either<LocationsStatus, Location>> getLocationDetail(
      Location location);
}
