$ ->
  # Data
  default_site = "google"
  sites =
    "google": (query) -> "https://www.google.fr/search?q=#{query}"
    "wikipedia": (query) -> "http://fr.wikipedia.org/w/index.php?search=#{query}"
    "youtube": (query) -> "https://www.youtube.com/results?search_query=#{query}"
    "duckduckgo": (query) -> "https://duckduckgo.com/?q=#{query}"
    "soundcloud": (query) -> "https://soundcloud.com/search?q=#{query}"
  alias =
    "g": "google"
    "ddg": "duckduckgo"
    "w": "wikipedia"
    "yt": "youtube"
    "sc": "soundcloud"

  # Debug
  console.log("sites")
  console.log(sites)
  console.log("alias")
  console.log(alias)

  # Routing function
  route = (input) ->
    parts = input.split(/\ +/)
    console.log "parts"
    console.log parts

    for part, i in parts
      continue unless part.charAt(0) is "!"
      bang = part.substring(1)
      continue unless sites[bang] or alias[bang]

      template = sites[bang]
      template or= sites[alias[bang]]

      parts.splice(i, 1)
      window.location.href = template(parts.join("+")) # X: encode better
      return

    template = sites[default_site]
    window.location.href = template(parts.join("+")) # X: encode better

  class Search extends Spine.Controller
    constructor: ->
      super
      @html $("#tpl_main").html()
      @$("#search_input").focus()

    events:
      "keypress #search_input": "keypress"
      "click #search_button": "search"
      "click #options_button": "show_options"

    keypress: (e) -> route(@$("#search_input").val()) if e.keyCode is 13

    search: -> route(@$("#search_input").val())

    show_options: ->
      $("#options").show() # Option.send ...

  class Options extends Spine.Controller
    template: _.template($("#tpl_options").html())
    constructor: ->
      super
      @html @template(sites: sites, default_site: default_site)

  # If we got search as get params...
  input = window.location.search
  if input and input.charAt(0) is "?" and input.charAt(1) is "q" and input.charAt(2) is "="
    # Handle search
    route(input.substring(3).replace(/\+/g, " ").replace(/\/$/, ""))
  else
    # Show UI
    new Search(el: $("#main"))
    new Options(el: $("#options"))

  #new Search(el: $("#search"))
