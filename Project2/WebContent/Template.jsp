<%@page import="elbiscms.addTemplate"%>
<%@page import="elbiscms.loadTemplate"%>
 <%@page import="elbiscms.sqlConnection"%>
 <%@page import="elbiscms.Servlet"%>
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
     pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*" %> 
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="ISO-8859-1">
 <title>Template</title>
 <style>

 @import url(https://fonts.googleapis.com/css?family=Montserrat:400,700);

 html {
   font-family: 'Montserrat', Arial, sans-serif;
   -ms-text-size-adjust: 100%;
   -webkit-text-size-adjust: 100%;
 }

 body {
   background: #2C2E3B;
 }

 button {
   overflow: visible;
 }

 button, select {
   text-transform: none;
 }

 button, input, select, textarea {
   color: #5A5A5A;
   font: inherit;
   margin: 0;
 }

 input {
   line-height: normal;
 }

 textarea {
   overflow: auto;
 }

 #container {
   border: solid 3px #474544;
   max-width: 768px;
   margin: 60px auto;
   position: relative;
   
   background: #ffffff;
 }

 form {
   padding: 37.5px;
   margin: 50px 0;
 }

 h1 {
   color: #474544;
   font-size: 32px;
   font-weight: 700;
   letter-spacing: 7px;
   text-align: center;
   text-transform: uppercase;
 }

 .underline {
   border-bottom: solid 2px #474544;
   margin: -0.512em auto;
   width: 80px;
 }

 .icon_wrapper {
   margin: 50px auto 0;
   width: 100%;
 }

 .icon {
   display: block;
   fill: #474544;
   height: 50px;
   margin: 0 auto;
   width: 50px;
 }

 .to {
 	float: right;
 	width: 45%;
 }

 input[type='text'], [type='text'], select, textarea {
 	background: none;
   border: none;
 	border-bottom: solid 2px #474544;
 	color: #474544;
 	font-size: 1.000em;
   font-weight: 400;
   letter-spacing: 1px;
 	margin: 0em 0 1.875em 0;
 	padding: 0 0 0.875em 0;
   /*text-transform: uppercase;*/
 	width: 100%;
 	-webkit-box-sizing: border-box;
 	-moz-box-sizing: border-box;
 	-ms-box-sizing: border-box;
 	-o-box-sizing: border-box;
 	box-sizing: border-box;
 	-webkit-transition: all 0.3s;
 	-moz-transition: all 0.3s;
 	-ms-transition: all 0.3s;
 	-o-transition: all 0.3s;
 	transition: all 0.3s;
 }

 input[type='text']:focus, [type='text']:focus, textarea:focus {
 	outline: none;
 	padding: 0 0 0.875em 0;
 }

 .content {
 	float: none;
 }

 .from {
 	float: left;
 	width: 45%;
 }

 select {
   background: url('https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-ios7-arrow-down-32.png') no-repeat right;
   outline: none;
   -moz-appearance: none;
   -webkit-appearance: none;
 }

 select::-ms-expand {
   display: none;
 }

 .subsection {
   width: 100%;
 }

 .title {
   width: 100%;
 }

 textarea {
 	line-height: 150%;
 	height: 150px;
 	resize: none;
   width: 100%;
 }

 ::-webkit-input-placeholder {
 	color: #474544;
 }

 :-moz-placeholder { 
 	color: #474544;
 	opacity: 1;
 }

 ::-moz-placeholder {
 	color: #474544;
 	opacity: 1;
 }

 :-ms-input-placeholder {
 	color: #474544;
 }

 #update {
   background: none;
   border: solid 2px #474544;
   color: #474544;
   cursor: pointer;
   display: inline-block;
   font-family: 'Helvetica', Arial, sans-serif;
   font-size: 0.875em;
   font-weight: bold;
   outline: none;
   padding: 20px 35px;
   text-transform: uppercase;
   -webkit-transition: all 0.3s;
 	-moz-transition: all 0.3s;
 	-ms-transition: all 0.3s;
 	-o-transition: all 0.3s;
 	transition: all 0.3s;
 }

 #update:hover {
   background: #474544;
   color: #F2F3EB;
 }

 #cancel_button {
   background: none;
   border: solid 2px #474544;
   color: #474544;
   cursor: pointer;
   display: inline-block;
   font-family: 'Helvetica', Arial, sans-serif;
   font-size: 0.875em;
   font-weight: bold;
   outline: none;
   padding: 20px 35px;
   text-transform: uppercase;
   -webkit-transition: all 0.3s;
 	-moz-transition: all 0.3s;
 	-ms-transition: all 0.3s;
 	-o-transition: all 0.3s;
 	transition: all 0.3s;
 }

 #cancel_button:hover {
   background: #474544;
   color: #F2F3EB;
 }

 @media screen and (max-width: 768px) {
   #container {
     margin: 20px auto;
     width: 95%;
   }
 }

 @media screen and (max-width: 480px) {
   h1 {
     font-size: 26px;
   }
   
   .underline {
     width: 68px;
   }
   
   #form_button {
     padding: 15px 25px;
   }
 }

 @media screen and (max-width: 420px) {
   h1 {
     font-size: 18px;
   }
   
   .icon {
     height: 35px;
     width: 35px;
   }
   
   .underline {
     width: 53px;
   }
   
   input[type='text'], [type='text'], select, textarea {
     font-size: 0.875em;
   }
 }

 </style>
 </head>
 <body>


 <%
 String template_name = null;
 String template_description = null;
 String fromDate = null;
 String toDate = null;
 String subsection = null;
 String section_id = null;
 String website = null;
 String terminal = null;
 ResultSet rs1 = null;
 Statement s1 = null;
 String Query1 = null;

 try{
 	
 	
 	Query1 = "Select template_name, template_description, subsection, section_id, website, terminal From Template Natural Join Section where template_id = '"
 			+ addTemplate.template_id + "' AND section_id = section_id;";
 	s1 = sqlConnection.connect().createStatement();
 	
 	rs1 = s1.executeQuery(Query1);
 	while (rs1.next()) {
 		template_name = rs1.getString("template_name");
 		template_description = rs1.getString("template_description");
 		fromDate ="";
 		toDate = "";
 		subsection = rs1.getString("subsection");
 		section_id = rs1.getString("section_id");
 		website = rs1.getString("website");
 		terminal = rs1.getString("terminal");
 		
 		System.out.println(template_name);
 		System.out.println(template_description);
 		
 		System.out.println(subsection);
 		System.out.println(website);
 		System.out.println(terminal);
 	}
 }
 catch(Exception ex){
 	ex.printStackTrace();
 	out.println("Error" + ex.getMessage());
 }



 %>


 <div id="container">
   <h1>&bull; Template Bearbeiten &bull;</h1>
   <div class="underline">
   </div>

   <form action="addTemplate" method="POST" id="contact_form">
   <%String bl=(String)request.getAttribute("template");
 	loadTemplate.setData(bl);
    //out.print(bl);
 	%>
   <input type="hidden" name="template" id="template" /><br>
     <div class="from">
       <label for="from"></label>
       <input type="text" placeholder="Von" value="<%=""%>" name="from" id="from_input" required>
     </div>
     <div class="to">
       <label for="to"></label>
       <input placeholder="Bis" type="text" value="<%=""%>" name="to" id="to_input" required>
     </div>
     <div class="title">
       <label for="title"></label>
       <input type="text" value="<%=template_name%>" name="title" id="title_input" required>
     </div>
    <div class="subsection">
       <label for="subsection"></label>
       <select placeholder="Unterbereich" name="subsection" id="subsection_input" required>
         <option disabled hidden selected>Wählen Sie den Unterbereich aus</option>
         <%
 			Connection con = null;
     		  ResultSet rs= null;
 			try{
 				String query = "Select * from Section Natural Join User Natural Join User_Section where user_id = ( Select user_id from User where username = '" + Servlet.username + "'); ";
 				System.out.println(Servlet.username);
 				Class.forName("org.sqlite.JDBC");
 				con = sqlConnection.connect();
 				Statement stm = con.createStatement();
 				rs = stm.executeQuery(query);
 				
 				while(rs.next())
 				{
 					%>
 					<option value ="<%=rs.getInt("section_id")%>"><%=rs.getString("subsection")%></option>
 					<%
 				}
 			}
 			catch(Exception ex){
 				ex.printStackTrace();
 				out.println("Error" + ex.getMessage());
 			}
 			
 			finally{
 				if(rs!= null){
 					try {
 						rs.close();
 					}
 					catch(Exception e){
 						e.printStackTrace();
 					}
 				if(con!=null){
 					try {
 						con.close();
 					}
 					catch(Exception e){
 						e.printStackTrace();
 					}
 				}
 				}
 			}
 			%>
 			%>

       </select>
     </div>
     <div class="content">
       <label for="content"></label>
       <textarea name="content" id="content_input" cols="30" rows="5" required><%=template_description%></textarea>
     </div>
     <center>
     <p>
     <% 
     
     
     if(website.equals("Yes")){
     	%> 
     	 <input type="checkbox" name = "website1" id="website1" checked/>
  	  	 <label for="website1">Website</label>
  		 &nbsp &nbsp &nbsp &nbsp
     	<% 
     }
     else{
     	
     	%> 
    	 <input type="checkbox" name = "website1" id="website1" />
 	  	 <label for="website1">Website</label>
 		 &nbsp &nbsp &nbsp &nbsp
   	 	<%
     	
     }
     
     
     if(terminal.equals("Yes")){
     	%> 
     	 <input type="checkbox" name = "terminal1" id="terminal1" checked  />
    		 <label for="terminal1">Terminal</label>

     	<% 
     }
     else{
     	%> 
    	 <input type="checkbox" name = "terminal1" id="terminal1" />
   		 <label for="terminal1">Terminal</label>
 		 &nbsp &nbsp &nbsp &nbsp
    <% 
     	
     }
     
     %>


   </p>



   </p>

   <br>
     <div class="submit">

       <input type="submit" value="Update Anfrage Senden" id = "update" name = "act" onclick="clickAlert()"/>

       <!-- <input type="submit" value="Cancel" id="cancel_button" /> -->
     </div>
     </center>



   </form><!-- // End form -->
 </div><!-- // End #container -->

 <script>
   function clickAlert() {
     alert("Blog has been requested!");
 }
 </script>

 <script src = "ckeditor2/ckeditor.js"></script>
 	<script>
 		CKEDITOR.replace('content');
 	</script>

 </body>