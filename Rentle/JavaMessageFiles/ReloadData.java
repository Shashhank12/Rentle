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

public class ReloadData extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "Hello1234!";

   public ReloadData() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("application/json");

      Connection connection = null;
      PreparedStatement pstmt = null;
      ResultSet resultSet = null;
      PrintWriter out = null;

      try {
         // Load JDBC driver
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Establish database connection
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Prepare and execute SQL query
         String groupId = request.getParameter("currentGroupIdElement");
         String query = "SELECT m.message_content, m.group_id, m.user_id, u.profile_picture FROM rentle.messages m JOIN user u ON m.user_id = u.user_id WHERE m.group_id = ?";
         pstmt = connection.prepareStatement(query);
         pstmt.setString(1, groupId);
         resultSet = pstmt.executeQuery();

         // Create JSON array and populate with results
         JSONArray jsonArray = new JSONArray();
         while (resultSet.next()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("message_content", resultSet.getString(1));
            jsonObject.put("group_id", resultSet.getString(2));
            jsonObject.put("user_id", resultSet.getString(3));
            jsonObject.put("profile_picture", resultSet.getString(4));
            jsonArray.put(jsonObject);
         }

         // Write JSON response
         out = response.getWriter();
         out.print(jsonArray.toString());
         out.flush();

      } catch (Exception e) {
         e.printStackTrace();
         response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
         response.getWriter().println("An error occurred. Please try again later.");
      } finally {
         // Close resources
         try {
            if (resultSet != null) resultSet.close();
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
