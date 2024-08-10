<%@ page import="java.sql.*" %>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");
        Statement stmt = conn.createStatement();
        String query = "SELECT group_id, group_chat_status FROM group_chat WHERE group_id = (SELECT MAX(group_id) FROM group_chat) LIMIT 1";
        ResultSet rs = stmt.executeQuery(query);
        int newGroupId = 0;
        while (rs.next()) {
            newGroupId = rs.getInt(1);
            int newGroupStatus = rs.getInt(2);
            if (newGroupStatus != 0) {
                newGroupId = newGroupId + 1;
            }
        }
        out.print(newGroupId);
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
