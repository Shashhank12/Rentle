<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonParser" %>

<%! 
    public double getDistance(String origin, String destination, String apiKey) throws IOException {
        try {
            URL url = new URL("https://maps.googleapis.com/maps/api/geocode/json?address=" + URLEncoder.encode(origin, "UTF-8") + "&key=" + apiKey);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new IOException(conn.getResponseMessage());
            }
            JsonParser parser = new JsonParser();
            JsonObject response = parser.parse(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
            JsonObject location = response.getAsJsonArray("results").get(0).getAsJsonObject().getAsJsonObject("geometry").getAsJsonObject("location");
            double originLat = location.get("lat").getAsDouble();
            double originLng = location.get("lng").getAsDouble();

            url = new URL("https://maps.googleapis.com/maps/api/geocode/json?address=" + URLEncoder.encode(destination, "UTF-8") + "&key=" + apiKey);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) {
                throw new IOException(conn.getResponseMessage());
            }
            response = parser.parse(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
            location = response.getAsJsonArray("results").get(0).getAsJsonObject().getAsJsonObject("geometry").getAsJsonObject("location");
            double destLat = location.get("lat").getAsDouble();
            double destLng = location.get("lng").getAsDouble();

            double distance = calculateDistance(originLat, originLng, destLat, destLng);
            return distance * 1.60934;
        } catch (Exception e) {
            return -1;
        }
    }
    
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double theta = lon1 - lon2;
        double dist = Math.sin(Math.toRadians(lat1)) * Math.sin(Math.toRadians(lat2)) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.cos(Math.toRadians(theta));
        dist = Math.acos(dist);
        dist = Math.toDegrees(dist);
        dist = dist * 60 * 1.1515;
        return dist;
    }
%>

