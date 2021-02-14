
<!--   @author Mohammed Ali Anis -->
 
<%@page import="elbiscms.Servlet"%>
<%@page import="elbiscms.sqlConnection"%>
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

		<form action="DeleteEditBlogByEditor" method="POST">
			<table id="blogs" class="fl-table">
				<thead>
					<tr>
						<th>Beitrag Id</th>
						<th>Beitragstitel</th>
						<th>Von</th>
						<th>Bis</th>
						<th>Bereich Id</th>
						<th>Unterbereich</th>
						<th>Website</th>
						<th>Terminal</th>
						<th>User Id</th>
						<th>Akzeptiert</th>
						<th>Bearbeiten</th>
						<th>Löschen</th>
						<th>An- Abnehemn</th>
					</tr>
				</thead>
				<tbody>

					<%
					Connection connect = null;

					try {

						//			String path = "src/db/ProPraEdited.db";
						//
						//			File file = new File(path);
						//			String absolutePath = file.getAbsolutePath();
						//			connect = DriverManager.getConnection("jdbc:sqlite:" + absolutePath);

						Class.forName("org.sqlite.JDBC");
						connect = sqlConnection.connect();
					} catch (Exception e) {
						e.printStackTrace();
					}

					ResultSet r = null;

					/*
					 * Select blog_id, blog_title,fromDate, toDate,section_id, subsection From Blog
					 * Natural Join User Natural Join Section Where username='username';
					 */
					String Query = "Select blog_id, blog_title, fromDate, toDate, section_id, subsection, website, terminal, user_id, approved From Blog Natural Join User Natural Join Section Natural Join User_Section Where Blog.section_id in ( Select section_id From Section Natural Join User Natural Join User_Section Where username = '"
							+ Servlet.username + "' );";
					Statement s = connect.createStatement();
					r = s.executeQuery(Query);
					while (r.next()) {
						String blog_id = String.valueOf(r.getString("blog_id"));
						String blog_title = r.getString("blog_title");
						String fromDate = r.getString("fromDate");
						String toDate = r.getString("toDate");
						String section_id = r.getString("section_id");
						String subsection = r.getString("subsection");
						String website = r.getString("website");
						String terminal = r.getString("terminal");
						String user_id = r.getString("user_id");
						String approved = r.getString("approved");
					%>
					<tr>
						<td><%=r.getString("blog_id")%></td>
						<td><%=r.getString("blog_title")%></td>
						<td><%=r.getString("fromDate")%></td>
						<td><%=r.getString("toDate")%></td>
						<td><%=r.getString("section_id")%></td>
						<td><%=r.getString("subsection")%></td>
						<td><%=r.getString("website")%></td>
						<td><%=r.getString("terminal")%></td>
						<td><%=r.getString("user_id")%></td>
						<td><%=r.getString("approved")%></td>
						<td><input type="submit" name="act" value="Bearbeiten"
							onClick="deleteConfirm(2)"/></td>
						<td><input type="submit" name="act" value="Löschen"
							onClick="deleteConfirm(1)" /></td>
						<td><input type="button" name="act" value="An- Abnehmen"
							onClick="deleteConfirm(3); show_hide_Section();" /></td>
					</tr>
					<%
					//blogTableModel.addRow(tbData);
					}
					%>

					<input type="hidden" name="blog_id" id="blog_id" />
				<tbody>
			</table>
		
	</div>

	<script>
		//add event listener to table rows
		function deleteConfirm(a) {
			let thetable = document.getElementById('blogs')
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
				var r = confirm("Do you want to delete the blog " + msg + "?");
				if (r != true) {
					msg = "cancel";
				}
				document.getElementById('blog_id').value = msg;
			} else if ( y == 2) {
				var r = confirm("Do you want to edit the blog " + msg + "?");
				if (r != true) {
					msg = "cancel";
				}
				document.getElementById('blog_id').value = msg;
				
			}
			
			
			else {
				
				document.getElementById('blog_id').value = msg;
			}
		};
	</script>


	
		<center>

		<!-- <input type="submit" name="act" value="Add Blog"> -->
		<a href="http://localhost:8081/Project2/AddBlogByEditor.jsp" class = "add">Beitrag Hinfügen</a>

			<!-- <a href = "#">Edit Blog</a>
<a href = "#">Delete Blog</a>  -->
			<a href="http://localhost:8081/Project2/welcomePage.html" class = "add">AUSLOGGEN</a>
		</center>
	
	
	
	
	
	
	<br><br><br>
	
	
	
	<!-- <form action="DeleteEditBlogByEditor" method="POST" id ="check" style="display: none"> -->
	<div id = "check" style="display: none">
	
	<!-- <input type="text" name="check" id="check" />  -->
	
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="radio" id="Rename" name="renameRadioBTN" value="AcceptBlog">
	<label class="lab" for="Rename">Akzeptiere den ausgewählten Beitrag</label>
	<br><br>
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="radio" id="rename" name="renameRadioBTN" value="RejectBlog">
	<label class="lab" for="Rename">den ausgewählte Beitrag ablehnen</label>
	<br><br><br>
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<label class="lab" for="Section">Hinweis : </label> <br><br>
	<center>
	<textarea name="note" placeholder="Write here ..." id="content_input" cols="30" rows="5"></textarea> &nbsp; &nbsp; &nbsp;
	<br><br>
	<input type="submit" name="act" id = "hide" value = "OK" />
	<a href="http://localhost:8081/Project2/ManageBlogByEditor.jsp" class = "cancel" >Abbrechen</a>
	
	</center>
	</div>
	
	
	</form>
	<br><br><br>
	
	
	
	
	
	
	
	
	<script>
	var a;
	function show_hide_Section()
	{
		if(a == 1){
			document.getElementById("check").style.display = "none";
			
			return a = 0;
		}
		else{
			document.getElementById("check").style.display = "";
			
			return a = 1;
		}
	}

	</script>
	
	
	
	
	
	

</body>
</html>