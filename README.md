# [Elm Berlin Code Night](https://www.meetup.com/Elm-Berlin/)

## Building the slides

`elm make Main.elm --output assets/elm.js --optimize`

## Running the slides

Because these slides rely on a single page navigation, they have to be served from a web server.

A simple way is to `python -m SimpleHTTPServer` and open [http://localhost:8000](http://localhost:8000).