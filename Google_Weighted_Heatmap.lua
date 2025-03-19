local addresses = {
    { address = "2.18.27.76", longitude = -0.6718, latitude = 51.5368, weight = 5 },
    { address = "2.18.27.82", longitude = -0.6718, latitude = 51.5368, weight = 3 },
    { address = "2.18.27.89", longitude = -0.6718, latitude = 51.5368, weight = 50 },
    { address = "2.19.252.151", longitude = -0.6718, latitude = 51.5368, weight = 2 },
    { address = "3.75.168.79", longitude = 8.6837, latitude = 50.1169, weight = 7 },
    { address = "8.8.8.8", longitude = -97.822, latitude = 37.751, weight = 8 },
    { address = "20.90.152.133", longitude = -0.1278, latitude = 51.5081, weight = 6 },
    
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

