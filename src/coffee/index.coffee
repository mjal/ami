default_template = config[0].pattern

bangs = {}
for entry in config
  for bang in entry.bangs
    bangs[bang] = entry

get_query = ->
  input = window.location.search
  if input && input.match(/^\?q=/)
    query = input.substring(3).replace(/\/$/, '').replace(/\+/g, ' ')
    decodeURIComponent(query)
  else
    undefined

search = (sentence, bangs, default_template) ->
  template = default_template

  words = sentence.split(/\s+/)
  index = 0
  for word in words
    if word.substring(0, 1) is '!' and bangs[word.substring(1)]
      words.splice(index, 1)
      template = bangs[word.substring(1)].pattern
    index++
  url = MicroMustache.render(template, { query: words.join('+') })
  window.location.href = url

query = get_query()
search(query, bangs, default_template) if query
