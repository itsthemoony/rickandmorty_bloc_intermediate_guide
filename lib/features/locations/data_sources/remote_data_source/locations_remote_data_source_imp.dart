import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/data_sources/remote_data_source/locations_remote_data_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/models/location.dart';
import '../../../../constants/urls/rm_urls.dart';
import '../../bloc/locations_bloc.dart';



class LocationsRemoteDataSourceImp extends LocationsRemoteDataSource {
  final Dio dio;

  LocationsRemoteDataSourceImp({required this.dio});
  @override
  Future<Either<LocationsStatus, List<Location>>> getAllLocations(
      int pageIndex) async {
    try {
      final response = await dio
          .get(RMUrls.constructUrl(feature: 'location', pageIndex: pageIndex));

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['results'];
        final locations =
            data.map((location) => Location.fromJson(location)).toList();
        return Right(locations);
      }
      return const Left(LocationsStatus.failed);
    } on Exception catch (_) {
      return const Left(LocationsStatus.failed);
    }
  }

  @override
  Future<Either<LocationsStatus, Location>> getLocationDetail(
      {required Location location}) async {
    try {
      List<Character> residents = [];
      for (String url in location.residents) {
        final response = await dio.get(url);
        if (response.statusCode == HttpStatus.ok) {
          residents.add(Character.fromJson(response.data));
        }
      }
      final updatedLocation = location.copyWith(residentsDetail: residents);
      return Right(updatedLocation);
    } on Exception catch (_) {
      return const Left(LocationsStatus.failed);
    }
  }
}
