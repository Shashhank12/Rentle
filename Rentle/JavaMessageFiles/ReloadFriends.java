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

public class ReloadFriends extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "Hello1234!";

   public ReloadFriends() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("application/json");

      Connection connection = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      PrintWriter out = null;

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

        String user1 = "", user2 = "";
        int status = 2;

        if (rs.next()) {
            user1 = rs.getString(1);
            user2 = rs.getString(2);
            status = rs.getInt(3);

        }
         out = response.getWriter();
         out.print(user1 + "," + user2 + "," + status);
         out.flush();

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
            if (out != null) out.close();
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