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
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

public class ReloadDataGroup extends HttpServlet {
   public ReloadDataGroup() {
   }

   public void doPost(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
    try {
        var2.setContentType("text/html");
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

        String var3 = var1.getParameter("currentUserId");

        // Query to get group chat details
        String query = "SELECT * FROM rentle.group_chat WHERE FIND_IN_SET(?, group_users) > 0";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, var3);
        ResultSet rs = pstmt.executeQuery();

        JSONArray jsonArray = new JSONArray();
        while (rs.next()) {
            int group_id = rs.getInt("group_id");
            String groupUsers = rs.getString("group_users");
            String[] users = groupUsers.split(",");
            String profilePic = "";
            String name = "";
            String content = "";
            boolean firstEntry = true;
            
            for (String user : users) {
                String designatedUser = user.trim();
                // Query to get user profile details
                String query1 = "SELECT profile_picture, first_name, last_name FROM rentle.user WHERE user_id = ?";
                PreparedStatement pstmt1 = conn.prepareStatement(query1);
                pstmt1.setString(1, designatedUser);
                ResultSet rs1 = pstmt1.executeQuery();

                if (rs1.next()) {
                    if (!designatedUser.equals(var3)) {
                        profilePic = rs1.getString("profile_picture");
                        String firstName = rs1.getString("first_name");
                        String lastName = rs1.getString("last_name");
                        if (firstEntry) {
                            name += firstName + " " + lastName;
                            firstEntry = false;
                        } else {
                            name += ", " + firstName + " " + lastName;
                        }
                    }
                }
                rs1.close();
                pstmt1.close();

                // Query to get the latest message content
                String query2 = "SELECT message_content FROM rentle.messages WHERE group_id = ? ORDER BY message_id DESC LIMIT 1";
                PreparedStatement pstmt2 = conn.prepareStatement(query2);
                pstmt2.setInt(1, group_id);
                ResultSet rs2 = pstmt2.executeQuery();

                if (rs2.next()) {
                    content = rs2.getString("message_content");
                }
                rs2.close();
                pstmt2.close();
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("group_id", group_id);
            jsonObject.put("profile_picture", profilePic);
            jsonObject.put("name", name);
            jsonObject.put("content", content);
            jsonArray.put(jsonObject);
        }
        PrintWriter out = var2.getWriter();
        out.print(jsonArray.toString());
        rs.close();
        pstmt.close();
        conn.close();
      } catch (Exception var12) {
         var12.printStackTrace();
      }

   }

   public void doGet(HttpServletRequest var1, HttpServletResponse var2) throws ServletException, IOException {
      this.doGet(var1, var2);
   }
}
