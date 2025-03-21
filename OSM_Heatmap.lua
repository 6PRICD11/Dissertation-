local addresses = {
    { address = "2.18.27.76", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.18.27.82", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.18.27.89", longitude = -0.6718, latitude = 51.5368 },
    { address = "2.19.252.151", longitude = -0.6718, latitude = 51.5368 },
    { address = "3.75.168.79", longitude = 8.6837, latitude = 50.1169 },
    { address = "8.8.8.8", longitude = -97.822, latitude = 37.751 },
    { address = "20.90.152.133", longitude = -0.1278, latitude = 51.5081 }
}

local html_template = [[
<!DOCTYPE html>
<html>
<head>
    <title>Heatmap - OpenStreetMap</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet.heat/dist/leaflet-heat.js"></script>
    <style>
        #map { height: 600px; width: 100%%; }
    </style>
</head>
<body>
    <div id="map"></div>
    <script>
        var map = L.map('map').setView([20, 0], 3);
        
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        var heatPoints = %s;

        var heat = L.heatLayer(heatPoints, {
            radius: 25,
            blur: 15,
            maxZoom: 10
        }).addTo(map);
    </script>
</body>
</html>
]]

-- Convert Lua table to JSON-like JavaScript array format
local function to_json(tbl)
    local items = {}
    for _, entry in ipairs(tbl) do
        table.insert(items, string.format("[%.6f, %.6f]", entry.latitude, entry.longitude))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

-- Write HTML file
local file = io.open("OSMheatmap.html", "w")
if file then
    file:write(html_template:format(to_json(addresses)))
    file:close()
    print("HTML file 'OSMheatmap.html' created. Open it in a browser to view the heatmap.")
else
    print("Error: Unable to create 'OSMheatmap.html'")
end
