# url_shortener

This is a URL shortening web app written in Rails 4.2

<https://url-to-short.herokuapp.com/>

The web service end point is <https://url-to-short.herokuapp.com/urls/url_shortener_api>

and can be used using CURL commands.

e.g.
curl -H "Content-Type: application/json" -X POST https://url-to-short.herokuapp.com/urls/url_shortener_api -d '{"url":"www.microsoft.com"}'
will create a short url version of 'www.microsoft.com'.

if that command contains a short url already in the database, it will respond with the corresponding long_url version.
