import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Chat extends HttpServlet {

   private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "1Wins4All";

   public Chat() {
      // Default constructor
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html");

      Connection connection = null;
      PreparedStatement statement = null;
      ResultSet resultSet = null;
      PrintWriter out = response.getWriter();

      try {
         // Load JDBC driver
         Class.forName("com.mysql.cj.jdbc.Driver");

         // Establish database connection
         connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

         // Prepare SQL query
         String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
         statement = connection.prepareStatement(sql);

         // Retrieve parameters
         String email = request.getParameter("uname");
         String password = request.getParameter("pw");

         // Set parameters in the prepared statement
         statement.setString(1, email);
         statement.setString(2, password);

         // Execute query
         resultSet = statement.executeQuery();

         if (resultSet.next()) {
            // User authenticated
            String firstName = resultSet.getString("first_name");
            HttpSession session = request.getSession();
            session.setAttribute("name", firstName);
            session.setAttribute("user_id", resultSet.getString("user_id"));
            out.println("Welcome, " + firstName.toUpperCase());
            response.sendRedirect("http://localhost:8080/Rentle");
         } else {
            // Authentication failed
            out.println("Incorrect Username or Password.");
         }

      } catch (Exception e) {
         // Log the error and provide a user-friendly message
         e.printStackTrace();
         response.getWriter().println("An error occurred. Please try again later.");
      } finally {
         // Close resources
         try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
         } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error closing resources: " + e.getMessage());
         }
      }
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // Optionally handle GET requests or remove if not used
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported.");
   }
}
