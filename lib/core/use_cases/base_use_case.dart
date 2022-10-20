import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/failure.dart';

// ignore: one_member_abstracts
abstract class BaseUseCase<TOutput, TInput> {
  Future<Either<Failure, TOutput>> call(TInput params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
