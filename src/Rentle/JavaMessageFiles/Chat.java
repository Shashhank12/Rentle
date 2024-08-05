import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Chat extends HttpServlet {
   public Chat() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      PrintWriter var3 = var2.getWriter();

      try {
         var2.setContentType("text/html");
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
         Statement var5 = var4.createStatement();
         String var6 = var1.getParameter("uname");
         System.out.println(var6);
         String var7 = var1.getParameter("pw");
         System.out.println(var7);
         String var8 = "select * from user where email ='" + var6 + "' AND password='" + var7 + "'";
         ResultSet var9 = var5.executeQuery(var8);
         if (var9.next()) {
            String var10 = var9.getString("first_name");
            HttpSession var11 = var1.getSession();
            var11.setAttribute("name", var10);
            String var12 = var9.getString("user_id");
            var11.setAttribute("user_id", var12);
            var3.println("Welcome, " + var10.toUpperCase());
         } else {
            var3.println("Incorrect Username or Password.");
         }

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
