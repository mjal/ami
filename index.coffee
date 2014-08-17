sites =
  "google":        (query) -> "https://www.google.fr/search?q=#{query}"
  "google.com":    (query) -> "https://www.google.com/search?q=#{query}"
  "wikipedia":     (query) -> "http://fr.wikipedia.org/w/index.php?search=#{query}"
  "wikipedia.com": (query) -> "http://www.wikipedia.org/w/index.php?search=#{query}"
  "youtube":       (query) -> "https://www.youtube.com/results?search_query=#{query}"
  "duckduckgo":    (query) -> "https://duckduckgo.com/?q=#{query}"
  "soundcloud":    (query) -> "https://soundcloud.com/search?q=#{query}"

alias =
  "g":    "google"
  "gfr":  "google"
  "gus":  "google.com"
  "w":    "wikipedia"
  "wfr":  "wikipedia"
  "wus":  "wikipedia.com"
  "ddg":  "duckduckgo"
  "sc":   "soundcloud"
  "yt":   "youtube"

default_site = "google"
default_template = sites[default_site]

do_search = (query) ->
  template = default_template
  request = query.match(/^(.*)?\!(\w+)( .*)?/) # what?
  if request
    bang = request[2]
    query = request[1]
    query += request[3] if request[3]
    if bang and sites[bang] then template = sites[bang]
    if bang and alias[bang] then template = sites[alias[bang]]
  query = query.replace(/^\ /, '').replace(/\ +$/, '').replace(/\s+/g, ' ') # what
  window.location.href = template(query)

input = window.location.search
if input and input.match(/^\?q=/)
  search = decodeURIComponent(input.substring(3).replace(/\/$/, ''))
  do_search(search)
# else build ui ?
