local addresses = {
    { address = "2.18.27.76", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.18.27.82", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.18.27.89", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.19.252.151", longitude = -0.6718, latitude = 51.5368 },
    { address = "3.75.168.79", longitude = 8.6837, latitude = 50.1169 },
    { address = "8.8.8.8", longitude = -97.822, latitude = 37.751 },
    { address = "20.90.152.133", longitude = -0.1278, latitude = 51.5081 },
    { address = "42.194.136.76", longitude = 113.2539, latitude = 23.1181 },
    { address = "52.105.34.25", longitude = -6.2591, latitude = 53.3382 },
    { address = "92.123.128.166", longitude = -0.1278, latitude = 51.5081 },
    { address = "142.250.178.3", longitude = -97.822, latitude = 37.751 },
    { address = "142.250.179.238", longitude = -97.822, latitude = 37.751 },
    { address = "204.79.197.203", longitude = -97.822, latitude = 37.751 },
    { address = "216.58.204.74", longitude = -97.822, latitude = 37.751 },
    { address = "54.239.26.23", longitude = -77.0369, latitude = 38.9072 },
    { address = "104.26.10.172", longitude = -122.3321, latitude = 47.6062 },
    { address = "151.101.1.69", longitude = -74.006, latitude = 40.7128 },
    { address = "185.199.108.153", longitude = 2.3522, latitude = 48.8566 },
    { address = "202.160.128.111", longitude = 103.8198, latitude = 1.3521 },
    { address = "203.0.113.45", longitude = 144.9631, latitude = -37.8136 },
    { address = "209.85.231.100", longitude = -118.2437, latitude = 34.0522 },
    { address = "45.33.32.156", longitude = -80.1918, latitude = 25.7617 },
    { address = "129.250.35.250", longitude = 139.6917, latitude = 35.6895 },
    { address = "217.160.86.6", longitude = 13.405, latitude = 52.52 }
}

local highlighted_addresses = {
    addresses[5], addresses[10], addresses[15], 
    addresses[20], addresses[25] 
}

local html_template = [[
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps Heatmap</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCL20d4eLO1fFvfqkpz4l1WDYhqMM9pRF8&libraries=visualization"></script>
    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById("map"), {
                zoom: 3,
                center: { lat: 20, lng: 0 },
                mapTypeId: "roadmap"
            });

            var heatmapData = %s;
            var highlightedHeatmapData = %s;
            var markerData = %s;

            var heatmap = new google.maps.visualization.HeatmapLayer({
                data: heatmapData.map(loc => new google.maps.LatLng(loc.lat, loc.lng)),
                radius: 65,
                opacity: 0.7
            });

            var highlightedHeatmap = new google.maps.visualization.HeatmapLayer({
                data: highlightedHeatmapData.map(loc => new google.maps.LatLng(loc.lat, loc.lng)),
                radius: 40,
                opacity: 0.7,
                gradient: [
                    'rgba(0, 255, 255, 0)',
                    'rgba(0, 255, 255, 1)',
                    'rgba(0, 191, 255, 1)',
                    'rgba(0, 127, 255, 1)',
                    'rgba(0, 63, 255, 1)',
                    'rgba(0, 0, 255, 1)',
                    'rgba(63, 0, 191, 1)',
                    'rgba(127, 0, 127, 1)',
                    'rgba(191, 0, 63, 1)',
                    'rgba(255, 0, 0, 1)'
                ]
            });

            heatmap.setMap(map);
            highlightedHeatmap.setMap(map);

            // Add markers
            var markers = [];
            markerData.forEach(function(location) {
                var marker = new google.maps.Marker({
                    position: location,
                    map: null  // Initially hidden
                });
                markers.push(marker);
            });

            // Show markers when zoom > 6
            map.addListener('zoom_changed', function() {
                var zoomLevel = map.getZoom();
                markers.forEach(marker => {
                    marker.setMap(zoomLevel > 6 ? map : null);
                });
            });
        }
    </script>
</head>
<body onload="initMap()">
    <div id="map" style="width: 100%%; height: 600px;"></div>
</body>
</html>
]]

local function to_json(tbl)
    local items = {}
    for _, entry in ipairs(tbl) do
        table.insert(items, string.format(
            '{"lat": %f, "lng": %f}',
            entry.latitude, entry.longitude
        ))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

local file = io.open("Heatmap_with_plots.html", "w")
file:write(html_template:format(to_json(addresses), to_json(highlighted_addresses), to_json(addresses)))
file:close()

print("HTML file 'Heatmap_with_plots.html' created. Open it in a browser to view the heatmap.")
