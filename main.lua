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
    { address = "103.21.244.0", longitude = 72.8777, latitude = 19.076 },
    { address = "31.13.79.246", longitude = -58.3816, latitude = -34.6037 },
    { address = "81.2.69.160", longitude = 14.4208, latitude = 50.088 },
    { address = "46.101.160.123", longitude = 4.9041, latitude = 52.3676 },
    { address = "58.97.5.29", longitude = 100.5018, latitude = 13.7563 },
    { address = "119.28.48.228", longitude = 114.1694, latitude = 22.3193 },
    { address = "45.132.20.101", longitude = 28.9784, latitude = 41.0082 },
    { address = "67.225.192.12", longitude = -123.1216, latitude = 49.2827 },
    { address = "185.60.216.35", longitude = 30.5234, latitude = 50.4501 },
    { address = "190.92.55.89", longitude = -74.0721, latitude = 4.711 },
    { address = "138.199.68.19", longitude = -47.8825, latitude = -15.7942 },
    { address = "195.162.25.43", longitude = 135.7681, latitude = 35.0116 },
    { address = "202.134.25.88", longitude = 139.6503, latitude = 35.6762 },
    { address = "180.76.15.162", longitude = 116.4074, latitude = 39.9042 },
    { address = "74.125.24.102", longitude = 12.4964, latitude = 41.9028 },
    { address = "66.220.149.50", longitude = -79.3832, latitude = 43.6532 },
    { address = "220.233.24.56", longitude = 153.0251, latitude = -27.4698 },
    { address = "23.227.38.32", longitude = -43.1729, latitude = -22.9068 },
    { address = "213.186.33.19", longitude = 6.9603, latitude = 50.9375 },
    { address = "50.87.253.48", longitude = 151.2093, latitude = -33.8688 },
    { address = "93.184.220.29", longitude = -3.1883, latitude = 55.9533 },
    { address = "160.153.129.19", longitude = -4.2518, latitude = 55.8642 },
    { address = "178.62.200.250", longitude = -0.1226, latitude = 51.5074 },
    { address = "192.99.100.23", longitude = -73.5673, latitude = 45.5017 },
    { address = "185.199.111.153", longitude = 5.2913, latitude = 52.1326 },
    { address = "45.33.32.100", longitude = -115.1467, latitude = 36.1699 },
    { address = "67.199.248.12", longitude = -90.0715, latitude = 29.9511 },
    { address = "23.105.135.77", longitude = -157.8583, latitude = 21.3069 },
    { address = "144.76.189.100", longitude = 11.581, latitude = 48.1351 },
    { address = "82.165.33.21", longitude = 37.6173, latitude = 55.7558 },
    { address = "91.121.92.50", longitude = 2.2945, latitude = 48.8584 }
}


local html_template = [[
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps Plot</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCL20d4eLO1fFvfqkpz4l1WDYhqMM9pRF8"></script>
    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById("map"), {
                zoom: 3,
                center: { lat: 20, lng: 0 } // Centered globally
            });

            var locations = %s; // Insert JSON data from Lua

            locations.forEach(function(location) {
                var marker = new google.maps.Marker({
                    position: { lat: location.latitude, lng: location.longitude },
                    map: map,
                    title: location.address // IP address as marker title
                });

                var infoWindow = new google.maps.InfoWindow({
                    content: "<b>IP Address:</b> " + location.address
                });

                marker.addListener("click", function() {
                    infoWindow.open(map, marker);
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

-- Convert Lua table to JavaScript array format
local function to_json(tbl)
    local items = {}
    for _, entry in ipairs(tbl) do
        table.insert(items, string.format(
            '{ address: "%s", latitude: %f, longitude: %f }',
            entry.address, entry.latitude, entry.longitude
        ))
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

-- Write HTML file
local file = io.open("map.html", "w")
file:write(html_template:format(to_json(addresses)))
file:close()

print("HTML file 'map.html' created. Open it in a browser to view the map.")
