<%@page import="elbiscms.sqlConnection"%>
 <%@page import="elbiscms.Servlet"%>
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 	pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*"%>
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="ISO-8859-1">
 <title>Redakteur Seite</title>

 <style>

 /* Demo Only */
 * {
 	box-sizing: border-box;
 	-webkit-box-sizing: border-box;
 	-moz-box-sizing: border-box;
 }

 body {
 	font-family: Nunito;
 	background: #2C2E3B;
 }

 /* Table Start */
 h2 {
 	text-align: center;
 	font-size: 18px;
 	letter-spacing: 1px;
 	color: white;
 	padding: 30px 0;
 }

 /* Table Styles */
 .table-wrapper {
 	margin: 10px 70px 70px;
 	box-shadow: 0px 35px 50px rgba(0, 0, 0, 0.2);
 }

 .fl-table {
 	border-radius: 5px;
 	font-size: 12px;
 	font-weight: normal;
 	border: none;
 	border-collapse: collapse;
 	width: 100%;
 	max-width: 100%;
 	white-space: nowrap;
 	background-color: white;
 }

 .fl-table td, .fl-table th {
 	text-align: center;
 	padding: 8px;
 }

 .fl-table td {
 	border-right: 1px solid #f8f8f8;
 	font-size: 14px;
 }

 .fl-table thead th {
 	color: #ffffff;
 	background: #00A6FB;
 	font-size: 17px;
 }

 .fl-table thead th:nth-child(odd) {
 	color: #ffffff;
 	background: #00A6FB;
 }

 /*.fl-table tr:nth-child(even) {
     background: #F8F8F8;
 }*/

 /* Responsive */
 @media ( max-width : 767px) {
 	.fl-table {
 		display: block;
 		width: 100%;
 	}
 	.table-wrapper:before {
 		content: "Scroll horizontally >";
 		display: block;
 		text-align: right;
 		font-size: 11px;
 		color: white;
 		padding: 0 0 10px;
 	}
 	.fl-table thead, .fl-table tbody, .fl-table thead th {
 		display: block;
 	}
 	.fl-table thead th:last-child {
 		border-bottom: none;
 	}
 	.fl-table thead {
 		float: left;
 	}
 	.fl-table tbody {
 		width: auto;
 		position: relative;
 		overflow-x: auto;
 	}
 	.fl-table td, .fl-table th {
 		padding: 20px .625em .625em .625em;
 		height: 60px;
 		vertical-align: middle;
 		box-sizing: border-box;
 		overflow-x: hidden;
 		overflow-y: auto;
 		width: 120px;
 		font-size: 13px;
 		text-overflow: ellipsis;
 	}
 	.fl-table thead th {
 		text-align: left;
 		border-bottom: 1px solid #f7f7f9;
 	}
 	/* .fl-table tbody tr {
         display: table-cell;
     }
     .fl-table tbody tr:nth-child(odd) {
         background: none;
     }
     .fl-table tr:nth-child(even) {
         background: transparent;
     }
     .fl-table tr td:nth-child(odd) {
         background: #F8F8F8;
         border-right: 1px solid #E6E4E4;
     }
     .fl-table tr td:nth-child(even) {
         border-right: 1px solid #E6E4E4;
     }*/
 	.fl-table tbody td {
 		display: block;
 		text-align: center;
 	}
 }

 /*.AddBlogBtn{

 background-color: #00A6FB;
     border: none;
     border-radius:20px;
     padding:5px 25px;
     cursor: pointer;
     text-align: center;
 	color: white;
 }*/
 .add:link, .add:visited {
 	background-color: #00A6FB;
 	border-radius: 20px;
 	color: white;
 	padding: 5px 25px;
 	text-align: center;
 	text-decoration: none;
 	display: inline-block;
 }

 .add:hover, .add:active {
 	background-color: #3366ff;
 }

 .cancel:link, .cancel:visited {
 	background-color: #00A6FB;
 	border-radius: 20px;
 	color: white;
 	padding: 2px 20px;
 	text-align: center;
 	text-decoration: none;
 	display: inline-block;
 }

 .cancel:hover, .cancel:active {
 	background-color: #3366ff;
 }

 input[type=submit] {
 	background-color: #00A6FB;
 	border-radius: 20px;
 	color: white;
 	padding: 2px 32px;
 	text-align: center;
 	text-decoration: none;
 	display: inline-block;
 }

 input[type=submit]:hover, input[type=submit]:active {
 	background-color: #3366ff;
 }

 input[type=button] {
 	background-color: #00A6FB;
 	border-radius: 20px;
 	color: white;
 	padding: 2px 20px;
 	text-align: center;
 	text-decoration: none;
 	display: inline-block;
 }

 input[type=button]:hover, input[type=button]:active {
 	background-color: #3366ff;
 }

 tr:hover {
 	background-color: #D8DA5C
 }
 .lab {

 	/* background:-color : #FFFFFF; */
 	 color: white;

 }


 </style>





 </head>
 <body>

 	<h2>
 		Redakteur Seite
 		<%=Servlet.username.toUpperCase()%></h2>
 	<div class="table-wrapper">

 		<form action="loadTemplate" method="POST">
 			<table id="template" class="fl-table">
 				<thead>
 					<tr>
 						<th>Template Id</th>
 						<th>Template Name</th>
 						<th>Bereich Id</th>
 						<th>Unterbereich</th>
 						<th>Website</th>
 						<th>Terminal</th>
 						<th>Laden</th>

 					</tr>
 				</thead>
 				<tbody>

 					<%
 					Connection connect = null;

 					try {

 						Class.forName("org.sqlite.JDBC");
 						connect = sqlConnection.connect();
 					} catch (Exception e) {
 						e.printStackTrace();
 					}

 					ResultSet r = null;

 					
 					String Query = "Select template_id, template_name, user_id,section_id, subsection, website, terminal From Template Natural Join Section where Template.section_id in( Select section_id From Section Natural JOIN User_Section NATURAL Join User Where username ='" + Servlet.username + "'); ";
 							
 					Statement s = connect.createStatement();
 					r = s.executeQuery(Query);
 					while (r.next()) {
 						String template_id = String.valueOf(r.getString("template_id"));
 						String template_name = r.getString("template_name");
 						String section_id = r.getString("section_id");
 						String subsection = r.getString("subsection");
 						String website = r.getString("website");
 						String terminal = r.getString("terminal");
 						
 						
 					%>
 					<tr>
 						<td><%=r.getString("template_id")%></td>
 						<td><%=r.getString("template_name")%></td>
 						<td><%=r.getString("section_id")%></td>
 						<td><%=r.getString("subsection")%></td>
 						<td><%=r.getString("website")%></td>
 						<td><%=r.getString("terminal")%></td>
 						<td><input type="submit" name="act" value="Laden"
 							onClick="deleteConfirm(2)"/></td>

 					</tr>
 					<%
 					//blogTableModel.addRow(tbData);
 					}
 					connect.close();
 					r.close();
 					%>

 					<input type="hidden" name="template_id" id="template_id" />
 				<tbody>
 			</table>

 	</div>


 	<script>
 		//add event listener to table rows
 		function deleteConfirm(a) {
 			let thetable = document.getElementById('template')
 					.getElementsByTagName('tbody')[0];

 			for (let i = 0; i < thetable.rows.length; i++) {
 				thetable.rows[i].onclick = function() {
 					TableRowClick(this, a);
 				};
 			}
 		}

 		function TableRowClick(therow, y) {
 			let msg = therow.cells[0].innerHTML;
 			if (y == 1) {
 				var r = confirm("Do you want to delete the template " + msg + "?");
 				if (r != true) {
 					msg = "cancel";
 				}
 				document.getElementById('template_id').value = msg;
 			} else {
 				var r = confirm("Do you want to load the template " + msg + "?");
 				if (r != true) {
 					msg = "cancel";
 				}
 				document.getElementById('template_id').value = msg;
 			}
 		};
 	</script>




 		<center>


 			<!-- <a href = "#">Load Template</a>

 			<a href="http://localhost:8081/Project2/welcomePage.html" class = "add">Logout</a>
 		</center>
 	
 	
 	
 	
 	
 	
 	<br><br><br>
 	
 	
 	
 	<!-- <form action="addTemplate" method="POST" id ="check" style="display: none"> -->
 	<div id = "check" style="display: none">

 	<!-- <input type="text" name="check" id="check" />  -->




 	</form>
 	<br><br><br>

 </body>
 </html>