<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLDecoder" %>

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

    String decodedFeatures = URLDecoder.decode(encodedFeatures, "UTF-8");
    String decodedFilePaths = URLDecoder.decode(encodedFilePaths, "UTF-8");
    Gson gson = new Gson();
    List<String> features = gson.fromJson(decodedFeatures, new TypeToken<List<String>>(){}.getType());
    List<String> filePaths = gson.fromJson(decodedFilePaths, new TypeToken<List<String>>(){}.getType());
        
    // Connect to the database
    String db = "test";
    String user = "root";
    String password = "CS157apass123$";
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);

    // Prepare the SQL statement
    // Schema Items(ItemID, Description, PaymentMethod, Quantity, Name, Condition, PostedDate, Location, Status)
    // Schema Prices(PricesID, PricePerHour, PricePerDay, PricePerWeek, PricePerMonth)
    // Schema RentsFor(ItemID, PricesID)
    String sql = "INSERT INTO Items (Name, Description, `Condition`, Location, Status) VALUES (?, ?, ?, ?, \"Open\")";
    PreparedStatement statement = con.prepareStatement(sql);
    statement.setString(1, itemTitle);
    statement.setString(2, description);
    statement.setString(3, condition);
    statement.setString(4, address);

    // Execute the SQL statement
    statement.executeUpdate();
    
    // Get Last Insert id
    sql = "SELECT LAST_INSERT_ID()";
    statement = con.prepareStatement(sql);
    ResultSet rs = statement.executeQuery();
    rs.next();
    int itemID = rs.getInt(1);
    
    // Schema Has(ItemID, CategoryID)
    // Schema Category(CategoryID, CategoryName)
    // Schema ConsistsOf(CategoryID, FeaturesID)
    // Schema Feature(FeaturesID, FeaturesName)
    
    // Prepare the SQL statement
    sql = "INSERT INTO Category (CategoryName) VALUES (?)";
    statement = con.prepareStatement(sql);
    statement.setString(1, category);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    for (int i = 0; i < features.size(); i++) {
        // Prepare the SQL statement
        try {
            sql = "INSERT INTO Feature (FeaturesName) VALUES (?)";
            statement = con.prepareStatement(sql);
            statement.setString(1, features.get(i));
            
            // Execute the SQL statement
            statement.executeUpdate();
        } catch (Exception e) {}
    }
    
    for (int i = 0; i < features.size(); i++) {
        try {
            // Prepare the SQL statement
            sql = "INSERT INTO ConsistsOf (CategoryID, FeaturesID) VALUES ((SELECT CategoryID FROM Category WHERE CategoryName = ? LIMIT 1), (SELECT FeaturesID FROM Feature WHERE FeaturesName = ? LIMIT 1))";
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
    sql = "INSERT INTO Has (ItemID, CategoryID) VALUES (?, (SELECT CategoryID FROM Category WHERE CategoryName = ? LIMIT 1))";
    statement = con.prepareStatement(sql);
    statement.setInt(1, itemID);
    statement.setString(2, category);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    // Prepare the SQL statement
    sql = "INSERT INTO Prices (PricePerHour, PricePerDay, PricePerWeek, PricePerMonth) VALUES (?, ?, ?, ?)";
    statement = con.prepareStatement(sql);
    statement.setDouble(1, pricePerHour);
    statement.setDouble(2, pricePerDay);
    statement.setDouble(3, pricePerWeek);
    statement.setDouble(4, pricePerMonth);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    // Get Last Insert id
    sql = "SELECT LAST_INSERT_ID()";
    statement = con.prepareStatement(sql);
    rs = statement.executeQuery();
    rs.next();
    int pricesID = rs.getInt(1);
    
    // Prepare the SQL statement
    sql = "INSERT INTO RentsFor (ItemID, PricesID) VALUES (?, ?)";
    statement = con.prepareStatement(sql);
    statement.setInt(1, itemID);
    statement.setInt(2, pricesID);
    
    // Execute the SQL statement
    statement.executeUpdate();
    
    for (int i = 0; i < filePaths.size(); i++) {
        // Prepare the SQL statement
        sql = "INSERT INTO Photos (Photo) VALUES (?)";
        statement = con.prepareStatement(sql);
        statement.setString(1, filePaths.get(i));
        
        // Execute the SQL statement
        statement.executeUpdate();
        
        // Get Last Insert id
        sql = "SELECT LAST_INSERT_ID()";
        statement = con.prepareStatement(sql);
        rs = statement.executeQuery();
        rs.next();
        int photoID = rs.getInt(1);
        
        // Prepare the SQL statement
        sql = "INSERT INTO Contains (ItemID, PhotoID) VALUES (?, ?)";
        statement = con.prepareStatement(sql);
        statement.setInt(1, itemID);
        statement.setInt(2, photoID);
        
        // Execute the SQL statement
        statement.executeUpdate();
    }
    
    
    // Close the database connection
    statement.close();
    con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Added Item</title>
</html>