/**
 * @author Mohammed Ali Anis
 */
package elbiscms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class addBlogServlet
 */
@WebServlet("/addBlogServlet")
public class addBlogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addBlogServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		
//
//	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.username = Servlet.username;
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String website = request.getParameter("website");
		String terminal = request.getParameter("terminal");
		String section_id = request.getParameter("subsection");
		String from = request.getParameter("from");
		String to = request.getParameter("to");

		System.out.println(
				title + " " + content + " " + website + " " + terminal + " " + section_id + " " + from + " " + to);

		if (website == null)
			website = "No";
		else
			website = "Yes";

		if (terminal == null)
			terminal = "No";
		else
			terminal = "Yes";

		/*
		 * insert into Blog (blog_title, blog_description, fromDate, toDate, user_id,
		 * section_id, website, terminal, approved, checkedby_user_id, editedby_user_id)
		 * values ( 'title', 'content', '2020', '2021', (Select user_id from User where
		 * username = 'ezgi.t�fek'), (Select section_id From Section Where subsection
		 * ='Java'),website, terminal, '?', '?', '-');
		 */

		try {
			String query1 = " insert into Blog (blog_title, blog_description, fromDate, toDate, user_id, section_id, website, terminal, approved, writtenby_user_id, checkedby_user_id, editedby_user_id)"
					+ " values ('" + title + "', '" + content + "', '" + from + "', '" + to
					+ "', ( Select user_id from User Where username = '" + username + "'),'" + section_id + "', '"
					+ website + "', '" + terminal + "', '?',(Select user_id from User where username = '" + username
					+ "') ,'?', '-');";
			PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);
			posted1.execute();
			posted1.close();

			ResultSet r2 = null;
			/*
			 * SELECT email FROM User Natural Join User_Section Natural Join Section Natural
			 * Join Role Natural Join User_Role Where subsection = subsection AND role_type
			 * = 'Editor' ORDER BY random() LIMIT 1;
			 */
			String Query2 = "SELECT email, subsection FROM User Natural Join User_Section Natural Join Section Natural Join Role Natural Join User_Role Where section_id = '"
					+ section_id + "' AND role_type = 'Redakteur' ORDER BY random() LIMIT 1;";
			Statement s2 = null;
			String toEmail = null;
			String subsection = null;
			try {
				s2 = sqlConnection.connect().createStatement();
				r2 = s2.executeQuery(Query2);

				while (r2.next()) {
					toEmail = r2.getString("email");
					subsection = r2.getString("subsection");
				}
				s2.close();
				r2.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			SendEmail.emailAddBlog(toEmail, username, title, subsection);

			System.out.println("Blog has been added!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
 			if (sqlConnection.sqlLogin(Servlet.username, Servlet.password) == 3) {
 				RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
 				rd.forward(request, response);
 				}
 			else if (sqlConnection.sqlLogin(Servlet.username, Servlet.password) == 2) {
 				RequestDispatcher rd = request.getRequestDispatcher("EditorFrame.jsp");
 				rd.forward(request, response);
 				}
 			else if (sqlConnection.sqlLogin(Servlet.username, Servlet.password) == 1) {
 				RequestDispatcher rd = request.getRequestDispatcher("AdminFrame.jsp");
 				rd.forward(request, response);
 				}

 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} catch (ServletException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} catch (IOException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

		
	}

}
