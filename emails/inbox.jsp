<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html><head><style>
th,td{
font-size:32px;
width:32px;
}
.myCheckBox{font-size:32px;
width:48px;
}
.myButton{font-size:32px;

}
</style></head><body>
    <form action="DeleteInbox.jsp" method="post">
<table border=1 width="90%" align=center><tr><td align=center><a href="inbox.jsp">Inbox</a></td><td align=center><a href="SentBox.jsp">Sentbox</a></td><td align=center><a href="ComposeMail.jsp">ComposeMail</a></td><td align=center><a href="logout.jsp">Logout</a></td></tr></table><br><br>
<center><h1>My SentBox</h1></center><br>
<table border="1" align="center" width="60%">
<tr>
<th>From</th>
<th>Subject</th>
<th><input type=submit class="myButton" value="Delete"></th>
</tr>
<%
String id = request.getParameter("uname");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "emailsoftware";
String userid = "santhosh";
String password = "santhosh123";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
String user_id=session.getAttribute("emailid").toString();
String user_pwd=request.getParameter("pwd");
int flag=0;
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql ="select * from mails where mto='"+user_id+"' and inbox=1";
resultSet = statement.executeQuery(sql);
int mid;
while(resultSet.next()){
mid=Integer.parseInt(resultSet.getString("mid"));
%>
<tr>
<td><%=resultSet.getString("mfrom") %></td>
<td><a href="ReadMail1.jsp?mid=<%=mid%>"><%=resultSet.getString("subject")%></a></td>
<td align=center><input type=checkbox class="myCheckBox" name="deleteList" value="<%=mid%>"></td>

</tr><%
}
%>
</table>
</form>
<%
connection.close();
} catch (Exception e) {
out.println(e.getMessage());
}
%>
