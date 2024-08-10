<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject"%>

<%
    try {
        java.sql.Connection con;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false","root", "Hello1234!");

        String itemUserId = request.getParameter("itemUserId");

        String name = "", stars = "", description = "", criteria = "";

        String query = "SELECT first_name, last_name, stars, description, criteria from receives JOIN reviews ON (receives.ReviewID = reviews.review_id) JOIN user ON (receives.UserID = user.user_id) WHERE user_id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, itemUserId);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            name = rs.getString(1) + " " + rs.getString(2);
            stars = rs.getString(3);
            description = rs.getString(4);
            criteria = rs.getString(5);
            double starsDouble = Double.parseDouble(stars);
            String formattedStars = String.format("%.1f", starsDouble);
%>
<div class="renting_reviews_list_item_friends_tab">
    <div class="renting_reviews_list_item_1_friends_tab">
        <div class="renting_reviews_list_item_1_module_friends_tab">
            <div class="renting_review_full_name_friends_tab"> <%=name%> </div>
            <div class="renting_review_stars_friends_tab"> <%=formattedStars%> <i class="fas fa-star" id="renting_review_star_icon_1_friends_tab"></i></div>
        </div>
    </div>
    <div class="renting_review_description_friends_tab"> <%=description%> </div>
</div>
<%
        }
        String query2 = "SELECT AVG(stars) from receives JOIN reviews ON (receives.ReviewID = reviews.review_id) GROUP BY UserID HAVING UserID = ?";
        pstmt = con.prepareStatement(query2);
        pstmt.setString(1, itemUserId);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            session.setAttribute("renter_reviews", rs.getString(1));
        }
        else {
            session.setAttribute("renter_reviews", 0.0);
        }
        rs.close();
        pstmt.close();
        con.close();
    } catch(SQLException e) {
        out.println("SQLException: " + e);
    }
%>