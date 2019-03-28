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

$('#custom-layer-switcher').prepend(layerControl.getContainer());

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
  $("#loading").hide();
  sizeLayerControl();
  /* Fit map to boroughs bounds */
 // map.fitBounds(boroughs.getBounds());
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

            L.control.custom({
                position: 'topright',
                content : '<button title="Sign out" type="button" class="btn btn-default" onclick="logoutForm.submit()">'+
                          '    <i class="fa  fa-sign-out"></i>'+
                          '</button>'+
                          '<button type="button" class="btn btn-primary">'+
                          '    <i class="fa fa-spinner fa-pulse fa-fw"></i>'+
                          '</button>',
                classes : 'btn-group-vertical btn-group-sm',
                style   :
                {
                    margin: '10px',
                    padding: '0px 0 0 0',
                    cursor: 'pointer'
                },
                datas   :
                {
                    'foo': 'bar',
                },
                events:
                {
                    click: function(data)
                    {
                        console.log('wrapper div element clicked');
                        console.log(data);
                    },
                    dblclick: function(data)
                    {
                        console.log('wrapper div element dblclicked');
                        console.log(data);
                    },
                    contextmenu: function(data)
                    {
                        console.log('wrapper div element contextmenu');
                        console.log(data);
                    },
                }
            })
            .addTo(map);

            L.control.custom({
                position: 'topleft',
                content : '<div class="input-group">'+
                          '    <input type="text" class="form-control input-sm search-item" id="leaflet-searchbox" style="width:250px" placeholder="Search">'+
                          '    <span class="input-group-btn">'+
                          '        <button class="btn btn-default btn-sm" type="button">Go!</button>'+
                          '    </span>'+
                          '</div>',
                classes : '',
                style   :
                {
                    position: 'absolute',
                    left: '50px',
                    top: '0px',
                    width: '200px',
                },
            })
            .addTo(map);

var sidebar = L.control.sidebar('sidebar').addTo(map);


var gsFeatures = []; // This is the array to hold the GeoSearch feeatures

// Function to clear the map from GeoSearch features
var clearMap = function() {
    for (var i in gsFeatures) {
        if (gsFeatures.hasOwnProperty(i)) {
            map.removeLayer(gsFeatures[i]);
        }
    }
    gsFeatures.length = 0;
}

// Make a typeahead of the input search field using Bootstrap 3 Typeahead
$('input#leaflet-searchbox').typeahead({
    displayText:  function (item){
        a= '<i class="fa fa-'+(item.type==='streetNameType'?'road':(item.type==='addressAccessType'?'map-marker':''))+'"></i><span style="margin-left:5px;" data-query="'+item.presentationString+'">'+ item.presentationString+'</span>'; // this is the attribute of the JSON response to show in the dropdown
        return item.presentationString;
    },
    items:'all',
    showHintOnFocus:true,
    changeInputOnSelect:true,
    changeInputOnMove:true,
    showCategoryHeader:true,
    scrollHeight:0,
    hint: true,
    highlight: true,
    source:  function (query, process) {
        return $.get("https://services.kortforsyningen.dk/Geosearch", { 
            search: query,
            resources: "adresser", // the resource to search within - check valid resources on https://kortforsyningen.dk/indhold/geonoegler-geosearch 
            token: kftoken,
            crs: 'EPSG:4326',
            limit:30
        }, 
        function (response) { // This method is being called when data was received from GeoSearch
            if(response.data) {
                return process(response.data);
            }
        });
    },
    afterSelect: function(item) { 
    	//$('input#leaflet-searchbox').val(item.presentationString);
        // when an item in the dropdown was selected try to show the geometry of the item
        if(item.geometryWkt) {
            clearMap(); // remove any previous geometries from map
            var wkt = new Wkt.Wkt(); // make a new instance of the Wicket class
            wkt.read(item.geometryWkt); // read WKT from GeoSearch
            var obj = wkt.toObject(map.defaults); // Make a Leaflet object
            
            // Add to map, distinguish multigeometries (Arrays) from objects
            if (Wkt.isArray(obj)) {
                for (i in obj) {
                    if (obj.hasOwnProperty(i) && !Wkt.isArray(obj[i])) {
                        obj[i].addTo(map);
                        gsFeatures.push(obj[i]);
                    }
                }
            } else {
                obj.addTo(map);
                gsFeatures.push(obj);
            }

            // Pan the map to the feature, distinguish between points and other geometries
            if (obj.getBounds !== undefined && typeof obj.getBounds === 'function') {
                map.fitBounds(obj.getBounds());
            } else {
                if (obj.getLatLng !== undefined && typeof obj.getLatLng === 'function') {
                    map.panTo(obj.getLatLng());
                }
            }
        }
    }
});

/*
var demo_with_map = new autoComplete({
    selector: '#leaflet-searchbox',
    minChars: 2,
    source: function(term, response) {
      fetch('https://services.kortforsyningen.dk/Geosearch?resources=adresser&token='+kftoken+'&crs=EPSG%3A4326&limit=20&search=' + term)
        .then(function(response) {
          return response.text();
        }).then(function(body) {
          var json = JSON.parse(body);
          var new_json = json.map(function(el) {
            return {
              label: el.presentationString,
              value: el.postCodeIdentifier,
              lat: el.y,
              lon: el.x,
              boundingbox: [el.xMin,el.yMin,el.xMax,el.yMax],
              type: el.streetNameType
            }
          })
          response(new_json);
        });
    },
    renderItem: function(item, search) {
      search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
      var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
      var optional_bbox_attribute = '';
      if (item.boundingbox) {
        var bbox = [item.boundingbox[2], item.boundingbox[0], item.boundingbox[3], item.boundingbox[1]];
        var optional_bbox_attribute = 'data-bbox="' + bbox.join(',') + '" ';
      }
      return '<div class="autocomplete-suggestion" ' + optional_bbox_attribute +
        'data-lon="' + item.lon + '" data-lat="' + item.lat +
        '" data-val="' + item.label + '">' +
        item.label.replace(re, "<b>$1</b>") +
        '</div>';
    },
    onSelect: function(e, term, item) {
      if (item.getAttribute('data-bbox') && (item.getAttribute('data-bbox').split(',')).length > 0) {
        var extent = item.getAttribute('data-bbox').split(',');
        if (extent.length > 0) {
          extent = extent.map(function(el) {
            return Number(el);
          });
        }
        var bounds = [[extent[1], extent[0]], [extent[3], extent[2]]];

        // zoom the map to the bounds
        map.fitBounds(bounds);
      } else {
        var lat = Number(item.getAttribute('data-lat'));
        var lon = Number(item.getAttribute('data-lon'));
        map.setView(L.latLng(lat, lon), 12);
      }
    }
  });
*/