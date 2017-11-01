$(document).on "turbolinks:load", ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (geoData) ->
      $.getJSON("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{geoData.coords.latitude},#{geoData.coords.longitude}").done (json) -> 
        components = json["results"][0]["address_components"]
        city = (item["short_name"] for item in components when item["types"][0] is "locality")
        state = (item["short_name"] for item in components when item["types"][0] is "administrative_area_level_1")
        country = (item["short_name"] for item in components when item["types"][0] is "country")
        $("#location").text("#{city}, #{state}, #{country}")
  else
    $("#location").text("Columbus, OH")
