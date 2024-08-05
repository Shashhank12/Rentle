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
   public ReloadData() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      try {
         var2.setContentType("text/html");
         String var9 = var1.getParameter("currentGroupIdElement");
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
         String query = "SELECT m.message_content, m.group_id, m.user_id, u.profile_picture FROM rentle.messages m JOIN user u ON m.user_id = u.user_id WHERE m.group_id = ?";
         PreparedStatement pstmt = var3.prepareStatement(query);
         pstmt.setString(1, var9);
         ResultSet var6 = pstmt.executeQuery();

         JSONArray jsonArray = new JSONArray();
         while (var6.next()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("message_content", var6.getString(1));
            jsonObject.put("group_id", var6.getString(2));
            jsonObject.put("user_id", var6.getString(3));
            jsonObject.put("profile_picture", var6.getString(4));
            jsonArray.put(jsonObject);

         }
         PrintWriter out = var2.getWriter();
         out.print(jsonArray.toString());
         var3.close();
      } catch (Exception var12) {
         var12.printStackTrace();
         System.out.println("Something went wrong");
      }

   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      this.doGet(var1, var2);
   }
}
