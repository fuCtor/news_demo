App.cable.subscriptions.create { channel: "NewsChannel" },
  connected: ->
    console.log 'CONNECT'
  received: (data) ->
    @updateNews(data)

  updateNews: (data) ->
    $("#news .news-title").html(data.title)
    $("#news .news-annotation").html(data.annotation)
