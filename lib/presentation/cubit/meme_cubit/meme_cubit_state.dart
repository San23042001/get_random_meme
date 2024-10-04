part of 'meme_cubit_cubit.dart';

sealed class MemeCubitState extends Equatable {
  const MemeCubitState();

  @override
  List<Object> get props => [];
}

final class MemeCubitInitial extends MemeCubitState {}

class MemeCubitLoading extends MemeCubitState {
  @override
  List<Object> get props => [];
}

class MemeCubitSuccess extends MemeCubitState {
  final Meme meme;
  const MemeCubitSuccess(this.meme);
  @override
  List<Object> get props => [meme];
}

class MemeCubitError extends MemeCubitState {
  final AppError error;
  const MemeCubitError({required this.error});
  @override
  List<Object> get props => [error];
}
