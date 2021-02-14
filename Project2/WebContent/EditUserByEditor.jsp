
<!--   @author Mohammed Ali Anis -->
 
<%@page import="elbiscms.DeletEditByEditor"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="elbiscms.DeletEditByAdmin"%>
<%@page import="java.util.ArrayList"%>
<%@page import="elbiscms.sqlConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Benutzer Bearbeiten</title>
<style>


body {
  background-color:#2C2E3B;
}

form {
  display:block;
  width:450px;
  height:auto;
  margin:50px auto;
  padding:10px;
  border-radius:15px;
  background-color:#00A6FB;
  font-size:16px;
  font-family:'Arial';
  color:rgb(255, 255, 255)
}

table {
  margin:0 auto;
}

table td {
  vertical-align: top;
}

table td.lbl {
  padding-top:12px;
  font-weight: bold;
}

#title {
  display:block;
  margin:0;
  padding: 20px;
  text-align:center;
  font-size:20px;
  color:#FFFFFF;
}

.textbox {
  width:200px;
  height:auto;
  margin-left:10px;
  padding:10px;
  border:none;
  border-radius:10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.5);
  background-color:#FFFFFF;
  font-size:16px;
  color:rgb(63, 63, 63);
  outline: none;
}

.errtextbox {
  box-shadow: 0 0 10px rgb(255,0,0);
}

.help {
  width:190px;
  display:block;
  margin-bottom:25px;
  padding-left:25px;
  font-size:12px;
  color:rgb(140, 140, 140);
}

#info {
  height:100px;
  resize:none;
}

#send {
  display:block;
  margin:0 auto 10px;
  padding:7px;
  border:none;
  border-radius:10px;
  background-color:#2C2E3B;
  font-size:16px;
  color:#FFFFFF;
}

input[type=submit] {
	background-color: #cc3300;
	border-radius: 20px;
	color: white;
	padding: 2px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	align-content: center;
}

input[type=submit]:hover, input[type=submit]:active {
	background-color: #000066;
}


</style>
</head>
<body>

<%

ArrayList<String> userData = sqlConnection.sqlGetUserData(DeletEditByEditor.user_id);
ArrayList<String> sectionList = new ArrayList<String>();
sectionList = sqlConnection.al;
Set<String> section = new HashSet<>(sectionList);
System.out.println(userData);
System.err.println(section);



%>

  <form action="DeletEditByEditor" method="POST">
  <%String us=(String)request.getAttribute("user");
   DeletEditByEditor.setData(us);
   //out.print(us);
	%>
  <input type="hidden" name="user" id="user" /><br>
  <lable id="title">Benutzer Bearbeiten</lable>
  <table>
    <tboby>
    
      <tr>
        <td class="lbl">Vorname :</td>
        <td><input type="text" name="firstname" id="firstname" value="<%=userData.get(0)%> " class="textbox" required/>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      
      <tr>
        <td class="lbl">Nachname :</td>
        <td><input type="text" name="lastname" id="lastname" value="<%=userData.get(1)%>" class="textbox" required/>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      
       <tr>
        <td class="lbl">Username :</td>
        <td><input type="text" name="username" id="username" value="<%=userData.get(2)%>" class="textbox" required/>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      
      <tr>
        <td class="lbl">E-Mail :</td>
        <td><input type="text" name="email" id="email" value="<%=userData.get(3)%>" class="textbox" required/>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      
      <%
      
      	if(userData.get(4).equals("Redakteur"))
      	{
      		
      		%>
      		 <tr>
       <td class="lbl">Role:</td>
       <td> <select name="role" id="role" class="textbox">
    <option value="Redakteur" selected>Redakteur</option>
    <option value="Benutzer">Benutzer</option>
  </select>
        </tr>
      		<% 
      	}
      	else {
      		
      		%>
     		 <tr>
      <td class="lbl">Role:</td>
      <td> <select name="role" id="role" class="textbox">
   
   <option value="Benutzer" selected>Benutzer</option>
 </select>
       </tr>
     		<% 
      		
      	}
      
      
      %>
      
      
     
       
      
      
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      <tr>
        <td class="lbl">Password :</td>
        <td><input type="password" name="password1" id="password1" value="<%=userData.get(5)%>" class="textbox" required/>
      </tr>
      
      
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      <tr>
        <td class="lbl">Password Bestätigen :</td>
        <td><input type="password" name="password2" id="password2" value="<%=userData.get(5)%>" class="textbox" required/>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      <tr>
        <td class="lbl">Bereiche :</td>
        <td><select name="section" id="section" class="textbox" multiple required>
    
   	 <%
			Connection con = null;
			try{
				String query = "select section_id, subsection From Section ;";
				Class.forName("org.sqlite.JDBC");
				con = sqlConnection.connect();
				Statement stm = con.createStatement();
				ResultSet rs = stm.executeQuery(query);
				
				int index=0;
				while(rs.next())
				{
					if(section.contains(String.valueOf(index))){
					
					%>
					<option value ="<%=rs.getInt("section_id")%>" selected><%=rs.getString("subsection")%></option>
					<%
					}
					else{
						
						%>
						<option value ="<%=rs.getInt("section_id")%>"><%=rs.getString("subsection")%></option>
						<%
						}
					index++;
				}
			}
			catch(Exception ex){
				ex.printStackTrace();
				out.println("Error" + ex.getMessage());
			}
			%>

        </select>
      </tr>
      <tr>
        <td></td>
        <td><lable class="help"></lable></td>
      </tr>
      
      
    </tbody>
  </table>
  <center>
  <input type="submit" name = "act" id="update" value="Aktualisieren" />
  </center>
</form>

<script>

function close(){
	
	
	window.close();
	
}

</script>




</body>
</html>