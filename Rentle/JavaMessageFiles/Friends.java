import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.JSONArray;
import org.json.JSONObject;

public class Friends extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "Hello1234!";

   public Friends() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("application/json");

      Connection connection = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
         // Load JDBC driver
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Establish database connection
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Prepare and execute SQL query
         String itemUserId = request.getParameter("itemUserId");
         String currentUserId = request.getParameter("currentUserId");
         String query1 = "SELECT * FROM friends WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
        pstmt = connection.prepareStatement(query1);
        pstmt.setString(1, itemUserId);
        pstmt.setString(2, currentUserId);
        pstmt.setString(3, currentUserId);
        pstmt.setString(4, itemUserId);
        rs = pstmt.executeQuery();


        if (rs.next()) {
            String user1 = rs.getString(1);
            String user2 = rs.getString(2);
            String status = rs.getString(3);
            if (!user1.equals(currentUserId)) {
                String query3 = "UPDATE friends SET status = 1 WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
                PreparedStatement pstmt3 = connection.prepareStatement(query3);
                pstmt3.setString(1, itemUserId);
                pstmt3.setString(2, currentUserId);
                pstmt3.setString(3, currentUserId);
                pstmt3.setString(4, itemUserId);
                pstmt3.executeUpdate();
                pstmt3.close();
            }
            else {
                String query4 = "DELETE FROM friends WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
                PreparedStatement pstmt4 = connection.prepareStatement(query4);
                pstmt4.setString(1, itemUserId);
                pstmt4.setString(2, currentUserId);
                pstmt4.setString(3, currentUserId);
                pstmt4.setString(4, itemUserId);
                pstmt4.executeUpdate();
                pstmt4.close();
            }
            
        } else {
            String query2 = "INSERT INTO friends (FriendUserID1, FriendUserID2, status) VALUES (?, ?, 0)";
            PreparedStatement pstmt2 = connection.prepareStatement(query2);
            pstmt2.setString(1, currentUserId);
            pstmt2.setString(2, itemUserId);
            pstmt2.executeUpdate();
            pstmt2.close();
        }
      } catch (Exception e) {
         e.printStackTrace();
         response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
         response.getWriter().println("An error occurred. Please try again later.");
      } finally {
         // Close resources
         try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (connection != null) connection.close();
         } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error closing resources: " + e.getMessage());
         }
      }
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
   }
}


// <%
//         String getUserInfoQuery3 = "SELECT status FROM friends WHERE (FriendUserID1 = ? AND FriendUserID2 = ?) OR (FriendUserID1 = ? AND FriendUserID2 = ?)";
//         pstmt = con.prepareStatement(getUserInfoQuery3);
//         pstmt.setString(1, currentUserId);
//         pstmt.setString(2, itemUserId);
//         pstmt.setString(3, itemUserId);
//         pstmt.setString(4, currentUserId);
//         rs = pstmt.executeQuery();
//         int status = 2;
//         if (rs.next()) {
//             status = rs.getInt(1);
//         }
// %>
//         <div class="view_user_profile_module_friends_tab">
// <%      if (status == 2) { %>
//             <div class="view_user_profile_module_add_friend_friends_tab" style="background: rgb(231, 198, 198); color: rgb(211, 74, 74);"> Add friend </div>
// <%      } else if (status == 0) { %>
//             <div class="view_user_profile_module_add_friend_friends_tab" style="background: rgb(231, 231, 198); color: rgb(161, 152, 52);"> Pending </div>
// <%      } else { %>
//             <div class="view_user_profile_module_add_friend_friends_tab" style="background: rgb(199, 231, 198); color: rgb(55, 161, 52);"> Friends </div>
// <%      } %>