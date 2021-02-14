
<!--   @author Mohammed Ali Anis -->
 
<%@page import="java.util.ArrayList"%>
<%@page import="elbiscms.Servlet"%>
<%@page import="elbiscms.sqlConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Überbereiche und Unterbereiche Verwalten</title>

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
a:link, a:visited {
	background-color: #00A6FB;
	border-radius: 20px;
	color: white;
	padding: 2px 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
}

a:hover, a:active {
	background-color: #3366ff;
}

input[type=submit] {
	background-color: #00A6FB;
	border-radius: 20px;
	color: white;
	padding: 2px 20px;
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
	padding: 5px 25px;
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

.checkBox {
  display: inline-block;
  padding-right: 10px;
  white-space: nowrap;
}
.checkBox {
  vertical-align: middle;
}
.checkBox {
  vertical-align: middle;
}
.lab {

	/* background:-color : #FFFFFF; */
	 color: white;

}
</style>





</head>
<body>

	<h2>
		Bereiche Verwalten Seite
		<%=Servlet.username.toUpperCase()%></h2>
	<div class="table-wrapper">

		<form action="DeleteEditSection" method="POST">
			<table id="blogs" class="fl-table">
				<thead>
					<tr>
						<th>Bereich Id</th>
						<th>Überbereich</th>
						<th>Löschen</th>
						<th>Unterbereich</th>
						<th>Löschen</th>
						<th>Umbenennen</th>

						
					</tr>
				</thead>
				<tbody>

					<%
					ResultSet r = null;

					/*
					 * SELECT user_id from User natural join User_Role Where username='username' AND
					 * password='password'
					 */
					String Query = "Select * From Section ORDER BY section_type ASC;";
					Statement s = sqlConnection.connect().createStatement();
					r = s.executeQuery(Query);
					ArrayList<String> list = new ArrayList<String>();
					while (r.next()) {
						String section_id = r.getString("section_id");
						String section_type = r.getString("section_type");
						String subsection = r.getString("subsection");
					if(list.contains(section_type)){
					%>
					<tr>
						<td><%=section_id%></td>
						<td><%=section_type%></td>
						<td>.</td>
						<td><%=subsection%></td>
						<td><input type="submit" name="act" value="Löschen " onClick="deleteConfirm(1)" /></td>
						<td><input type="button" name="act" value="Umbenennen" onclick = "show_hide_Rename(); deleteConfirm(2);" id = "rr" class = "button" /></td>
						
					</tr>
					<%
					}
					else if (!list.contains(section_type)){
						list.add(section_type);
						%>
						<tr>
							<td><%=section_id%></td>
							<td><%=section_type%></td>
							<td><input type="submit" name="act" value="Löschen" onClick="deleteConfirm(3)" /></td>
							<td><%=subsection%></td>
							<td><input type="submit" name="act" value="Löschen " onClick="deleteConfirm(1)" /></td>
							<td><input type="button" name="act" value="Umbenennen" onclick = "show_hide_Rename(); deleteConfirm(2);" id = "rr" class = "button" /></td>
							
						</tr>
						<%						
					}
					
					
					
					}
					%>

					<input type="hidden" name="section_id" id="section_id" />
					<input type="hidden" name="sec" id="sec" />
				<tbody>
			</table>
			
			
		</form>
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
			let sec = therow.cells[1].innerHTML;
			if (y == 1) {
				var r = confirm("Do you want to delete the Subsection " + msg + "?");
				if (r != true) {
					msg = "cancel";
				}
				document.getElementById('section_id').value = msg;
			} 
			else if( y == 3){
				var r = confirm("Do you want to delete the Section " + sec + "?");
				if (r != true) {
					sec = "cancel2";
				}
				document.getElementById('sec').value = sec;
			}
			else if( y == 2){
				
				document.getElementById('renameType').value = sec;
				document.getElementById('renameId').value = msg;
			}
		};
	</script>


	<form name="ss" >
		<center>

		<!-- <input type="submit" name="act" value="Add Blog"> -->
		<input type="button" name="addSection" value="Überbereich Hinfügen"
		onclick = "show_hide_Section();"
			id = "showSection" class = "button" />
			
							 
		</center>
	</form>
	
	
	
	<form action="DeleteEditSection" method="POST" id ="Subsection" style="display: none">
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
	
		<br><br>
	<center>
	<label class="lab" for="Section">Überbereich : </label>
	
	<select name = "sectionScroll"> &nbsp; &nbsp; &nbsp;
	<option disabled hidden selected>Wählen Sie den Uberbereich aus</option>
        <%
			Connection con = null;
			try{
				String query = "Select DISTINCT section_id, section_type from Section GROUP BY section_type;";
				con = sqlConnection.connect();
				Statement stm = con.createStatement();
				ResultSet rs = stm.executeQuery(query);
				
				while(rs.next())
				{
					%>
					<option value ="<%=rs.getInt("section_id")%>"><%=rs.getString("section_type")%></option>
					<%
				}
			}
			catch(Exception ex){
				ex.printStackTrace();
				out.println("Error" + ex.getMessage());
			}
			con.close();
			%>
	
	</select>
	&nbsp; &nbsp; &nbsp;
	<label class="lab" for="Subsection ">Unterbereich : </label>
	<input type="text" name="subsection" id = "hide" /> &nbsp; &nbsp; &nbsp;
	<input type="submit" name="act" id = "hide" value = "Hinfügen" />
	<a href="http://localhost:8081/Project2/ManageSection.jsp" >Abbrechen</a>
	</form>
	</center>
	
	<form action="DeleteEditSection" method="POST" id ="Section" style="display: none">
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<br><br>
	<center>
	<label class="lab" for="Section">Überbereich : </label>
	<input type="text" name="section" id = "hide" /> &nbsp; &nbsp; &nbsp;
	<label class="lab" for="Subsection ">Unterbereich : </label>
	<input type="text" name="subsection" id = "hide" /> &nbsp; &nbsp; &nbsp;
	<input type="submit" name="act" id = "hide" value = "Hinfügen " />
	<a href="http://localhost:8081/Project2/ManageSection.jsp" >Abbrechen</a>
	
	</center>
	</form>
	<br><br>
	
	













	</center>
	
	<form action="DeleteEditSection" method="POST" id ="Rename"  style="display: none">
	<input type="hidden" name="renameId" id="renameId" />
	<input type="hidden" name="renameType" id="renameType" />
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="radio" id="Rename" name="renameRadioBTN" value="RenameSection">
	<label class="lab" for="Rename">Benennen Sie den ausgewählten Überbereich um : </label>
	<br><br>
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="radio" id="rename" name="renameRadioBTN" value="RenameSubsection">
	<label class="lab" for="Rename">Benennen Sie den ausgewählten Unterbereich um : </label>
	<br><br>
	<center>
	<label class="lab" for="Section">Neuer Name : </label>
	<input type="text" name="newName" id = "hide" /> &nbsp; &nbsp; &nbsp;
	
	<input type="submit" name="act" id = "hide" value = "Umbenennen" />
	<a href="http://localhost:8081/Project2/ManageSection.jsp" >Cancel</a>
	
	</center>
	</form>
	<br><br><br>



























	
	
	
	
	
	<script>
	var a;
	function show_hide_Section()
	{
		if(a == 1){
			document.getElementById("Section").style.display = "none";
			document.getElementById("Subsection").style.display = "";
			return a = 0;
		}
		else{
			document.getElementById("Section").style.display = "";
			document.getElementById("Subsection").style.display = "none";
			return a = 1;
		}
	}

	</script>

	
	<script>
	
	document.getElementById("showSection").addEventListener(
			  "click",
			  function(event) {
			    if (event.target.value === "Überbereich Hinfügen") {
			      event.target.value = "Unterbereich Hinfügen";
			    } else {
			      event.target.value = "Überbereich Hinfügen";
			    }
			  },
			  false
			);
	
	</script>
	
	
	
	
	
	
	
	
	<script>
	var a;
	function show_hide_Rename()
	{
		if(a == 1){
			document.getElementById("Rename").style.display = "none";
			
			return a = 0;
		}
		else{
			document.getElementById("Rename").style.display = "";
			
			return a = 1;
		}
	}

	</script>

	

</body>
</html>