/**
 * @author Mohammed Ali Anis
 */
package elbiscms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
@WebServlet("/addBlogByEditor")
public class addBlogByEditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addBlogByEditor() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
					+ website + "', '" + terminal + "', 'Yes',(Select user_id from User where username = '" + username + "') ,'?', '-');";
			PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);
			posted1.execute();
			posted1.close();
			System.out.println("Blog has been added!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("EditorFrame.jsp");
		}
	
}
