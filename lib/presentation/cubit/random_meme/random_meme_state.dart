part of 'random_meme_cubit.dart';

sealed class RandomMemeState extends Equatable {
  const RandomMemeState();

  @override
  List<Object> get props => [];
}

final class RandomMemeInitial extends RandomMemeState {}

class RandomMemeLoading extends RandomMemeState {
  @override
  List<Object> get props => [];
}

class RandomMemeLoaded extends RandomMemeState {
  final RandomMeme meme;

  const RandomMemeLoaded(this.meme);
  @override
  List<Object> get props => [meme];
}

class RandomMemeError extends RandomMemeState {
  final AppError error;

  const RandomMemeError(this.error);
  @override
  List<Object> get props => [error];
}
