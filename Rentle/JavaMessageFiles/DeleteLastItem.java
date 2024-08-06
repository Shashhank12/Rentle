import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DeleteLastItem extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "1Wins4All";

   public DeleteLastItem() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html");

      Connection connection = null;
      PreparedStatement pstmt = null;

      try {
         // Load JDBC driver
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Establish database connection
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Prepare SQL query
         String sql = "DELETE FROM group_chat WHERE group_id = ?";
         pstmt = connection.prepareStatement(sql);

         // Get parameters
         String deletedGroupId = request.getParameter("deletedGroupId");

         // Set parameters in the prepared statement
         pstmt.setString(1, deletedGroupId);

         // Execute the update
         pstmt.executeUpdate();
         
         response.getWriter().println("Group deleted successfully.");

      } catch (Exception e) {
         // Log the error and provide a user-friendly message
         e.printStackTrace();
         response.getWriter().println("An error occurred. Please try again later.");
      } finally {
         // Close resources
         try {
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
