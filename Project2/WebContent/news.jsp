
<!--   @author Mohammed Ali Anis -->
 
<%@page import="elbiscms.Datum"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="elbiscms.Servlet"%>
<%@page import="elbiscms.sqlConnection"%>
<!DOCTYPE html>
<html>
<head>
<META HTTP-EQUIV="content-type" CONTENT="text/html; charset=utf-8">
<title>Beiträge</title>
</head>

<Style>


section {
	padding: 60px 0;
}

section h1 {
	font-weight: 700;
	margin-bottom: 10px;
	color: #77C7AC;
}

section p {
	margin-bottom: 30px;
}


img {
  height: 50%;
  width: 50%;
  
}

.icon{

  height: 120%;
  width: 120%;
  

}


section p:last-child {
	margin-bottom: 0;
}

section.color {
	background-color: #f4f4f4;
}




footer {
	background-color: #3c3c3c;
	text-align: center;
   min-height:2em;
   color: #bababa;
}

footer  a {
	display: inline-block;
	margin: 0;
  text-decoration:underline;
}
footer div.col {
  width:20%;
  display:inline-block;
  vertical-align: top;
}
footer col a {
  display:block;
}

footer ul li a:hover {
	color: #fd5559;
}
footer ul li a {
    color: #bababa;  
}
footer div#copy {
  margin-top: 1em;
  padding:0;
}
footer div#copy a {
  color: #fd5559;  
}
footer div.container {
  position:relative;
  
}
footer ul{
  list-style:none;
  margin-top:2em;
  padding:0;
}
footer ul li {
  text-align:left;
  margin:0;
  padding:0;
}


* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Nunito', sans-serif;
}
:root {
    --darkgray: #212329;
    --brightred: #F9423D;
    --white: #FFF;
    --lightred: #F9433DCC;
}
body {
    width: 100%;
    height: 100vh;
}
.nav-container {
    width: 100%;
    background-color: var(--darkgray);
}
.navbar {
    display: grid;
    grid-template-columns: 0.2fr auto 1fr;
    align-items: center;
    height: 80px;
    width: 90%;
    max-width: 1720px;
    margin: 0 auto;
}
#navbar-logo {
    color: var(--white);
    justify-self: start;
    margin-left: 20px;
    cursor: pointer;
}
.nav-menu {
    display: grid;
    grid-template-columns: repeat(5, auto);
    list-style: none;
    text-align: center;
    width: 70%;
    justify-self: end;
}
.nav-links {
    color: white;
    text-decoration: none;
}
.nav-links:hover {
    color: var(--brightred);
    transition: all 0.2s ease-out;
}
.nav-links-btn {
    background-color: var(--brightred);
    padding: 6px 16px;
    border-radius: 4px;
}
.nav-links-btn:hover {
    background-color: transparent;
    color: var(--white);
    padding: 5px 15px;
    border-radius: 4px;
    border: 1px solid var(--brightred);
    transition: all 0.3s ease-out;
}
.menu-toggle {
    cursor: pointer;
}
.menu-toggle .bar {
    width: 25px;
    height: 3px;
    margin: 5px auto;
    transition: all 0.3s ease-in-out;
    background-color: var(--white);
}
@media screen and (max-width: 768px) {
    .nav-container {
        position: relative;
    }
    .nav-menu {
        display: grid;
        grid-template-columns: auto;
        background: var(--brightred);
        margin: 0;
        position: absolute;
        width: 100%;
        top: 80px;
        left: -100%;
        opacity: 0;
        transition: all 0.5s ease;
    }
    #navbar-logo {
        margin-left: 20px;
    }

    .nav-menu.active {
        background-color: var(--darkgray);
        left: 0;
        opacity: 1;
        transition: all 0.5s ease;
    }
    .nav-links {
        text-align: center;
        line-height: 60px;
        width: 100%;
        display: table;
    }
    .nav-links:hover {
        background-color: var(--brightred);
        color: var(--white);
        transition: all 0.4s ease-out;
    }
    .navbar {
        width: 100%;
    }
    .nav-links-btn {
        border: none;
        padding: 0;
        border-radius: 0;
        background-color: var(--darkgray);
        color: var(--white);
        transition: all 0.4s ease-out;
    }
    .nav-links-btn:hover {
        background-color: var(--brightred);
    }
    #mobile-menu {
        position: absolute;
        top: 20%;
        right: 5%;
        transform: translate(5%, 20%);
    }
    .menu-toggle .bar{
        display: block;
    }
    #mobile-menu.is-active .bar:nth-child(2) {
        opacity: 0;
    }
    #mobile-menu.is-active .bar:nth-child(1) {
        transform: translateY(8px) rotate(45deg);
    }
    #mobile-menu.is-active .bar:nth-child(3) {
        transform: translateY(-8px) rotate(-45deg);
    }
}

