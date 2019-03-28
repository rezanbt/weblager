<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
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
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css" />
    <!--[if lte IE 8]><link rel="stylesheet" href="//cdn.leafletjs.com/leaflet-0.7.2/leaflet.ie.css" /><![endif]-->
    <link rel="stylesheet" href="resources/assets/leaflet/leaflet-control-sidebar/leaflet-sidebar.css" />
    <link rel="stylesheet"
	href="resources/assets/bootstrap/bootstrap.min.css"/> 
<link rel="stylesheet"
	href="resources/assets/leaflet/base/leaflet.css"/>
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.css"/>
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.Default.css"/>
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-locatecontrol/L.Control.Locate.css"/>
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-mouseposition/l.control.mouseposition.css"/>
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.css" />
<link rel="stylesheet"
	href="resources/assets/autocomplete/auto-complete.css" />


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
    	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    
</head>
<body>
  <c:if test="${pageContext.request.userPrincipal.name != null}">
    <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
  </c:if>
    <div id="sidebar" class="sidebar collapsed">
        <!-- Nav tabs -->
        <div class="sidebar-tabs">
            <ul role="tablist">
                <li><a href="#home" role="tab"><i class="fa fa-bars"></i></a></li>
                <li><a href="#search" role="tab"><i class="fa fa-search"></i></a></li>
                <li><a href="#profile" role="tab"><i class="fa fa-user"></i></a></li>
                <li><a href="#mapmarker" role="tab"><i class="fa fa-map-marker"></i></a></li>
                <li class="disabled"><a href="#messages" role="tab"><i class="fa fa-envelope"></i></a></li>            </ul>
 
            <ul role="tablist">
                <li><a href="#settings" role="tab"><i class="fa fa-gear"></i></a></li>
            </ul>
        </div>

        <!-- Tab panes -->
        <div class="sidebar-content">
            <div class="sidebar-pane" id="home">
                <h1 class="sidebar-header">
                   Map Layer Options
                    <span class="sidebar-close"><i class="fa fa-caret-left"></i></span>
                </h1>
              <div id="custom-layer-switcher"></div>
            </div>

            <div class="sidebar-pane" id="search">
                <h1 class="sidebar-header">Search<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
                <div style="padding:5px;">
                <div class="row">
            <div class="col-md-12">
		    <div class="input-group">
                <div class="input-group-btn search-panel" data-search="students">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    	<span class="search_by">Search in</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a data-search="adresser">adresser</a></li>
                      <li><a data-search="matrikelnumre">matrikelnumre</a></li>
                      <li><a data-search="matrikelnumre_udgaaet">matrikelnumre_incl_udgaaet</a></li>
                      <li><a data-search="stednavne">stednavne (ikke på opdaterede data)</a></li>
                      <li><a data-search="stednavne_v2">matrikelnumre_incl_udgaaet</a></li>
                      <li><a data-search="matrikelnumre_udgaaet">stednavne_v2 (Dagligt opdaterede stednavne)</a></li>
                      <li><a data-search="kommuner">kommuner</a></li>
                      <li><a data-search="opstillingskredse">opstillingskredse</a></li>
                      <li><a data-search="politikredse">politikredse</a></li>
                      <li><a data-search="postdistrikter">postdistrikter</a></li>
                      <li><a data-search="regioner">regioner</a></li>
                      <li><a data-search="retskredse">retskredse</a></li>
					  <li><a data-search="sogne">sogne</a></li> 
                      <li class="divider"></li>
                      <li><a data-search="all">all</a></li>
                    </ul>
                </div>   
                <script type="text/javascript">
                $(document).ready(function(e){
                	  "use strict";
                	  $('.search-panel').each( function() {
                	    var to = $(this).data('search').toString();
                	    var text = $(this).find('[data-search="' + to + '"]').html();
                	    $(this).find('button span.search_by').html(text);
                	  });
                	  
                	  $('.search-panel li a').on('click', function(e){
                	    var sp = $(this).closest('.search-panel');
                	    var to = $(this).html();
                	    var text = $(this).html();
                	    sp.data('search', to);
                	    console.log(sp.find('.search_by'));
                	    sp.find('button span.search_by').html(text);
                	  });
                	});
                </script>
                <input type="text" class="form-control" name="x" placeholder="Search in kortforsyningen">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><span class="fa fa-search"></span></button>
                </span>
            </div> 
</div>
            </div>
            </div>
            </div>
            <div class="sidebar-pane" id="mapmarker">
                <h1 class="sidebar-header">Map Marker<span class="sidebar-close"><i class="fa fa-caret-left"></i></span></h1>
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
	<script src="resources/assets/leaflet/leaflet-smoothmarkerbouncing/leaflet.smoothmarkerbouncing.js"></script>
	<script src="resources/assets/bootstrap/bootstrap3-typeahead.min.js"></script>
	<script	src="resources/assets/leaflet/leaflet-wicket/wicket.js"></script>
	<script	src="resources/assets/leaflet/leaflet-wicket/wicket-leaflet.js"></script>
	<script src="resources/js/app.js"></script>
</body>
</html>