<%@ page import="java.sql.*, java.util.*" %>
<%
    String query = request.getParameter("query");
    String minPriceStr = request.getParameter("minPrice");
    String maxPriceStr = request.getParameter("maxPrice");
    String durationStr = request.getParameter("duration");
    String durationCategory = request.getParameter("durationCategory");
    String category = request.getParameter("category");
    String feature = request.getParameter("feature");
    String sortBy = request.getParameter("sortBy");
    String location = request.getParameter("location");
    Double locationDistance = Double.parseDouble(request.getParameter("locationDistance")) * 1.60934;
    Boolean excellentCondition = Boolean.parseBoolean(request.getParameter("excellentCondition"));
    Boolean goodCondition = Boolean.parseBoolean(request.getParameter("goodCondition"));
    Boolean fairCondition = Boolean.parseBoolean(request.getParameter("fairCondition"));    
    
    if (location == null || location.isEmpty()) {
        location = "1 Washington Sq, San Jose, CA 95192";
    }
    
    if (sortBy == null || sortBy.isEmpty() || sortBy.equals("Price")) {
        sortBy = "price";
    } else if (sortBy.equals("Location")) {
        sortBy = "location";
    } else {
        sortBy = "date";
    }

    double minPrice = minPriceStr != null && !minPriceStr.isEmpty() ? Double.parseDouble(minPriceStr) : 0.0;
    double maxPrice = maxPriceStr != null && !maxPriceStr.isEmpty() ? Double.parseDouble(maxPriceStr) : Double.MAX_VALUE;
    double duration = durationStr != null && !durationStr.isEmpty() ? Double.parseDouble(durationStr) : 1.0;
    
    HashMap<String, Double> durationMap = new HashMap<>();
    durationMap.put("Hour(s)", 1.0);
    durationMap.put("Day(s)", 24.0);
    durationMap.put("Week(s)", 24.0 * 7);
    durationMap.put("Month(s)", 24.0 * 30);

    String db = "test";
    String user = "root";
    String password = "CS157apass123$";

    if ((query != null && !query.trim().isEmpty()) || minPriceStr != null || maxPriceStr != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
            
            // Get distance from location
            
            String sql = "SELECT items.itemid, items.name, items.description, items.location, items.posteddate, prices.priceperhour, prices.priceperday, prices.priceperweek, prices.pricepermonth FROM items JOIN rentsfor USING (ItemID) JOIN prices USING (PricesID) WHERE (items.name LIKE ? OR items.description LIKE ?)";
            
            if (excellentCondition || goodCondition || fairCondition) {
                sql += " AND (";
                if (excellentCondition) {
                    sql += "items.condition = \"Excellent\"";
                }
                if (goodCondition) {
                    sql += excellentCondition ? " OR " : "";
                    sql += "items.condition = \"Good\"";
                }
                
                if (fairCondition) {
                    sql += (excellentCondition || goodCondition) ? " OR " : "";
                    sql += "items.condition = \"Fair\"";
                }
                sql += ")";
            }
            
            if (category != null && !category.equals("all")) {
                sql += " AND items.ItemID IN (SELECT ItemID FROM items JOIN has USING (ItemID) JOIN category USING (CategoryID) WHERE categoryname LIKE ?)";
            }
            
            if (feature != null && !feature.equals("all")) {
                sql += " AND items.ItemID IN (SELECT ItemID FROM items JOIN has USING (ItemID) JOIN consistsof USING (CategoryID) JOIN feature USING (FeaturesID) WHERE FeaturesName LIKE ?)";
            }
            
            if (sortBy.equals("price")) {
                sql += " ORDER BY prices.priceperhour";
            } else if (sortBy.equals("date")) {
                sql += " ORDER BY items.posteddate";
            }
            
             
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            if (category != null && !category.equals("all")) {
                ps.setString (3, "%" + category + "%");
            }
            
            if (feature != null && !feature.equals("all")) {
                ps.setString(category != null && !category.equals("all") ? 4 : 3, "%" + feature + "%");
            }
            ResultSet rs = ps.executeQuery();
            
            List<Map<String, Object>> items = new ArrayList<>();
            
            while (rs.next()) {
                
                Map<String, Object> item = new HashMap<>();
                
                String itemName = rs.getString("name");
                String itemDescription = rs.getString("description");
                String itemCategory = "None";
                String itemFeature = "None";
                String itemImage = "None";
                
                try{
                    itemCategory = rs.getString("categoryname");
                } catch (Exception e) {
                    ps = con.prepareStatement("SELECT categoryname FROM items JOIN has USING (ItemID) JOIN category USING (CategoryID) WHERE ItemID = ? LIMIT 1");
                    ps.setInt(1, rs.getInt("ItemID"));
                    ResultSet rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        itemCategory = rs2.getString("categoryname");
                    }
                }
                
                try {
                    itemFeature = rs.getString("FeaturesName");
                } catch (Exception e) {
                    ps = con.prepareStatement("SELECT FeaturesName FROM items JOIN has USING (ItemID) JOIN consistsof USING (CategoryID) JOIN feature USING (FeaturesID) WHERE ItemID = ? LIMIT 1");
                    ps.setInt(1, rs.getInt("ItemID"));
                    ResultSet rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        itemFeature = rs2.getString("FeaturesName");
                    }
                }
                
                try  {
                    ps = con.prepareStatement("SELECT photos.photo FROM photos JOIN contains USING (PhotoID) WHERE ItemID = ? LIMIT 1");
                    ps.setInt(1, rs.getInt("ItemID"));
                    ResultSet rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        itemImage = rs2.getString("photo");
                    }
                } catch (Exception e) {
                    out.println(e);
                }
                
                Double pricePerHour = rs.getDouble("priceperhour") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperhour");
                Double pricePerDay = rs.getDouble("priceperday") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperday") / 24;
                Double pricePerWeek = rs.getDouble("priceperweek") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperweek") / 24 / 7;
                Double pricePerMonth = rs.getDouble("pricepermonth") == 0.0 ? Double.MAX_VALUE : rs.getDouble("pricepermonth") / 24 / 30;
                
                Double price = null;
                if (durationCategory.equals("Hour(s)")) {
                    price = pricePerHour;
                } else if (durationCategory.equals("Day(s)")) {
                    price = Math.min(pricePerDay, pricePerHour);
                } else if (durationCategory.equals("Week(s)")) {
                    price = Math.min(pricePerWeek, Math.min(pricePerDay, pricePerHour));
                } else {
                    price = Math.min(pricePerMonth, Math.min(pricePerWeek, Math.min(pricePerDay, pricePerHour)));
                }
                
                price = price * duration * durationMap.get(durationCategory);
                
                String itemLocation = rs.getString("location");
                //TODO: ADD API KEY
                double distance = getDistance(location, itemLocation, "API_KEY_GOES_HERE");
                if (price >= minPrice && price <= maxPrice && distance <= locationDistance) {
                    item.put("name", itemName);
                    item.put("description", itemDescription);
                    item.put("category", itemCategory);
                    item.put("feature", itemFeature);
                    item.put("price", price);
                    item.put("image", itemImage);
                    if (location != null && !location.isEmpty()) {
                        item.put("distance", distance);
                    }
                    item.put("location", itemLocation);
                    items.add(item);
                }
            }
            
            if (sortBy.equals("location")) {
                for (int i = 0; i < items.size(); i++) {
                    for (int j = i + 1; j < items.size(); j++) {
                        if ((double) items.get(i).get("distance") > (double) items.get(j).get("distance")) {
                            Map<String, Object> temp = items.get(i);
                            items.set(i, items.get(j));
                            items.set(j, temp);
                        }
                    }
                }
            }
            
            if (items.size() == 0) {
                out.println("<h3>No items found with your search conditions. Try something else!</h3>");
            }
            
            for (Map<String, Object> it : items) {
                String itemName = (String) it.get("name");
                String itemDescription = (String) it.get("description");
                String itemCategory = (String) it.get("category");
                String itemFeature = (String) it.get("feature");
                String itemImage = (String) it.get("image");
                String itemLocation = (String) it.get("location");
                double price = (double) it.get("price");
                double distance = -1;
                if (location != null && !location.isEmpty()) {
                    distance = (double) it.get("distance");
                }
                out.println("<div class=\"grid_item\">");
                out.println("    <img src=\"" + itemImage + "\" alt=\"\" class=\"item_image\">");
                out.println("    <div class=\"grid_item_module_1\">");
                out.println("        <div class=\"grid_item_module_2\">");
                out.println("            <div class=\"item_name\">" + itemName + "</div>");
                out.println("            <div class=\"item_module_1\">");
                out.println("                <div class=\"item_category\">" + itemCategory + " - </div>");
                out.println("                <div class=\"item_feature\">" + itemFeature + "</div>");
                out.println("            </div>");
                out.println("            <div class=\"item_location\">" + itemLocation + "</div>");
                out.println("        </div>");
                out.println("        <div class=\"item_price\">$" + String.format("%,.2f", price) + "</div>");
                out.println("    </div>");
                out.println("</div>");   
            }

            con.close();
        } catch (Exception e) {
            out.println(e.getMessage());
            out.println("An error occurred while searching.");
        }
    } else {
        out.println("Please enter a search query or price range.");
        out.println(query);
        out.println(request);
    }
    
%>