.weather{
position: absolute;
right:0px;
height: 200px;
  width: 20%;
}

.photo{
margin-top: 100px;
position: absolute;
right: 350px;
left: 320px;
height: 200px;
width: 50%;
}



</Style>



<script type="text/javascript">



function resizeHeaderOnScroll() {
	  const distanceY = window.pageYOffset || document.documentElement.scrollTop,
	  shrinkOn = 200,
	  headerEl = document.getElementById('js-header');
	  
	  if (distanceY > shrinkOn) {
	    headerEl.classList.add("smaller");
	  } else {
	    headerEl.classList.remove("smaller");
	  }
	}

	window.addEventListener('scroll', resizeHeaderOnScroll);
	
</script>


<body>

<form action="Servlet" method = "post">
<div class="nav-container">
      <nav class="navbar">
      
        <p id="navbar-logo"><a href = "http://localhost:8081/Project2/welcomePage.html"><img class= "icon" src = "elkenrothLogo.png"></a></p>
      	  
        
        <div class="menu-toggle" id="mobile-menu">
          <span class="bar"></span>
          <span class="bar"></span>
          <span class="bar"></span>
        </div>
        <ul class="nav-menu">
          <li><a href="http://localhost:8081/Project2/welcomePage.html" class="nav-links">Home</a></li>
          <li><a href="http://localhost:8081/Project2/news.jsp" class="nav-links">Beiträge</a></li>
          <li><a href="#" class="nav-links">Impressum</a></li>
          <li><a href="#" class="nav-links">Kontaktieren Sie Unis</a></li>
            <li><a href="http://localhost:8081/Project2/Login.jsp" class="nav-links nav-links-btn">EINLOGIN</a></li> 
        </ul>
      </nav>
</div>
</form>

  
  

  <div id="main">
      <div id="content">
      
      
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<div class="container p-4">
  <div class="row">
    <div class="col-6">
  <form class = "secform"> 
        <select name = "slct" id="select-manuf" class="form-control" onchange="this.form.submit();">
          <option value="none" >Wählen Sie den Überbereich</option>
          
          
          
           <%
					Connection con = null;

					try {

						Class.forName("org.sqlite.JDBC");
						con = sqlConnection.connect();
					} catch (Exception e) {
						e.printStackTrace();
					}

					ResultSet r1 = null;

					/*
					 * Select DISTINCT section_type from Section;
					 */
					String Query1 = "Select DISTINCT section_type from Section;";
					Statement s1 = con.createStatement();
					r1 = s1.executeQuery(Query1);
					String section_type = null;
					
					while (r1.next()) {
						
						section_type = r1.getString("section_type");
						
						
						if(!r1.getString("section_type").equals(request.getParameter("slct"))){
							%>
							<option value="<%=r1.getString("section_type")%>"><%=r1.getString("section_type")%></option>
							<%
						}
						else {
							%>
							<option value="<%=r1.getString("section_type")%>" selected="selected"><%=r1.getString("section_type")%></option>
							<%
							
						}
						
						
							
						
					}
					r1.close();
					s1.close();
					System.out.println(request.getParameter("slct"));
					%>

        </select>
    </form>
    </div>
    
    
    <div class="col-6">
    <form class = "subsecform" method = "post">
      <select name= "subsection" id="select-mobile" class="form-control" onchange="this.form.submit();">
        <option value="Select your mobile">Wählen Sie den Unterbereich</option>
         <%
					Connection con2 = null;

					try {

						Class.forName("org.sqlite.JDBC");
						con2 = sqlConnection.connect();
					} catch (Exception e) {
						e.printStackTrace();
					}

					ResultSet r2 = null;

					/*
					 * Select subsection From Section;
					 */
					String Query2 = "Select subsection from Section where section_type = '" + request.getParameter("slct") + "';";
					Statement s2 = con.createStatement();
					r2 = s2.executeQuery(Query2);
					while (r2.next()) {
						
						String subsection = r2.getString("subsection");
						
						if(!r2.getString("subsection").equals(request.getParameter("subsection"))){
							%>
							<option value="<%=r2.getString("subsection")%>"><%=r2.getString("subsection")%></option>
							<%
						}
						else {
							
							%>
							<option value="<%=r2.getString("subsection")%>" selected="selected"><%=r2.getString("subsection")%></option>
							<%
							
						}
						
						
					}
					System.err.println(request.getParameter("subsection"));
					r2.close();
					s2.close();
					%>
      </select>
  </form>
    </div>
  </div>
