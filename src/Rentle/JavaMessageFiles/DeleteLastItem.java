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

public class DeleteLastItem extends HttpServlet {
   public DeleteLastItem() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {

      try {
         var2.setContentType("text/html");
         String deletedGroupId = var1.getParameter("deletedGroupId");
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
         String var7 = "DELETE FROM group_chat WHERE group_id = ?";
         PreparedStatement var8 = var4.prepareStatement(var7);
         var8.setString(1, deletedGroupId);
         var8.executeUpdate();
         var8.close();
         var4.close();
      } catch (Exception var12) {
         var12.printStackTrace();
         System.out.println("Invalid User");
      }
   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      this.doGet(var1, var2);
   }
}
