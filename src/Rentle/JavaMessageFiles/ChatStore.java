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
import java.sql.SQLException;

public class ChatStore extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "Hello1234!";

   public ChatStore() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html");

      Connection connection = null;
      PreparedStatement pstmt1 = null;
      PreparedStatement pstmt2 = null;
      ResultSet rs = null;
      PrintWriter out = response.getWriter();

      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Get parameters
         String userId = request.getParameter("userId");
         String messageContent = request.getParameter("msg");
         String groupId = request.getParameter("currentGroupId");

         // Generate new message_id
         int newMessageId = 1; // default message ID if no records exist
         pstmt1 = connection.prepareStatement("SELECT MAX(message_id) FROM messages");
         rs = pstmt1.executeQuery();
         if (rs.next()) {
               int maxMessageId = rs.getInt(1);
               newMessageId = maxMessageId + 1;
         }

         // Insert new message
         pstmt1 = connection.prepareStatement("INSERT INTO messages (message_id, message_content, group_id, user_id) VALUES (?, ?, ?, ?)");
         pstmt1.setInt(1, newMessageId);
         pstmt1.setString(2, messageContent);
         pstmt1.setString(3, groupId);
         pstmt1.setString(4, userId);
         pstmt1.executeUpdate();

         // Update group chat status
         pstmt2 = connection.prepareStatement("UPDATE group_chat g JOIN (SELECT DISTINCT m.group_id FROM messages m JOIN group_chat g ON g.group_id = m.group_id WHERE m.group_id = ?) AS subquery ON g.group_id = subquery.group_id SET g.group_chat_status = 1");
         pstmt2.setString(1, groupId);
         pstmt2.executeUpdate();

         out.println("Message stored successfully.");

      } catch (SQLException e) {
         e.printStackTrace();
         out.println("Database error: " + e.getMessage());
      } catch (ClassNotFoundException e) {
         e.printStackTrace();
         out.println("Driver not found: " + e.getMessage());
      } finally {
         // Close resources
         try {
               if (rs != null) rs.close();
               if (pstmt1 != null) pstmt1.close();
               if (pstmt2 != null) pstmt2.close();
               if (connection != null) connection.close();
         } catch (SQLException e) {
               e.printStackTrace();
               out.println("Error closing resources: " + e.getMessage());
         }
      }
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
   }
}
