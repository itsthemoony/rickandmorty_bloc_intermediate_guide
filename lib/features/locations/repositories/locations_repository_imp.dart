import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/repositories/locations_repository.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart';

import '../bloc/locations_bloc.dart';
import '../data_sources/remote_data_source/locations_remote_data_source.dart';
import '../models/location.dart';

class LocationsRepositoryImp extends LocationsRepository {
  final LocationsRemoteDataSource remoteDataSource =
      sl.get<LocationsRemoteDataSource>();

  @override
  Future<Either<LocationsStatus, List<Location>>> getAllLocations(
      {required int pageIndex}) async {
    return await remoteDataSource.getAllLocations(pageIndex);
  }

  @override
  Future<Either<LocationsStatus, Location>> getLocationDetail(
      Location location) async {
    return await remoteDataSource.getLocationDetail(location: location);
  }
}
