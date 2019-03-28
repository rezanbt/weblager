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

<link rel="stylesheet"
	href="resources/assets/bootstrap/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/base/leaflet.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-markercluster/MarkerCluster.Default.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-locatecontrol/L.Control.Locate.css">
<link rel="stylesheet"
	href="resources/assets/leaflet/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.css">
<link rel="stylesheet" href="resources/css/app.css">

<link rel="apple-touch-icon" sizes="76x76"
	href="resources/img/favicon-76.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="resources/img/favicon-120.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="resources/img/favicon-152.png">
<link rel="icon" sizes="196x196" href="resources/img/favicon-196.png">
<link rel="icon" type="image/x-icon" href="resources/img/favicon.ico">
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<div class="navbar-icon-container">
					<a href="#" class="navbar-icon pull-right visible-xs" id="nav-btn"><i
						class="fa fa-bars fa-lg white"></i></a> <a href="#"
						class="navbar-icon pull-right visible-xs" id="sidebar-toggle-btn"><i
						class="fa fa-search fa-lg white"></i></a>
				</div>
				<a class="navbar-brand" href="#">Weblager.dk</a>
			</div>
			<div class="navbar-collapse collapse">
				<form class="navbar-form navbar-right" role="search">
					<div class="form-group has-feedback">
						<input id="searchbox" type="text" placeholder="Search"
							class="form-control"> <span id="searchicon"
							class="fa fa-search form-control-feedback"></span>
					</div>
				</form>
				<ul class="nav navbar-nav">
					<li><a href="#" data-toggle="collapse"
						data-target=".navbar-collapse.in" id="about-btn"><i
							class="fa fa-question-circle white"></i>&nbsp;&nbsp;About</a></li>
					<li class="dropdown"><a id="toolsDrop" href="#" role="button"
						class="dropdown-toggle" data-toggle="dropdown"><i
							class="fa fa-globe white"></i>&nbsp;&nbsp;Tools <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="#" data-toggle="collapse"
								data-target=".navbar-collapse.in" id="full-extent-btn"><i
									class="fa fa-arrows-alt"></i>&nbsp;&nbsp;Zoom To Full Extent</a></li>
							<li><a href="#" data-toggle="collapse"
								data-target=".navbar-collapse.in" id="legend-btn"><i
									class="fa fa-picture-o"></i>&nbsp;&nbsp;Show Legend</a></li>
							<li class="divider hidden-xs"></li>
							<li><a href="#" data-toggle="collapse"
								data-target=".navbar-collapse.in" id="login-btn"><i
									class="fa fa-user"></i>&nbsp;&nbsp;Login</a></li>
						</ul></li>
					<li class="dropdown"><a class="dropdown-toggle"
						id="downloadDrop" href="#" role="button" data-toggle="dropdown"><i
							class="fa fa-cloud-download white"></i>&nbsp;&nbsp;Download <b
							class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="resources/data/boroughs.geojson"
								download="boroughs.geojson" target="_blank"
								data-toggle="collapse" data-target=".navbar-collapse.in"><i
									class="fa fa-download"></i>&nbsp;&nbsp;Boroughs</a></li>
							<li><a href="resources/data/subways.geojson"
								download="subways.geojson" target="_blank"
								data-toggle="collapse" data-target=".navbar-collapse.in"><i
									class="fa fa-download"></i>&nbsp;&nbsp;Subway Lines</a></li>
							<li><a
								href="resources/data/DOITT_THEATER_01_13SEPT2010.geojson"
								download="theaters.geojson" target="_blank"
								data-toggle="collapse" data-target=".navbar-collapse.in"><i
									class="fa fa-download"></i>&nbsp;&nbsp;Theaters</a></li>
							<li><a
								href="resources/data/DOITT_MUSEUM_01_13SEPT2010.geojson"
								download="museums.geojson" target="_blank"
								data-toggle="collapse" data-target=".navbar-collapse.in"><i
									class="fa fa-download"></i>&nbsp;&nbsp;Museums</a></li>
						</ul></li>
					<li class="hidden-xs"><a href="#" data-toggle="collapse"
						data-target=".navbar-collapse.in" id="list-btn"><i
							class="fa fa-list white"></i>&nbsp;&nbsp;POI List</a></li>
				</ul>
			</div>
			<!--/.navbar-collapse -->
		</div>
	</div>

	<div id="container">
		<div id="sidebar">
			<div class="sidebar-wrapper">
				<div class="panel panel-default" id="features">
					<div class="panel-heading">
						<h3 class="panel-title">
							Weblager kortviser
							<button type="button"
								class="btn btn-xs btn-xs btn-default pull-right"
								id="sidebar-hide-btn">
								<i class="fa fa-chevron-left"></i>
							</button>
						</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-12">
								<div style="padding: 0 15px 2px 15px;" data-toggle="buttons">
									<div class="btn-group btn-group-justified">
										<label class="btn btn-xs btn-success active"> <input
											type="checkbox" autocomplete="off" checked checked> <span
											class="">adresser</span>
										</label> <label class="btn btn-xs btn-primary"> <input
											type="checkbox" autocomplete="off" checked> <span
											class="">matrikelnumre</span>
										</label>

									</div>
									<div class="btn-group btn-group-justified">
										<label class="btn btn-xs btn-info"> <input
											type="checkbox" autocomplete="off" checked> <span
											class="">stednavne_v2</span>
										</label> <label class="btn btn-xs btn-default"> <input
											type="checkbox" autocomplete="off" checked> <span
											class="">kommuner</span>
										</label>
									</div>
									<div class="btn-group btn-group-justified">
										<label class="btn btn-xs btn-warning"> <input
											type="checkbox" autocomplete="off" checked> <span
											class="">opstillingskredse</span>
										</label> <label class="btn btn-xs btn-danger"> <input
											type="checkbox" autocomplete="off" checked> <span
											class="">politikredse</span>
										</label>
									</div>



								</div>
							</div>
							<div class="row hidden">
								<div class="col col-md-6">
									<div class="checkbox">
										<label><input type="checkbox" checked value="adresser">adresser</label>
									</div>
									<div class="checkbox">
										<label> <input type="checkbox" checked
											value="matrikelnumre">matrikelnumre
										</label>
									</div>
									<div class="checkbox">
										<label><input type="checkbox" checked
											value="stednavne">stednavne_v2</label>
									</div>
								</div>

								<div class="col col-md-6">
									<div class="checkbox">
										<label><input type="checkbox" checked value="kommuner">kommuner</label>
									</div>
									<div class="checkbox">
										<label> <input type="checkbox" checked
											value="postdistrikter">postdistrikter
										</label>
									</div>
									<div class="checkbox">
										<label><input type="checkbox" checked
											value="opstillingskredse">opstillingskredse</label>
									</div>
								</div>

							</div>
						</div>
						<div class="row">

							<div class="col-xs-9 col-md-9">
								<input type="text" class="form-control search"
									placeholder="Søg" />
							</div>
							<div class="col-xs-3 col-md-3">
								<button type="button" class="btn btn-primary pull-right sort"
									data-sort="feature-name" id="sort-btn">
									<i class="fa fa-sort"></i>&nbsp;&nbsp;Sort
								</button>
							</div>
						</div>
					</div>
					<div class="sidebar-table">
						<table class="table table-hover" id="feature-list">
							<thead class="hidden">
								<tr>
									<th>Icon</th>
								<tr>
								<tr>
									<th>Name</th>
								<tr>
								<tr>
									<th>Chevron</th>
								<tr>
							</thead>
							<tbody class="list"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div id="map"></div>
	</div>
	<div id="loading">
		<div class="loading-indicator">
			<div class="progress progress-striped active">
				<div class="progress-bar progress-bar-info progress-bar-full"></div>
			</div>
		</div>
	</div>


	<!-- /.modal -->

	<div class="modal fade" id="legendModal" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Map Legend</h4>
				</div>
				<div class="modal-body">
					<p>Map Legend goes here...</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-xs btn-default"
						data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Login</h4>
				</div>
				<div class="modal-body">
					<form id="contact-form">
						<fieldset>
							<div class="form-group">
								<label for="name">Username:</label> <input type="text"
									class="form-control" id="username">
							</div>
							<div class="form-group">
								<label for="email">Password:</label> <input type="password"
									class="form-control" id="password">
							</div>
						</fieldset>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-xs btn-default"
						data-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-xs btn-primary"
						data-dismiss="modal">Login</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<div class="modal fade" id="featureModal" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title text-primary" id="feature-title"></h4>
				</div>
				<div class="modal-body" id="feature-info"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-xs btn-default"
						data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<div class="modal fade" id="attributionModal" tabindex="-1"
		role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">
						Developed by <a href='mailto:nabati.reza@gmail.com'>nabati.reza@gmail.com</a>
					</h4>
				</div>
				<div class="modal-body">
					<div id="attribution"></div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="resources/assets/bootstrap/bootstrap.min.js"></script>
	<script
		src="resources/assets/typeahead/typeahead.bundle.min.js"></script>
	<script
		src="resources/assets/handlebars/handlebars.min.js"></script>
	<script
		src="resources/assets/listjs/list.min.js"></script>
	<script
		src="resources/assets/leaflet/base/leaflet.js"></script>

	<script src="resources/assets/proj4s/proj4-src.js"></script>

	<script
		src="resources/assets/leaflet/leaflet-proj4leaflet/proj4leaflet.min.js"></script>

	<script
		src="resources/assets/leaflet/leaflet-markercluster/leaflet.markercluster.js"></script>
	<script
		src="resources/assets/leaflet/leaflet-locatecontrol/L.Control.Locate.js"></script>
	<script
		src="resources/assets/leaflet/leaflet-groupedlayercontrol/leaflet.groupedlayercontrol.js"></script>
	<script src="resources/js/app.js"></script>
</body>
</html>
