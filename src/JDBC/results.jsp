<%@ page import="java.sql.*, java.util.*" %>
<%
    String query = request.getParameter("query");
    String minPriceStr = request.getParameter("minPrice");
    String maxPriceStr = request.getParameter("maxPrice");
    String durationStr = request.getParameter("duration");
    String durationCategory = request.getParameter("durationCategory");
    String category = request.getParameter("category");
    String feature = request.getParameter("feature");

    double minPrice = minPriceStr != null && !minPriceStr.isEmpty() ? Double.parseDouble(minPriceStr) : 0.0;
    double maxPrice = maxPriceStr != null && !maxPriceStr.isEmpty() ? Double.parseDouble(maxPriceStr) : Double.MAX_VALUE;
    double duration = durationStr != null && !durationStr.isEmpty() ? Double.parseDouble(durationStr) : 1.0;
    
    HashMap<String, Double> durationMap = new HashMap<>();
    durationMap.put("hours", 1.0);
    durationMap.put("days", 24.0);
    durationMap.put("week", 24.0 * 7);
    durationMap.put("month", 24.0 * 30);

    String db = "test";
    String user = "root";
    String password = "CS157apass123$";

    if ((query != null && !query.trim().isEmpty()) || minPriceStr != null || maxPriceStr != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
            
            String sql = "SELECT items.name, items.description, prices.priceperhour, prices.priceperday, prices.priceperweek, prices.pricepermonth FROM items JOIN rentsfor USING (ItemID) JOIN prices USING (PricesID) WHERE (items.name LIKE ? OR items.description LIKE ?)";
            
            if (category != null && !category.equals("all")) {
                sql += " AND items.ItemID IN (SELECT ItemID FROM items JOIN has USING (ItemID) JOIN category USING (CategoryID) WHERE categoryname LIKE ?)";
            }
            
            if (feature != null && !feature.equals("all")) {
                sql += " AND items.ItemID IN (SELECT ItemID FROM items JOIN has USING (ItemID) JOIN consistsof USING (CategoryID) JOIN feature USING (FeaturesID) WHERE FeaturesName LIKE ?)";
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
            
            out.println("<h2>Search Results</h2>");
            while (rs.next()) {
                String itemName = rs.getString("name");
                String itemDescription = rs.getString("description");
                
                Double pricePerHour = rs.getDouble("priceperhour") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperhour");
                Double pricePerDay = rs.getDouble("priceperday") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperday") / 24;
                Double pricePerWeek = rs.getDouble("priceperweek") == 0.0 ? Double.MAX_VALUE : rs.getDouble("priceperweek") / 24 / 7;
                Double pricePerMonth = rs.getDouble("pricepermonth") == 0.0 ? Double.MAX_VALUE : rs.getDouble("pricepermonth") / 24 / 30;
                
                Double price = null;
                if (durationCategory.equals("hours")) {
                    price = pricePerHour;
                } else if (durationCategory.equals("days")) {
                    price = Math.min(pricePerDay, pricePerHour);
                } else if (durationCategory.equals("week")) {
                    price = Math.min(pricePerWeek, Math.min(pricePerDay, pricePerHour));
                } else {
                    price = Math.min(pricePerMonth, Math.min(pricePerWeek, Math.min(pricePerDay, pricePerHour)));
                }
                
                price = price * duration * durationMap.get(durationCategory);
                
                if (price != null && price >= minPrice && price <= maxPrice) {
                    out.println("<h3>" + itemName + "</h3>");
                    out.println("<p>" + itemDescription + "</p>");
                    // Format a price string with 2 decimal places and commas
                    out.println("<p> Price for " + duration + " " + durationCategory + "(s): $" + String.format("%,.2f", price) + "</p>");
                }
            }

            con.close();
        } catch (Exception e) {
            e.getMessage();
            e.printStackTrace();
            out.println("An error occurred while searching.");
        }
    } else {
        out.println("Please enter a search query or price range.");
    }
%>
