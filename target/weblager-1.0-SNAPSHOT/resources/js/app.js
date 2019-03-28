var map, featureList, boroughSearch = [], theaterSearch = [], museumSearch = [];
// Set Kortforsyningen token, replace with your own token
var kftoken = 'd12107f70a3ee93153f313c7c502169a';
// Set the attribution (the copyright statement shown in the lower right corner)
// We do this as we want the same attributions for all layers
var myAttributionText = '&copy; <a target="_blank" href="https://download.kortforsyningen.dk/content/vilk%C3%A5r-og-betingelser">Styrelsen for Dataforsyning og Effektivisering</a>';

// Make custom projection using proj4 and proj4leaflet
var crs = new L.Proj.CRS('EPSG:25832',
'+proj=utm +zone=32 +ellps=GRS80 +units=m +no_defs', {
    resolutions: [1638.4,819.2,409.6,204.8,102.4,51.2,25.6,12.8,6.4,3.2,1.6,0.8,0.4,0.2]
});

var map = L.map("map", {
  crs: crs,
  center: [55.8, 11.4], // Set center location
  zoom: 11, // Set zoom level,
  zoomControl:false 
});


$(window).resize(function() {
  sizeLayerControl();
});

$(document).on("click", ".feature-row", function(e) {
  $(document).off("mouseout", ".feature-row", clearHighlight);
  sidebarClick(parseInt($(this).attr("id"), 10));
});

if ( !("ontouchstart" in window) ) {
  $(document).on("mouseover", ".feature-row", function(e) {
    highlight.clearLayers().addLayer(L.circleMarker([$(this).attr("lat"), $(this).attr("lng")], highlightStyle));
  });
}

$(document).on("mouseout", ".feature-row", clearHighlight);

$("#about-btn").click(function() {
 // $("#aboutModal").modal("show");
 // $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#full-extent-btn").click(function() {
  map.fitBounds(boroughs.getBounds());
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#legend-btn").click(function() {
  $("#legendModal").modal("show");
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#login-btn").click(function() {
  $("#loginModal").modal("show");
  $(".navbar-collapse.in").collapse("hide");
  return false;
});

$("#list-btn").click(function() {
  animateSidebar();
  return false;
});

$("#nav-btn").click(function() {
  $(".navbar-collapse").collapse("toggle");
  return false;
});

$("#sidebar-toggle-btn").click(function() {
  animateSidebar();
  return false;
});

$("#sidebar-hide-btn").click(function() {
  animateSidebar();
  return false;
});

function animateSidebar() {
  $("#sidebar").animate({
    width: "toggle"
  }, 350, function() {
    map.invalidateSize();
  });
}

function sizeLayerControl() {
  $(".leaflet-control-layers").css("max-height", $("#map").height() - 50);
}

function clearHighlight() {
  highlight.clearLayers();
}

function sidebarClick(id) {
	alert(id)
  var layer = markerClusters.getLayer(id);
  map.setView([layer.getLatLng().lat, layer.getLatLng().lng], 17);
  layer.fire("click");
  /* Hide sidebar and go to the map on small screens */
  if (document.body.clientWidth <= 767) {
    $("#sidebar").hide();
    map.invalidateSize();
  }
}

function syncSidebar() {
  /* Empty sidebar features */
  $("#feature-list tbody").empty();
}

/* Basemap Layers */
// Define layers
// Skærmkort [WMTS:topo_skaermkort]
var ortofoto = L.tileLayer.wms('https://services.kortforsyningen.dk/orto_foraar', {
    layers: 'orto_foraar',
    token: kftoken,
    format: 'image/jpeg',
    attribution: myAttributionText
});

// Skærmkort [WMTS:topo_skaermkort]
var topo = L.tileLayer.wms('https://services.kortforsyningen.dk/topo_skaermkort', {
    layers: 'dtk_skaermkort',
    token: kftoken,
    format: 'image/png',
    attribution: myAttributionText
}).addTo(map);


	
/* Overlay Layers */
// Matrikelskel overlay [WMS:mat]
var matrikel = L.tileLayer.wms('https://services.kortforsyningen.dk/mat', {
    transparent: true,
    layers: 'MatrikelSkel,Centroide',
    token: kftoken,
    format: 'image/png',
    attribution: myAttributionText,
    continuousWorld: true,
    minZoom: 9
}); // addTo means that the layer is visible by default

