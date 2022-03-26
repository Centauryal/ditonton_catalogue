import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies)
      : super(MovieNowPlayingEmpty()) {
    on<OnMovieNowPlayingCalled>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(MovieNowPlayingError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(MovieNowPlayingEmpty())
            : emit(MovieNowPlayingHasData(data));
      });
    });
  }
}
