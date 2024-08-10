<%@ page import="java.sql.*,java.util.ArrayList,java.time.*,java.time.temporal.ChronoUnit,java.time.format.DateTimeFormatter,java.time.format.*,java.util.Locale, java.util.List, java.util.ArrayList, org.json.JSONArray, org.json.JSONObject, java.util.Collections"%>

<%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentle?autoReconnect=true&useSSL=false", "root", "Hello1234!");

            String currentGroupId = request.getParameter("currentGroupIdElement");
            String userId = request.getParameter("currentUserId");

            String query = "SELECT group_users FROM rentle.group_chat WHERE group_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, currentGroupId);
            ResultSet rs = pstmt.executeQuery();

            ArrayList<String> membersList = new ArrayList<>();
                
            if (rs.next()) {
                String[] membersArray = rs.getString(1).split(",");
                Collections.addAll(membersList, membersArray);
            }
            ArrayList<String> result = new ArrayList<>();

            if (membersList.size() == 2) {
                result.add(membersList.get(0).equals(userId) ? membersList.get(1) : membersList.get(0));
            } else {
                for (int i = membersList.size() - 1; i >= 0; i--) {
                    if (!membersList.get(i).equals(userId)) {
                        result.add(membersList.get(i));
                    }
                }
            }
                
            if (result.size() != 0) {
                String name = "", profilePic = "";
                String query2 = "SELECT profile_picture, first_name, last_name FROM user WHERE user_id = ?";
                pstmt = conn.prepareStatement(query2);
                pstmt.setString(1, result.get(0));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    profilePic = rs.getString(1);
                    name += rs.getString(2) + " " + rs.getString(3);
                }

                if (result.size() == 2) {
                    String query3 = "SELECT profile_picture, first_name, last_name FROM user WHERE user_id = ?";
                    pstmt = conn.prepareStatement(query3);
                    pstmt.setString(1, result.get(1));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        name += ", " + rs.getString(2) + " " + rs.getString(3);
                    }
                }
%>
        <img src="<%=profilePic%>" onerror="this.src='images/profilepicgroup.png';" class="messages_person_module_profile_picture">
        <div class="messages_person_module_user_name"> <%=name%> </div>
<%           }
        } catch (SQLException e) {
            out.println("SQLException: " + e.getMessage());
        }
%>