// Hillshade overlay [WMS:dhm]
var hillshade = L.tileLayer.wms('https://services.kortforsyningen.dk/dhm', {
    transparent: true,
    layers: 'dhm_terraen_skyggekort_transparent_overdrevet',
    token: kftoken,
    format: 'image/png',
    attribution: myAttributionText,
    continuousWorld: true,
});
/* Overlay Layers */
var highlight = L.geoJson(null);
var highlightStyle = {
  stroke: false,
  fillColor: "#00FFFF",
  fillOpacity: 0.7,
  radius: 10
};
/********************************************************/
    // Define layer groups for layer control
    var baseLayers = {
        "Ortofoto": ortofoto,
        "Skærmkort": topo
    };
    var overlays = {
        "Matrikel": matrikel,
        "Hillshade": hillshade
    };
//L.control.layers(baseLayers, overlays).addTo(map);

/* Single marker cluster layer to hold all clusters */
var markerClusters = new L.MarkerClusterGroup({
  spiderfyOnMaxZoom: true,
  showCoverageOnHover: false,
  zoomToBoundsOnClick: true,
  disableClusteringAtZoom: 16
});

/* Layer control listeners that allow for a single markerClusters layer */
map.on("overlayadd", function(e) {

});

map.on("overlayremove", function(e) {
  
});

/* Filter sidebar feature list to only show features in current map bounds */
map.on("moveend", function (e) {
  syncSidebar();
});

/* Clear feature highlight when map is clicked */
map.on("click", function(e) {
  highlight.clearLayers();
});

/* Attribution control */
function updateAttribution(e) {
  $.each(map._layers, function(index, layer) {
    if (layer.getAttribution) {
      $("#attribution").html((layer.getAttribution()));
    }
  });
}
map.on("layeradd", updateAttribution);
map.on("layerremove", updateAttribution);

var attributionControl = L.control({
  position: "bottomright"
});
attributionControl.onAdd = function (map) {
  var div = L.DomUtil.create("div", "leaflet-control-attribution");
  div.innerHTML = "<span class='hidden-xs'>Developed by <a href='mailto:nabati.reza@gmail.com'>nabati.reza@gmail.com</a> | </span><a href='#' onclick='$(\"#attributionModal\").modal(\"show\"); return false;'>Attribution</a>";
  return div;
};
map.addControl(attributionControl);

var zoomControl = L.control.zoom({
  position: "bottomright"
}).addTo(map);

/* GPS enabled geolocation control set to follow the user's location */
var locateControl = L.control.locate({
  position: "bottomright",
  drawCircle: true,
  follow: true,
  setView: true,
  keepCurrentZoomLevel: true,
  markerStyle: {
    weight: 1,
    opacity: 0.8,
    fillOpacity: 0.8
  },
  circleStyle: {
    weight: 1,
    clickable: false
  },
  icon: "fa fa-location-arrow",
  metric: false,
  strings: {
    title: "My location",
    popup: "You are within {distance} {unit} from this point",
    outsideMapBoundsMsg: "You seem located outside the boundaries of the map"
  },
  locateOptions: {
    maxZoom: 18,
    watch: true,
    enableHighAccuracy: true,
    maximumAge: 10000,
    timeout: 10000
  }
}).addTo(map);

/* Larger screens get expanded layer control and visible sidebar */
if (document.body.clientWidth <= 767) {
  var isCollapsed = true;
} else {
  var isCollapsed = false;
}


var groupedOverlays = {
  "Reference": {
        "Matrikel": matrikel,
        "Hillshade": hillshade
  }
};

var layerControl = L.control.groupedLayers(baseLayers, groupedOverlays, {
  collapsed: false
}).addTo(map);


/* Highlight search box text on click */
$("#searchbox").click(function () {
  $(this).select();
});

/* Prevent hitting enter from refreshing the page */
$("#searchbox").keypress(function (e) {
  if (e.which == 13) {
    e.preventDefault();
  }
});

$("#featureModal").on("hidden.bs.modal", function (e) {
  $(document).on("mouseout", ".feature-row", clearHighlight);
});

$( window ).load(function () {
   $("#loading").hide();
});
/* Typeahead search functionality */
$(document).one("ajaxStop", function () {
	alert('stop')
  $("#loading").hide();
  sizeLayerControl();
  /* Fit map to boroughs bounds */
  map.fitBounds(boroughs.getBounds());
});

// Leaflet patch to make layer control scrollable on touch browsers
var container = $(".leaflet-control-layers")[0];
if (!L.Browser.touch) {
  L.DomEvent
  .disableClickPropagation(container)
  .disableScrollPropagation(container);
} else {
  L.DomEvent.disableClickPropagation(container);
}
