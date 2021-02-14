# Elektronisches Bürger-Informationssystem (ELBIS)
### Programmierpraktikum WiSe 2020-21

The project was established and presented as a compulsory course at Siegen University and was supervised by [AR Dr.-Ing. Andreas Hoffmann](https://www.bs.informatik.uni-siegen.de/mitarbeiter/hoffmann/index_html).

The project aims to create a website for the [Elkenroth](https://de.wikipedia.org/wiki/Elkenroth) town in Germany, the website is also a Content Management System with Dashboard where the the adminstartor, editors and user can manage the content of the website.

  - Add and manage Users
  - Edit and delete Blogs
  - Add and edit Sections
  - Create suitable files to be displayed in the information terminals that will be spread out within the town's streets and in the commercial complexes.

### Built with :
-  Jakarta Servlet (formerly Java Servlet)
    - Java servlets are compiled Java classes that implement all or part of a web application. They are not standalone Java programs but must be run by a suitable web server. Though this might seem complicated it actually makes creating and deploying web based applications easier.
- Java Servlet Pages (JSP)
    - is a collection of technologies that helps software developers create dynamically generated web pages based on HTML, XML, SOAP, or other document types. Released in 1999 by Sun Microsystems,[1] JSP is similar to PHP and ASP, but uses the Java programming language.
    To deploy and run Jakarta Server Pages, a compatible web server with a servlet container, such as Apache Tomcat or Jetty, is required.
- Apache Tomcat 9 Version 9.0.43, Jan 28 2021
    - Tomcat includes a web interface for managing the web server. You can use this to upload WAR files into the server, and other configuration tasks. You might also wish to install the Tomcat for Java VS Code extension.
- SQLite
    - SQLite is a popular choice as embedded database software for local/client storage in application software such as web browsers. It is arguably the most widely deployed database engine, as it is used today by several widespread browsers, operating systems, and embedded systems (such as mobile phones), among others.[8] SQLite has bindings to many programming languages.
- Java 8
- JavaScript
- HTML 5
- CSS

### Downloads :

- [Eclipse IDE 2020‑12](https://www.eclipse.org/downloads/)
- [Apache Tomcat 9 Binary](https://tomcat.apache.org/download-90.cgi)
- Java SE Development Kit 8 - Select version specific for your OS.
- [SQLite](https://www.sqlite.org/download.html)

### JAR :
Some JAR Files has been used like
1. sqlite-jdbc-3.30.1.jar
2. activation.jar
3. mail.jar
4. html2pdf-3.0.2.jar
5. ...

to download it please [click here](https://drive.google.com/drive/folders/1k3KljEMjV2-a3GriJ4kH2zjikJbGjsDd?usp=sharing).

### Database :
here is the SQL File to create the database
``` ruby
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Role" (
	"role_id"	INTEGER NOT NULL UNIQUE,
	"role_type"	TEXT NOT NULL,
	PRIMARY KEY("role_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Section" (
	"section_id"	INTEGER,
	"section_type"	TEXT,
	"subsection"	TEXT,
	PRIMARY KEY("section_id")
);
CREATE TABLE IF NOT EXISTS "Media" (
	"media_type"	TEXT,
	"media_id"	INTEGER,
	"blog_id"	INTEGER,
	"file_path"	INTEGER,
	PRIMARY KEY("media_id"),
	FOREIGN KEY("blog_id") REFERENCES "Blog"("blog_id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "User_Role" (
	"user_id"	INTEGER UNIQUE,
	"role_id"	INTEGER,
	FOREIGN KEY("role_id") REFERENCES "Role"("role_id"),
	FOREIGN KEY("user_id") REFERENCES "User"("user_id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "User_Section" (
	"user_id"	INTEGER,
	"section_id"	INTEGER,
	FOREIGN KEY("section_id") REFERENCES "Section"("section_id") ON DELETE CASCADE,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id")
);
CREATE TABLE IF NOT EXISTS "Blog" (
	"blog_id"	INTEGER NOT NULL UNIQUE,
	"blog_title"	TEXT,
	"blog_description"	TEXT,
	"fromDate"	TEXT,
	"toDate"	TEXT,
	"user_id"	INTEGER,
	"section_id"	INTEGER,
	"website"	TEXT,
	"terminal"	TEXT,
	"approved"	TEXT,
	"writtenby_user_id"	INTEGER,
	"editedby_user_id"	INTEGER,
	"checkedby_user_id"	INTEGER,
	"deletedby_user_id"	INTEGER,
	PRIMARY KEY("blog_id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "User"("user_id") ON DELETE CASCADE,
	FOREIGN KEY("editedby_user_id") REFERENCES "User"("user_id") ON DELETE SET NULL,
	FOREIGN KEY("deletedby_user_id") REFERENCES "User"("user_id") ON DELETE SET NULL,
	FOREIGN KEY("section_id") REFERENCES "Section"("section_id") ON DELETE CASCADE,
	FOREIGN KEY("checkedby_user_id") REFERENCES "User"("user_id") ON DELETE SET NULL,
	FOREIGN KEY("writtenby_user_id") REFERENCES "User"("user_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "User" (
	"user_id"	INTEGER NOT NULL,
	"first_name"	TEXT,
	"last_name"	TEXT,
	"username"	TEXT,
	"password"	TEXT,
	"email"	TEXT,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Template" (
	"template_id"	INTEGER NOT NULL UNIQUE,
	"template_name"	TEXT,
	"template_description"	TEXT,
	"fromDate"	TEXT,
	"toDate"	TEXT,
	"user_id"	INTEGER,
	"section_id"	INTEGER,
	"website"	TEXT,
	"terminal"	TEXT,
	PRIMARY KEY("template_id" AUTOINCREMENT),
	FOREIGN KEY("section_id") REFERENCES "Section"("section_id") ON DELETE CASCADE,
	FOREIGN KEY("user_id") REFERENCES "User"("user_id") ON DELETE CASCADE
);
INSERT INTO "Role" VALUES (1,'Admin');
INSERT INTO "Role" VALUES (2,'Redakteur');
INSERT INTO "Role" VALUES (3,'Benutzer');
COMMIT;
```
or by clicking [here](https://drive.google.com/drive/folders/1ayJVX_Q5EvhWqzcnioRuzQOdMRx35_4o?usp=sharing) you can download it as ``` .db ``` file

### Launching :

##### 1. Start the Tomcat server
Navigate to ``` Tomcat/bin ``` and then Execute the ``` startup.sh ``` script for Mac or Linux or ``` startup.bat ``` script for Windows
##### 2. Change the server's port 
You have to change the server's port to to ``` :8081 ```
##### 3. Change the Database path
In the package ``` elbiscms ```, class ``` sqlConnection ``` you have to change the Databse path according to the location on your computer.
So at the line 21 
```ruby
17    public static Connection connect() {
18
19  		Connection connect = null;
20	    	try {
21			    String dbPath = "Users/mohammedalianis/Desktop/ProPraEdited.db";
22			    connect = DriverManager.getConnection("jdbc:sqlite:/" + dbPath);
23		    } catch (Exception e) {
24			    e.printStackTrace();
25		    }
26		    return connect;
27	    }

```
##### 4. Change the PDF Folder path
In the package ``` elbiscms ```, class ``` ConverteHTMLtoPDF ``` you have to change the PDF Folder path according to the location on your computer.
So at the line 37 
```ruby
29  public void converte(String title, String content, String subsection, String from) throws IOException {
        ...
36		    try {
37			    String path = "/Users/mohammedalianis/Desktop/Project 2 _ Updated Version/pdf";
38  
39	    		File file = new File(path);
40		    	String absolutePath = file.getAbsolutePath();
41  
42	    		File theDir = new File(absolutePath + "/" + subsection);
43		    	if (!theDir.exists()) {
44			    	theDir.mkdirs();
45			    }
        ...
74        }
```

##### 5. Running the project
To run the project please go to ``` welcomePage.html ``` which is excested in ``` WebContent ``` Folder and run it on ``` Tomcat v9.0 Server ```