</div>
  
  
      

      
      <%
      
					DateTimeFormatter date = DateTimeFormatter.ofPattern("ddMMyyyy");
					LocalDateTime localDate = LocalDateTime.now();
					String now = date.format(localDate).toString();
					
					
      
      
      				Connection connect = null;

					try {
						Class.forName("org.sqlite.JDBC");
						connect = sqlConnection.connect();
					} catch (Exception e) {
						e.printStackTrace();
					}

					ResultSet r = null;

					/*
					 * Select blog_title, blog_description From Blog
					 */
					 String blog_title = null;
					 String blog_description = null;
					 String fromDate = null;
					 String toDate = null;
					 String firstName = null;
					 String lastName = null;
					 
					
					 String Query = "Select blog_title, blog_description, first_name, last_name, fromDate, toDate From Blog Natural Join User Where website='Yes' and approved = 'Yes' and section_id = ( Select section_id from Section where subsection = '" + request.getParameter("subsection") + "');";
					int cnt = 0;
					Statement s = connect.createStatement();
					r = s.executeQuery(Query);
					
	
					
					while (r.next()) {
						
						blog_title = r.getString("blog_title");
						blog_description = r.getString("blog_description");
						fromDate = r.getString("fromDate");
						toDate = r.getString("toDate");
						firstName = r.getString("first_name");
						lastName = r.getString("last_name");
						
						
						
						boolean boolArr[] = Datum.compareDate(fromDate, toDate);
						
						System.out.println(blog_title + " " + boolArr[0] + " " + boolArr[1]);
						System.out.println();
						
						
					
							
						
						
						
						if(cnt%2==0){
							cnt++;
							%>
							<section class="color" >
          					    <div class="container">
                  					<h1><%=r.getString("blog_title")%></h1>
                  					<p  style="font-size:10px">&nbsp; Veröffentlicht am : <%=r.getString("fromDate")%>, Von : <%=r.getString("last_name").toUpperCase()%>, <%=r.getString("first_name")%></p>
                 						 <p><%=r.getString("blog_description")%></p>
              					</div>
          					</section>	
							<%
						} else {
							cnt++;
							%>
							<section >
             					<div class="container">
                  					<h1><%=r.getString("blog_title")%></h1>
                  					<p name="g" style="font-size:10px">&nbsp; Veröffentlicht am : <%=r.getString("fromDate")%>, Von : <%=r.getString("last_name").toUpperCase()%>, <%=r.getString("first_name")%></p>
                  						<p><%=r.getString("blog_description")%></p>
              					</div>
          					</section>							
							<%
							}
						}
					
					
					r.close();
					s.close();
					%>
         </div>
   <footer>
        <div class="container clearfix">
         
          <div id="copy">© 2010 - 2021 <a href="https://github.com/mohammedali-anis">Mohammed Ali Anis</a>  – Alle Rechte vorbehalten.</div>
        </div>
  </footer>
</div>

</body>
</html>