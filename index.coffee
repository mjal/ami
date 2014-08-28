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
template = sites[default_site]

do_search = (sentence) ->
  words = sentence.split(/\s+/)
  for bang, site of alias
    index = 0
    for word in words
      console.log(word + ' => ' + bang)
      if word == ('!' + bang)
        template = sites[site]
        words.splice(index, 1)
      index++
  window.location.href = template(words.join('+'))

input = window.location.search
if input and input.match(/^\?q=/)
  query = input.substring(3).replace(/\/$/, '').replace(/\+/g, ' ')
  console.log decodeURIComponent(query)
  do_search(decodeURIComponent(query))
