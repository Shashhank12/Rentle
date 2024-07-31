<%@ page import="java.sql.*" %>
<%
    // Retrieve the input values from the JSP form
    var title = document.getElementById("add_item_title_input").value;
    var category = document.getElementsByClassName("add_item_category_module")[0].textContent.trim();
    var condition = document.getElementsByClassName("add_item_condition_module")[0].textContent.trim();
    var features = [];
    var featureItems = document.getElementsByClassName("add_item_features_list")[0].children;
    for (var i = 0; i < featureItems.length; i++) {
        features.push(featureItems[i].textContent.trim());
    }
    var description = document.getElementById("add_item_description_input").value;
    var address = document.getElementById("item_location_input_address").value;
    var city = document.getElementById("item_location_input_city").value;
    var state = document.getElementById("item_location_input_state").value;
    var zipCode = document.getElementById("item_location_input_zip_code").value;

    var priceHour = document.getElementById("item_price_hour").value;
    var priceDay = document.getElementById("item_price_day").value;
    var priceWeek = document.getElementById("item_price_week").value;
    var priceMonth = document.getElementById("item_price_month").value;

    String db = "test";
    String user = "root";
    String password = "CS157apass123$";
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);

    // Schema Items(ItemID, Description, PaymentMethod, Quantity, Name, Condition, PostedDate, Location, Status)
    // Schema Prices(PricesID, PricePerHour, PricePerDay, PricePerWeek, PricePerMonth)
    // Schema RentsFor(ItemID, PricesID)
    String sql = "INSERT INTO Items (Name, Description, Condition, Location, Status) VALUES (?, ?, ?, ?, \"Open\")";
    PreparedStatement statement = con.prepareStatement(sql);
    statement.setString(1, itemTitle);
    statement.setString(2, description);
    statement.setString(3, condition);
    statement.setString(4, address + ", " + city + ", " + state + " " + zipCode);

    statement.executeUpdate();
    
    // Schema Has(ItemID, CategoryID)
    // Schema Category(CategoryID, CategoryName)
    // Schema ConsistsOf(CategoryID, FeaturesID)
    // Schema Features(FeaturesID, FeaturesName)
    
    String sql = "INSERT INTO Category (CategoryName) VALUES (?)";
    PreparedStatement statement = con.prepareStatement(sql);
    statement.setString(1, category);
    
    statement.executeUpdate();
    
    for (int i = 0; i < features.length; i++) {
        try {
            String sql = "INSERT INTO Features (FeaturesName) VALUES (?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, features[i]);
            statement.executeUpdate();
        } catch (Exception e) {}
    }
    
    String sql = "INSERT INTO Has (ItemID, CategoryID) VALUES (?, (SELECT CategoryID FROM Category WHERE CategoryName = ?))";
    PreparedStatement statement = con.prepareStatement(sql);
    statement.setString(1, itemTitle);
    statement.setString(2, category);
    
    statement.executeUpdate();
    
    String sql = "INSERT INTO ConsistsOf (CategoryID, FeaturesID) VALUES ((SELECT CategoryID FROM Category WHERE CategoryName = ?), (SELECT FeaturesID FROM Features WHERE FeaturesName = ?))";
     
    statement.close();
    con.close();
%>