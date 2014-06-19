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

default_site = "duckduckgo"
default_template = sites[default_site]

do_search = (query) ->
  template = default_template
  request = query.match(/^(.*)?\!(\w+)( .*)?/)
  if request
    bang = request[2]
    query = request[1]
    query += request[3] if request[3]
    if bang and sites[bang] then template = sites[bang]
    if bang and alias[bang] then template = sites[alias[bang]]
  window.location.href = template(query.replace(/\s+/g, ' '))

input = window.location.search
if input and input.match(/^\?q=/)
  search = decodeURIComponent(input.substring(3).replace(/\/$/, ""))
  do_search(search)

###
else
  $ ->
    # build ui
    class Search extends Spine.Controller
      constructor: ->
        super
        @html $("#tpl_main").html()
        @$("#search_input").focus()

      events:
        "keypress #search_input": "keypress"
        "click #search_button": "search"
        "click #options_button": "show_options"

      keypress: (e) => @search() if e.keyCode is 13

      search: -> do_search(@$("#search_input").val())

      show_options: ->
        $("#options").show() # Option.send ...

    class Options extends Spine.Controller
      template: _.template($("#tpl_options").html())
      constructor: ->
        super
        @html @template(sites: sites, default_site: default_site)

    new Search(el: $("#main"))
    new Options(el: $("#options"))
###
