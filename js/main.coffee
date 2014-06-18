$ ->

  $('#search').on 'submit', (e) ->
    searchTerm = $('#searchField').val()

    masterResponse = $.ajax(
      "http://www.omdbapi.com/?s=#{searchTerm}"
      dataType: "json"
    )

    masterResponse.done (data) ->

      movies = data.Search

      for movie in movies
        imdb = movie.imdbID
        detail = $.ajax(
            "http://www.omdbapi.com/?i=#{imdb}"
            dataType: 'json'
        )
        console.log "http://www.omdbapi.com/?i=#{imdb}"
        # console.log detail
        detail.done (movie) ->
          rating = movie.imdbRating

          console.log rating

          rating = parseFloat(movie.imdbRating)

          if rating <= 2
              $('.nope').append(movie.Title)
            else if rating <= 4
              $('.meh').append(movie.Title)
            else if rating <= 6
              $('.ok').append(movie.Title)
            else if rating <= 8
              $('.veryGood').append(movie.Title)
            else
              $('.fantastic').append(movie.Title)

            $('.detail .title').html(movie.Title)
            $('.detail .poster').html(poster)
            $('.detail .year').html(movie.Year)
            $('.detail .plot').html(movie.Plot)
            $('.detail .rating').html(movie.imdbRating)

            console.log movie.imdbRating



  $('#reset').click ->
    $('.movies').html("")
    $('.fantastic').html("")
