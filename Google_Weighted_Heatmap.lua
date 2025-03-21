local addresses = {
    { address = "2.18.27.90", longitude = -0.6718, latitude = 51.5368, weight = 25 },
    { address = "2.19.252.152", longitude = -0.6718, latitude = 51.5368, weight = 25 },
    { address = "3.75.168.80", longitude = 8.6837, latitude = 50.1169, weight = 25 },
    { address = "8.8.4.4", longitude = -97.822, latitude = 37.751, weight = 25 },
    { address = "20.90.152.134", longitude = -0.1278, latitude = 51.5081, weight = 25 },
    { address = "34.120.100.200", longitude = -118.2437, latitude = 34.0522, weight = 25 },
    { address = "52.95.20.1", longitude = -0.4614, latitude = 51.4700, weight = 25 },
    { address = "18.204.0.22", longitude = -86.85, latitude = 33.5186, weight = 25 },
    { address = "102.132.96.15", longitude = 28.0473, latitude = -26.2041, weight = 25 },
    { address = "185.199.110.153", longitude = -74.006, latitude = 40.7128, weight = 11 },
    { address = "23.94.86.32", longitude = -81.6557, latitude = 30.3322, weight = 14 },
    { address = "35.160.0.1", longitude = -122.6765, latitude = 45.5234, weight = 8 },
    { address = "99.79.150.101", longitude = -75.699, latitude = 45.4112, weight = 10 },
    { address = "45.79.200.14", longitude = -123.262, latitude = 44.5646, weight = 3 },
    { address = "192.168.1.1", longitude = -97.7431, latitude = 30.2672, weight = 13 },
    { address = "172.16.5.20", longitude = -95.3698, latitude = 29.7604, weight = 12 },
    { address = "38.100.200.50", longitude = -77.0369, latitude = 38.9072, weight = 16 },
    { address = "74.125.200.102", longitude = -122.084, latitude = 37.422, weight = 18 },
    { address = "104.28.0.1", longitude = -118.2506, latitude = 34.0536, weight = 9 },
    { address = "137.184.12.44", longitude = -73.9352, latitude = 40.7306, weight = 7 },
    { address = "205.251.242.54", longitude = -122.3321, latitude = 47.6062, weight = 5 },
    { address = "157.240.1.1", longitude = -80.1918, latitude = 25.7617, weight = 6 },
    { address = "203.0.113.45", longitude = 144.9631, latitude = -37.8136, weight = 11 },
    { address = "195.112.200.80", longitude = 139.6917, latitude = 35.6895, weight = 17 },
    { address = "210.140.10.77", longitude = 126.978, latitude = 37.5665, weight = 4 },  
    { address = "150.109.120.55", longitude = 103.8198, latitude = 1.3521, weight = 7 },
    { address = "45.33.128.200", longitude = -79.3832, latitude = 43.6532, weight = 12 },
    { address = "198.51.100.23", longitude = 151.2093, latitude = -33.8688, weight = 9 },
    { address = "88.99.50.78", longitude = 13.405, latitude = 52.52, weight = 14 },
    { address = "185.220.101.40", longitude = 4.9041, latitude = 52.3676, weight = 6 }  

    
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

            var heatmapData = %s; // Insert JSON data from Lua

            var heatmap = new google.maps.visualization.HeatmapLayer({
                data: heatmapData,
                radius: 75,
                opacity: 0.6
            });

            heatmap.setMap(map);
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
            '{location: new google.maps.LatLng(%f, %f), weight: %d}',
            entry.latitude, entry.longitude, entry.weight
        ))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

local file = io.open("Googlemap_weighted_heatmap.html", "w")
file:write(html_template:format(to_json(addresses)))
file:close()

print("HTML file 'Googlemap_weighted_heatmap.html' created. Open it in a browser to view the heatmap.")

