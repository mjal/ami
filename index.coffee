sites =
  "google":        (query) -> "https://www.google.fr/search?q=#{query}"
  "google.com":    (query) -> "https://www.google.com/search?q=#{query}"
  "wikipedia":     (query) -> "http://fr.wikipedia.org/w/index.php?search=#{query}"
  "wikipedia.com": (query) -> "http://www.wikipedia.org/w/index.php?search=#{query}"
  "youtube":       (query) -> "https://www.youtube.com/results?search_query=#{query}"
  "duckduckgo":    (query) -> "https://duckduckgo.com/?q=#{query}"
  "soundcloud":    (query) -> "https://soundcloud.com/search?q=#{query}"
  "deezer":        (query) -> "http://deezer.com/fr/search/#{query}"
  "thepiratebay":  (query) -> "http://thepiratebay.cr/search/#{query}/0/7/0"

encodings =
  "google":        (words) -> words.join("+")
  "google.com":    (words) -> words.join("+")
  "wikipedia":     (words) -> words.join("+")
  "wikipedia.com": (words) -> words.join("+")
  "youtube":       (words) -> words.join("+")
  "duckduckgo":    (words) -> words.join("+")
  "soundcloud":    (words) -> words.join("+")
  "deezer":        (words) -> words.join("+")
  "thepiratebay":  (words) -> words.join(" ")

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
  "dz":   "deezer"
  "tpb":  "thepiratebay"

default_site = "google"
template = sites[default_site]
encoding = encodings[default_site]

do_search = (sentence) ->
  words = sentence.split(/\s+/)
  index = 0
  for word in words
    for bang, site of alias
      if word == ('!' + bang) or word == ('!' + site)
        template = sites[site]
        encoding = encodings[site]
        words.splice(index, 1)
    index++

  window.location.href = template(encoding(words))

input = window.location.search
if input and input.match(/^\?q=/)
  query = input.substring(3).replace(/\/$/, '').replace(/\+/g, ' ')
  console.log decodeURIComponent(query)
  do_search(decodeURIComponent(query))

for site, f of sites
  button = document.createElement('button')
  button.appendChild(document.createTextNode(site))
  ((site) ->
    button.addEventListener "click", ->
      document.querySelector("#query input").value += " !" + site
      document.querySelector("#submit").click()
  )(site)
  document.querySelector('#bangs').appendChild(button)

for bang, site of alias
  p = document.createElement('p')
  p.appendChild(document.createTextNode("!"+bang))
  p.className = "alias"
  document.querySelector('#alias').appendChild(p)

document.querySelector("#query input").value = ""
