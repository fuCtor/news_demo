App.cable.subscriptions.create { channel: "NewsChannel" },
  received: (data) ->
    @updateNews(data)

  updateNews: (data) ->
    $("#news").data('until', data.date)
    $("#news .news-title").html(data.title)
    $("#news .news-annotation").html(data.annotation)
