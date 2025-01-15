import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model.dart';
import 'package:complete_advanced_flutter/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.success) //success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return bussines logic error
          // return left

          return Left(Failure(response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
