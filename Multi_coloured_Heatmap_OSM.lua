local addresses = {
    { address = "2.18.27.76", latitude = 51.5368, longitude = -0.6718 },
    { address = "2.18.27.82", latitude = 51.5368, longitude = -0.6718 },
    { address = "2.18.27.89", latitude = 51.5368, longitude = -0.6718 },
    { address = "2.19.252.151", latitude = 51.5368, longitude = -0.6718 },
    { address = "3.75.168.79", latitude = 50.1169, longitude = 8.6837 },
    { address = "8.8.8.8", latitude = 37.751, longitude = -97.822 },
    { address = "20.90.152.133", latitude = 51.5081, longitude = -0.1278 },
    { address = "42.194.136.76", latitude = 23.1181, longitude = 113.2539 },
    { address = "52.105.34.25", latitude = 53.3382, longitude = -6.2591 },
    { address = "92.123.128.166", latitude = 51.5081, longitude = -0.1278 }
}

local highlighted_addresses = {
    { address = "2.18.27.77", latitude = 51.5371, longitude = -0.6721 },
    { address = "2.18.27.78", latitude = 55.9533, longitude = -3.1883 }
}

local html_template = [[
<!DOCTYPE html>
<html>
<head>
    <title>OSM Heatmap</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet.heat/dist/leaflet-heat.js"></script>
    <style>#map { width: 100%%; height: 600px; }</style>
</head>
<body>
    <div id="map"></div>
    <script>
        var map = L.map("map").setView([20, 0], 3);

        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        var heatmapData = %s;
        var highlightedHeatmapData = %s;

        L.heatLayer(heatmapData, { radius: 25, blur: 15, maxZoom: 17 }).addTo(map);
        L.heatLayer(highlightedHeatmapData, { radius: 35, blur: 0, maxZoom: 17, max: 10 }).addTo(map);
    </script>
</body>
</html>
]]

local function to_json(tbl, intensity)
    local items = {}
    for _, entry in ipairs(tbl) do
        table.insert(items, string.format("[%f, %f, %f]", entry.latitude, entry.longitude, intensity))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

local file = io.open("OSM_multicoloured_heatmap.html", "w")
file:write(html_template:format(to_json(addresses, 0.6), to_json(highlighted_addresses, 1.0)))
file:close()

print("HTML file 'OSM_multicoloured_heatmap.html' created. Open it in a browser to view the heatmap.")
