import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ChatStore extends HttpServlet {
   public ChatStore() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      try {
         var2.setContentType("text/html");
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
         Statement var5 = var4.createStatement();
         String var6 = var1.getParameter("userId");
         String var7 = var1.getParameter("msg");
         String var8 = var1.getParameter("currentGroupId");
         System.out.println(var6);
         System.out.println(var7);
         String var11 = "SELECT MAX(message_id) FROM messages";
         ResultSet rs = var5.executeQuery(var11);
         int newMessageId = 1; // default message ID if no records exist
         if (rs.next()) {
            int maxMessageId = rs.getInt(1);
            newMessageId = maxMessageId + 1;
         }
         String query = "INSERT INTO messages (message_id, message_content, group_id, user_id) VALUES (?, ?, ?, ?)";
         PreparedStatement pstmt = var4.prepareStatement(query);
         pstmt.setInt(1, newMessageId);
         pstmt.setString(2, var7);
         pstmt.setString(3, var8);
         pstmt.setString(4, var6);
         pstmt.executeUpdate();

         String query2 = "UPDATE group_chat g "
                     + "JOIN (SELECT DISTINCT m.group_id "
                     + "        FROM messages m "
                     + "        JOIN group_chat g ON g.group_id = m.group_id "
                     + "        WHERE m.group_id = ?) AS subquery "
                     + "ON g.group_id = subquery.group_id "
                     + "SET g.group_chat_status = 1";
         PreparedStatement pstmt2 = var4.prepareStatement(query2);
         pstmt2.setString(1, var8);
         pstmt2.executeUpdate();
         pstmt2.close();
         pstmt.close();
         var4.close();
      } catch (Exception var15) {
         var15.printStackTrace();
         System.out.println("Invalid User");
      }

   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      this.doGet(var1, var2);
   }
}
