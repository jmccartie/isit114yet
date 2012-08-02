$ ->
  $.get "/temp.json", (data) ->
    window.data = data

    $("#loading").hide()
    $("#header").show()
    $(".current-temp").html data.current_temp
    $("#updated-at").html("Updated at: #{data.updated_at}").show()

    if data.is_it_114?
      $(".record-set-at").html data.record_set_at
      $("#record-set").show()
    else
      $("#record-not-set").show()