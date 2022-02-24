class Movie {
  static List<Movie> getMovies() => [
    Movie(
      title: title,
      stringyear: stringyear,
      stringRated: stringRated, 
      released: released,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot, 
      language: language,
      country: country,
      awards: awards,
      poster: poster,
      metascore: metascore,
      imdbRating: imdbRating,
      imdbVotes: imdbVotes,
      imdbID: imdbID,
      type: type,
      response: response,
      images: image)
  ];
  String title;
  String stringyear;
  String stringRated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbRating;
  String imdbVotes;
  String imdbID;
  String type;
  String response;
  List<String> images;
  Movie({
    required this.title,
    required this.stringyear,
    required this.stringRated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.response,
    required this.images,
  });
  }

  