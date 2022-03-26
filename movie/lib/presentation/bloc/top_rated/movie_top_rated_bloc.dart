import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<MovieTopRatedEvent>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold((failure) {
        emit(MovieTopRatedError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(MovieTopRatedEmpty())
            : emit(MovieTopRatedHasData(data));
      });
    });
  }
}
