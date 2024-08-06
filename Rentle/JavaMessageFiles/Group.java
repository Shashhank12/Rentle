import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Group extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "Hello1234!";

   public Group() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html");

      Connection connection = null;
      Statement statement = null;
      ResultSet resultSet = null;
      PreparedStatement pstmt = null;
      PreparedStatement pstmt2 = null;

      try {
         // Load JDBC driver
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Establish database connection
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Prepare and execute SQL query
         String selectQuery = "SELECT group_id, group_chat_status FROM group_chat WHERE group_id = (SELECT MAX(group_id) FROM group_chat) LIMIT 1";
         statement = connection.createStatement();
         resultSet = statement.executeQuery(selectQuery);

         int groupId = 0;
         int groupChatStatus = 0;

         if (resultSet.next()) {
            groupId = resultSet.getInt(1);
            groupChatStatus = resultSet.getInt(2);
         }

         String groupUsers = request.getParameter("groupUsers");

         if (groupChatStatus != 0) {
            // Insert new group
            groupId += 1;
            String insertQuery = "INSERT INTO group_chat (group_id, group_users, group_chat_status) VALUES (?, ?, ?)";
            pstmt = connection.prepareStatement(insertQuery);
            pstmt.setInt(1, groupId);
            pstmt.setString(2, groupUsers);
            pstmt.setInt(3, 0);
            pstmt.executeUpdate();

            HttpSession session = request.getSession();
            session.setAttribute("groupId", groupId);
         } else {
            // Update existing group
            String updateQuery = "UPDATE group_chat "
                    + "JOIN (SELECT MAX(group_id) AS max_id FROM group_chat) AS max_group "
                    + "ON group_chat.group_id = max_group.max_id "
                    + "SET group_chat.group_users = ?";
            pstmt2 = connection.prepareStatement(updateQuery);
            pstmt2.setString(1, groupUsers);
            pstmt2.executeUpdate();
         }

      } catch (Exception e) {
         e.printStackTrace();
         response.getWriter().println("An error occurred. Please try again later.");
      } finally {
         // Close resources
         try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (pstmt != null) pstmt.close();
            if (pstmt2 != null) pstmt2.close();
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
