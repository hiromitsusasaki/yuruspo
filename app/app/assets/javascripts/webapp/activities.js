// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var autocomplete;

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('place_address')), {
      type: ['geocode']
    }
  )
  autocomplete.addListener('place_changed', setPlaceInfo);
}

function setPlaceInfo() {
  var place = autocomplete.getPlace();
  console.log(place)
  var name = place.name
  var phone_number = place.formatted_phone_number;
  var address = place.formatted_address;
  var prefecture_name = "";
  var city_name = "";
  var area_name = "";
  place.address_components.forEach(function (val, index) {
    switch (val.types[0]) {
      case "administrative_area_level_1":
        prefecture_name = val.long_name;
        break;
      case "locality":
        city_name = val.long_name;
        break;
      case "sublocality_level_1":
        area_name = val.long_name;
    }
  });
  document.getElementById('place_name').setAttribute('value', name);
  document.getElementById('place_tel').setAttribute('value', phone_number);
  document.getElementById('place_address').setAttribute('value', address);
  document.getElementById('prefecture_name').setAttribute('value', prefecture_name);
  document.getElementById('city_name').setAttribute('value', city_name + area_name);
}

function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
    })
  }
}

$(function () {
  $('#btn-add-activity').click(function () {
    $('form#form-add-activity').submit();
  });
  $('#btn-edit-activity').click(function () {
    $('form#form-edit-activity').submit();
  });
  $('#btn-delete-activity').click(function () {
    $('form#form-delete-activity').submit();
  });
});