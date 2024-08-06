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

public class ReloadDataGroup extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1Wins4All";

    public ReloadDataGroup() {
        // Default constructor
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PrintWriter out = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String currentUserId = request.getParameter("currentUserId");

            // Query to get group chat details
            String query = "SELECT * FROM rentle.group_chat WHERE FIND_IN_SET(?, group_users) > 0";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, currentUserId);
            rs = pstmt.executeQuery();

            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
            int groupId = rs.getInt("group_id");
            String groupUsers = rs.getString("group_users");
            String[] users = groupUsers.split(",");
            String profilePic = "";
            String name = "";
            String content = "";
            boolean firstEntry = true;

            for (String user : users) {
                String designatedUser = user.trim();
                // Query to get user profile details
                PreparedStatement pstmt1 = null;
                ResultSet rs1 = null;
                try {
                    String query1 = "SELECT profile_picture, first_name, last_name FROM rentle.user WHERE user_id = ?";
                    pstmt1 = conn.prepareStatement(query1);
                    pstmt1.setString(1, designatedUser);
                    rs1 = pstmt1.executeQuery();

                    if (rs1.next()) {
                        if (!designatedUser.equals(currentUserId)) {
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
                } finally {
                    if (rs1 != null) rs1.close();
                    if (pstmt1 != null) pstmt1.close();
                }

                // Query to get the latest message content
                PreparedStatement pstmt2 = null;
                ResultSet rs2 = null;
                try {
                    String query2 = "SELECT message_content FROM rentle.messages WHERE group_id = ? ORDER BY message_id DESC LIMIT 1";
                    pstmt2 = conn.prepareStatement(query2);
                    pstmt2.setInt(1, groupId);
                    rs2 = pstmt2.executeQuery();

                    if (rs2.next()) {
                        content = rs2.getString("message_content");
                    }
                } finally {
                    if (rs2 != null) rs2.close();
                    if (pstmt2 != null) pstmt2.close();
                }
            }

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("group_id", groupId);
            jsonObject.put("profile_picture", profilePic);
            jsonObject.put("name", name);
            jsonObject.put("content", content);
            jsonArray.put(jsonObject);
            }

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
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
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
