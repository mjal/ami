$ ->
  default_site = "ddg"

  sites =
    "g": (query) -> "https://www.google.fr/search?q=#{query}"
    "w": (query) -> "http://fr.wikipedia.org/w/index.php?search=#{query}"
    "yt": (query) -> "https://www.youtube.com/results?search_query=#{query}"
    "ddg": (query) -> "https://duckduckgo.com/?q=#{query}"

  console.log("sites")
  console.log(sites)

  search = (input) ->
    parts = input.split(/\ +/)
    console.log "parts"
    console.log parts

    for part, i in parts
      continue unless part.charAt(0) is "!"
      bang = part.substring(1)
      continue unless sites[bang]

      parts.splice(i, 1)
      console.log sites[bang](parts.join("+"))
      window.location.href = sites[bang](parts.join("+")) # X: encode better
      return

    console.log sites[default_site](parts.join("+"))
    window.location.href = sites[default_site](parts.join("+")) # X: encode better

  # handle get params
  input = window.location.search
  if input and input.charAt(0) is "?" and input.charAt(1) is "q" and input.charAt(2) is "="
    search input.substring(3).replace(/\+/g, " ")

  # Events
  $("#search_button").click ->
    search $("#search_input").val()
  $("#search_input").keypress (e) ->
    search $("#search_input").val()  if e.keyCode is 13
