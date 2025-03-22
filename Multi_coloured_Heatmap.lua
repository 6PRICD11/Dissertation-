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
    { address = "217.160.86.6", longitude = 13.405, latitude = 52.52 },
    { address = "2.18.27.77", longitude = -0.6721, latitude = 51.5371 },  
    { address = "2.18.27.78", longitude = -3.1883, latitude = 55.9533 },  
    { address = "2.18.27.79", longitude = 2.3522, latitude = 48.8566 },  
    { address = "2.18.27.80", longitude = 4.8357, latitude = 45.7640 },  
    { address = "2.18.27.81", longitude = 13.4050, latitude = 52.5200 },
    { address = "34.102.136.200", longitude = -74.0060, latitude = 40.7128 },  
    { address = "18.232.56.190", longitude = -95.3698, latitude = 29.7604 },  
    { address = "44.239.23.101", longitude = -122.3321, latitude = 47.6062 }, 
    { address = "35.185.128.75", longitude = -118.2437, latitude = 34.0522 }, 
}

local highlighted_addresses = {
    addresses[25], addresses[26], addresses[27], 
    addresses[28], addresses[29] 
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

            var heatmap = new google.maps.visualization.HeatmapLayer({
                data: heatmapData,
                radius: 65,
                opacity: 0.7
            });

            var highlightedHeatmap = new google.maps.visualization.HeatmapLayer({
                data: highlightedHeatmapData,
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
            'new google.maps.LatLng(%f, %f)',
            entry.latitude, entry.longitude
        ))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

local file = io.open("Googlemap_multicoloured_heatmap.html", "w")
file:write(html_template:format(to_json(addresses), to_json(highlighted_addresses)))
file:close()

print("HTML file 'Googlemap_multicoloured_heatmap.html' created. Open it in a browser to view the heatmap.")
