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
            
            String sql = "SELECT items.itemid, items.name, items.description, prices.priceperhour, prices.priceperday, prices.priceperweek, prices.pricepermonth FROM items JOIN rentsfor USING (ItemID) JOIN prices USING (PricesID) WHERE (items.name LIKE ? OR items.description LIKE ?)";
            
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
            if (!rs.isBeforeFirst()) {
                out.println("No results found.");
            }
            while (rs.next()) {
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

                //TODO LOCATION NEEDS TO BE IMPLEMENTED
                String itemLocation = "San Jose, CA";
                
                if (price != null && price >= minPrice && price <= maxPrice) {
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
            }

            con.close();
        } catch (Exception e) {
            e.getMessage();
            out.println(e);
            out.println("An error occurred while searching.");
        }
    } else {
        out.println("Please enter a search query or price range.");
        out.println(query);
        out.println(request);
    }
%>
