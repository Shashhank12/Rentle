<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String itemTitle = request.getParameter("title");
    String description = request.getParameter("description");
    String condition = request.getParameter("condition");
    String address = request.getParameter("address") + ", " + request.getParameter("city") + ", " + request.getParameter("state") + ", " + request.getParameter("zipCode");
    String category = request.getParameter("category");
    String encodedFeatures = request.getParameter("features");
    String encodedFilePaths = request.getParameter("filePaths");
    Double pricePerHour = request.getParameter("priceHour").equals("") ? null : Double.parseDouble(request.getParameter("priceHour"));
    Double pricePerDay = request.getParameter("priceDay").equals("") ? null : Double.parseDouble(request.getParameter("priceDay"));
    Double pricePerWeek = request.getParameter("priceWeek").equals("") ? null : Double.parseDouble(request.getParameter("priceWeek"));
    Double pricePerMonth = request.getParameter("priceMonth").equals("") ? null : Double.parseDouble(request.getParameter("priceMonth"));
    String currentUserId = request.getParameter("currentUserId");

    String decodedFeatures = URLDecoder.decode(encodedFeatures, "UTF-8");
    String decodedFilePaths = URLDecoder.decode(encodedFilePaths, "UTF-8");
    Gson gson = new Gson();
    List<String> features = gson.fromJson(decodedFeatures, new TypeToken<List<String>>(){}.getType());
    List<String> filePaths = gson.fromJson(decodedFilePaths, new TypeToken<List<String>>(){}.getType());
        
    // Connect to the database
    String db = "rentle";
    String user = "root";
    String password = "Hello1234!";
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);

    // Prepare the SQL statement
    // Schema Items(ItemID, Description, PaymentMethod, Quantity, Name, Condition, PostedDate, Location, Status)
    // Schema Prices(PricesID, PricePerHour, PricePerDay, PricePerWeek, PricePerMonth)
    // Schema RentsFor(ItemID, PricesID)

    String sql = "SELECT MAX(item_id) FROM items";
    Statement stmt = con.createStatement();
    ResultSet sql_stmt = stmt.executeQuery(sql);
    int item_id = 1;
    if (sql_stmt.next()) {
        item_id = sql_stmt.getInt(1) + 1;
    }

    sql = "INSERT INTO items (item_id, name, `condition`, description, location, status, quantity, payment_method, posted_date) VALUES (?, ?, ?, ?, ?, \"Open\", 1, \"Card\", NOW())";
    PreparedStatement statement = con.prepareStatement(sql);
    statement.setInt(1, item_id);
    statement.setString(2, itemTitle);
    statement.setString(3, condition);
    statement.setString(4, description);
    statement.setString(5, address);

    // Execute the SQL statement
    statement.executeUpdate();
    
    // Schema Has(ItemID, CategoryID)
    // Schema Category(CategoryID, CategoryName)
    // Schema ConsistsOf(CategoryID, FeaturesID)
    // Schema Feature(FeaturesID, FeaturesName)
    
    // Prepare the SQL statement

    sql = "SELECT MAX(category_id) FROM category";
    stmt = con.createStatement();
    sql_stmt = stmt.executeQuery(sql);
    int category_id = 1;
    if (sql_stmt.next()) {
        category_id = sql_stmt.getInt(1) + 1;
    }

    sql = "INSERT INTO category (category_id, category_name) VALUES (?, ?)";
    statement = con.prepareStatement(sql);
    statement.setInt(1, category_id);
    statement.setString(2, category);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    int features_id = 1;
    for (int i = 0; i < features.size(); i++) {
        // Prepare the SQL statement
        try {
            sql = "SELECT MAX(features_id) FROM features";
            stmt = con.createStatement();
            sql_stmt = stmt.executeQuery(sql);
            if (sql_stmt.next()) {
                features_id = sql_stmt.getInt(1) + 1;
            }

            sql = "INSERT INTO features (features_id, features_name) VALUES (?, ?)";
            statement = con.prepareStatement(sql);
            statement.setInt(1, features_id);
            statement.setString(2, features.get(i));
            
            // Execute the SQL statement
            statement.executeUpdate();
        } catch (Exception e) {}
    }
    
    for (int i = 0; i < features.size(); i++) {
        try {
            // Prepare the SQL statement
            sql = "INSERT INTO consistsof (CategoryID, FeaturesID) VALUES ((SELECT category_id FROM category WHERE category_name = ? LIMIT 1), (SELECT features_id FROM features WHERE features_name = ? LIMIT 1))";
            statement = con.prepareStatement(sql);
            statement.setString(1, category);
            statement.setString(2, features.get(i));
            
            // Execute the SQL statement
            statement.executeUpdate();
        } catch (Exception e) {
            // Avoid duplicate entries
        }
    }
    
    // Prepare the SQL statement

    sql = "INSERT INTO has (ItemID, CategoryID) VALUES (?, (SELECT category_id FROM category WHERE category_name = ? LIMIT 1))";
    statement = con.prepareStatement(sql);
    statement.setInt(1, item_id);
    statement.setString(2, category);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    // Prepare the SQL statement
    sql = "SELECT MAX(prices_id) FROM prices";
    stmt = con.createStatement();
    sql_stmt = stmt.executeQuery(sql);
    int price_id = 1;
    if (sql_stmt.next()) {
        price_id = sql_stmt.getInt(1) + 1;
    }

    sql = "INSERT INTO prices (prices_id, price_per_hour, price_per_day, price_per_week, price_per_month, priced_date) VALUES (?, ?, ?, ?, ?, NOW())";
    statement = con.prepareStatement(sql);
    statement.setInt(1, price_id);
    statement.setDouble(2, pricePerHour);
    statement.setDouble(3, pricePerDay);
    statement.setDouble(4, pricePerWeek);
    statement.setDouble(5, pricePerMonth);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    // Prepare the SQL statement
    sql = "INSERT INTO rentsfor (ItemID, PricesID) VALUES (?, ?)";
    statement = con.prepareStatement(sql);
    statement.setInt(1, item_id);
    statement.setInt(2, price_id);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    for (int i = 0; i < filePaths.size(); i++) {
        // Prepare the SQL statement
        sql = "SELECT MAX(photo_id) FROM photos";
        stmt = con.createStatement();
        sql_stmt = stmt.executeQuery(sql);
        int photo_id = 1;
        if (sql_stmt.next()) {
            photo_id = sql_stmt.getInt(1) + 1;
        }

        sql = "INSERT INTO photos (photo_id, photo) VALUES (?, ?)";
        statement = con.prepareStatement(sql);
        statement.setInt(1, photo_id);
        statement.setString(2, filePaths.get(i));
        
        // Execute the SQL statement
        statement.executeUpdate();
        
        // Prepare the SQL statement
        sql = "INSERT INTO contains (ItemID, PhotoID) VALUES (?, ?)";
        statement = con.prepareStatement(sql);
        statement.setInt(1, item_id);
        statement.setInt(2, photo_id);
        
        // Execute the SQL statement
        statement.executeUpdate();
    }

    sql = "INSERT INTO rent (UserID, ItemID) VALUES (?, ?)";
    statement = con.prepareStatement(sql);
    statement.setString(1, currentUserId);
    statement.setInt(2, item_id);
    statement.executeUpdate();
    
    // Close the database connection
    sql_stmt.close();
    stmt.close();
    statement.close();
    con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Added Item</title>
</html>