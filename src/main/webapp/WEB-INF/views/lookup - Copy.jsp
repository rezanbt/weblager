<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="theme-color" content="#000000">
<meta name="description" content="">
<meta name="author" content="">
<title>Weblager Administration</title>

<!-- <link rel="stylesheet"
	href="resources/assets/bootstrap/bootstrap.min.css"> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.Default.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-locatecontrol/L.Control.Locate.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-mouseposition/l.control.mouseposition.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-control-sidebar/leaflet-sidebar.css">	
<link rel="stylesheet"
	href="resources/css/app1.css">

<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/favicon-76.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="resources/img/favicon-120.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="resources/img/favicon-152.png">
<link rel="icon" sizes="196x196" href="resources/img/favicon-196.png">
<link rel="icon" type="image/x-icon" href="resources/img/favicon.ico">

    <style>
        body {
            padding: 0;
            margin: 0;
        }

        html, body, #map {
            height: 100%;
            font: 10pt "Helvetica Neue", Arial, Helvetica, sans-serif;
        }

        .lorem {
            font-style: italic;
            color: #AAA;
        }
    </style>
</head>

<body>

 <div id="sidebar" class="sidebar collapsed">
        <!-- Nav tabs -->
        <div class="sidebar-tabs">
            <ul role="tablist">
                <li><a href="#home" role="tab"><i class="fa fa-bars"></i></a></li>
                <li><a href="#profile" role="tab"><i class="fa fa-user"></i></a></li>
                <li class="disabled"><a href="#messages" role="tab"><i class="fa fa-envelope"></i></a></li>
                <li><a href="https://github.com/Turbo87/sidebar-v2" role="tab" target="_blank"><i class="fa fa-github"></i></a></li>
            </ul>

            <ul role="tablist">
                <li><a href="#settings" role="tab"><i class="fa fa-gear"></i></a></li>
            </ul>
        </div>

        <!-- Tab panes -->
        <div class="sidebar-content">
            <div class="sidebar-pane" id="home">
                <h1 class="sidebar-header">
                    sidebar-v2
                    <span class="sidebar-close"><i class="fa fa-caret-left"></i></span>
                </h1>

                <p>A responsive sidebar for mapping libraries like <a href="http://leafletjs.com/">Leaflet</a> or <a href="http://openlayers.org/">OpenLayers</a>.</p>

                <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

                <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

                <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

                <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
            </div>

            <div class="sidebar-pane" id="profile">
                <h1 class="sidebar-header">Profile<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
            </div>

            <div class="sidebar-pane" id="messages">
                <h1 class="sidebar-header">Messages<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
            </div>

            <div class="sidebar-pane" id="settings">
                <h1 class="sidebar-header">Settings<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
            </div>
        </div>
    </div>

    <div id="map" class="sidebar-map"></div>

	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>
	<script src="resources/assets/bootstrap/bootstrap.min.js"></script>
    <script src="resources/assets/typeahead/typeahead.bundle.min.js"></script>
	<script src="resources/assets/handlebars/handlebars.min.js"></script>
	<script src="resources/assets/listjs/list.min.js"></script>
	<script src="resources/assets/proj4s/proj4-src.js"></script>
	<script src="resources/assets/leaflet/leaflet-proj4leaflet/proj4leaflet.min.js"></script>
	<script src="resources/assets/leaflet/leaflet-markercluster/leaflet.markercluster.js"></script>
	<script src="resources/assets/leaflet/leaflet-locatecontrol/L.Control.Locate.js"></script>
    <script src="resources/assets/leaflet/leaflet-mouseposition/l.control.mouseposition.js"></script>
	<script src="resources/assets/leaflet/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.js"></script>
	<script src="resources/assets/leaflet/leaflet-control-custom/leaflet.control.custom.js"></script> 
	<script src="resources/assets/leaflet/leaflet-control-sidebar/leaflet-sidebar.js"></script>
	<!-- <script src="resources/js/app.js"></script> -->
	  <script>
        var map = L.map('map');
        map.setView([51.2, 7], 9);

        L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18,
            attribution: 'Map data &copy; OpenStreetMap contributors'
        }).addTo(map);

     
        var sidebar = L.control.sidebar('sidebar').addTo(map);
    </script>
</body>
</html>
