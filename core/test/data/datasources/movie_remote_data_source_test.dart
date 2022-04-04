import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie/movie_detail_model.dart';
import 'package:core/data/models/movie/movie_response.dart';
import 'package:core/data/models/tvshow/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = MovieRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('get Now Playing Movies and get On The Air TV Series', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/on_air_tv_show.json')))
        .tvShowList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test('should return list of TV Show Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_air_tv_show.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTvShows();
      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code movie is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
        'should throw a ServerException when the response code tvshow is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv_show.json')))
        .tvShowList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should return list of tvshows when response is success (200)',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv_show.json'), 200));
      // act
      final result = await dataSource.getPopularTvShows();
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw a ServerException when the response code movie is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
        'should throw a ServerException when the response code tvshow is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movie', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw ServerException when response code movie is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TvShow', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_show.json')))
        .tvShowList;

    test('should return list of tvshow when response code is 200 ', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tv_show.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTopRatedTvShows();
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw ServerException when response code tvshow is other than 200',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;

    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_recommendation.json')))
        .tvShowList;

    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should return list of Tvshow Model when the response code is 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_show_recommendation.json'), 200));
      // act
      final result = await dataSource.getTvShowRecommendations(tId);
      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw Server Exception when the response code movie is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
        'should throw Server Exception when the response code tvshow is 404 or other',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search item', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    final tSearchTvShowResult = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/search_tv_show.json')))
        .tvShowList;
    const tQuery = 'Spiderman';
    const tQueryTvShow = 'Pasión de gavilanes';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should return list of tvshow when response code is 200', () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQueryTvShow')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search_tv_show.json'), 200));
      // act
      final result = await dataSource.searchTvShows(tQueryTvShow);
      // assert
      expect(result, tSearchTvShowResult);
    });

    test(
        'should throw ServerException when response code movie is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
        'should throw ServerException when response code tvshow is other than 200',
        () async {
      // arrange
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQueryTvShow')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShows(tQueryTvShow);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
