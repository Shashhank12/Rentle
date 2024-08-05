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
   public Group() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {

      try {
         var2.setContentType("text/html");
         String groupUsers = var1.getParameter("groupUsers");
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection var4 = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
         String var7 = "SELECT group_id, group_chat_status FROM group_chat WHERE group_id = (SELECT MAX(group_id) FROM group_chat) LIMIT 1";
         Statement var8 = var4.createStatement();
         ResultSet rs = var8.executeQuery(var7);
         int groupId = 0, groupChatStatus = 0;
         while (rs.next()) {
            groupId = rs.getInt(1);
            groupChatStatus = rs.getInt(2);
         }
         if (groupChatStatus != 0) {
            groupId = groupId + 1;
            String insertQuery = "INSERT INTO group_chat (group_id, group_users, group_chat_status) VALUES (?, ?, ?)";
            PreparedStatement pstmt = var4.prepareStatement(insertQuery);
            pstmt.setInt(1, groupId);
            pstmt.setString(2, groupUsers);
            pstmt.setInt(3, 0);
            pstmt.executeUpdate();
            HttpSession var11 = var1.getSession();
            var11.setAttribute("groupId", groupId);
            pstmt.close();
         }
         else {
            String insertQuery2 = "UPDATE group_chat "
            + "JOIN (SELECT MAX(group_id) AS max_id FROM group_chat) AS max_group "
            + "ON group_chat.group_id = max_group.max_id "
            + "SET group_chat.group_users = ?";
            PreparedStatement pstmt2 = var4.prepareStatement(insertQuery2);
            pstmt2.setString(1, groupUsers);
            pstmt2.executeUpdate();
            pstmt2.close();
         }
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
