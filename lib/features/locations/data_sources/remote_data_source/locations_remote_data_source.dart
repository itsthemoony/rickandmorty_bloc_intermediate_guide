import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/models/location.dart';
import '../../bloc/locations_bloc.dart';

abstract class LocationsRemoteDataSource {
  Future<Either<LocationsStatus, List<Location>>> getAllLocations(
      int pageIndex);

  Future<Either<LocationsStatus, Location>> getLocationDetail(
      {required Location location});
}
