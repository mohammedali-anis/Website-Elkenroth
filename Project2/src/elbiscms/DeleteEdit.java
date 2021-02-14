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
 * Servlet implementation class DeleteEdit
 */
@WebServlet("/DeleteEdit")
public class DeleteEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username1 = Servlet.username;
	public static String password1 = Servlet.password;
	public static String blog_id;
	public static String blog;
	ArrayList<String> al = new ArrayList<String>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteEdit() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static void setData(String bl) {
		blog = bl;
	}

	public String getData() {
		return this.blog;
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.blog_id = request.getParameter("blog_id");

		al.add(request.getParameter("blog_id"));
		String act = request.getParameter("act");
		System.out.println(username1 + " " + password1);

		if (act == null) {
			System.out.println("null !! Id is Null here !");
		} else if (act.equals("Löschen")) {
			System.out.println("Delete Blog Id is " + blog_id);

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 1) {
					System.out.println("Found and Loged in as Admin");
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {

					System.out.println("Found and Loged in as Editor");

				} else if (sqlConnection.sqlLogin(username1, password1) == 3) {
//					RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
//					rd.forward(request, response);
					response.sendRedirect("UserFrame.jsp");
					System.out.println("Found and Loged in as User");
					if (!blog_id.equals("cancel")) {
						sqlConnection.sqlDeleteBlog(blog_id);
						System.out.println("Blog has been deleted !");
					} else
						System.out.println("Blog id is null it can not be deleted !");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (act.equals("Bearbeiten")) {

			if (!blog_id.equals("cancel")) {

				System.out.println("Edit Blog Id is " + al.get(0));
				// response.sendRedirect("EditBlogFrame.jsp");
				request.setAttribute("blog", blog_id);
				request.getRequestDispatcher("EditBlogFrame.jsp").forward(request, response);
			} else {
				System.out.println("Blog id is null it can not be edited !");
				response.sendRedirect("UserFrame.jsp");
			}
		} else if (act.equals("UPDATE ANFRAGE SENDEN")) {

			String website1 = request.getParameter("website1");
			String terminal1 = request.getParameter("terminal1");
			if (website1 == null)
				website1 = "No";
			else
				website1 = "Yes";

			if (terminal1 == null)
				terminal1 = "No";
			else
				terminal1 = "Yes";

			ResultSet r1 = null;

			/*
			 * Select blog_id, blog_title,fromDate, toDate,section_id, subsection From Blog
			 * Natural Join User Natural Join Section Where username='username';
			 */

			Connection con1 = sqlConnection.connect();
			/*
			 * Update Blog SET blog_title = 'title', blog_description = 'content', fromDate
			 * = 'from', toDate = 'to', editedby_user_id = ( Select user_id from User Where
			 * username = 'username'), section_id = ( Select section_id from Section Where
			 * subsection = 'subsection' ), website = 'website', terminal = 'terminal',
			 * approved = '?' Where blog_id = 'blog_id';
			 */

			try {
				String query1 = "Update Blog SET blog_title = '" + request.getParameter("title")
						+ "', blog_description = '" + request.getParameter("content") + "', fromDate = '"
						+ request.getParameter("from") + "', toDate = '" + request.getParameter("to")
						+ "', editedby_user_id = ( Select user_id from User Where username = '" + username1
						+ "'), section_id = '" + request.getParameter("subsection") + "' , website = '" + website1
						+ "', terminal = '" + terminal1 + "', approved = '?' Where blog_id = '" + getData() + "';";
				PreparedStatement posted1 = con1.prepareStatement(query1);
				posted1.execute();

				con1.close();
				posted1.close();

				ResultSet r2 = null;
				/*
				 * SELECT email FROM User Natural Join User_Section Natural Join Section Natural
				 * Join Role Natural Join User_Role Where subsection = subsection AND role_type
				 * = 'Editor' ORDER BY random() LIMIT 1;
				 */
				String Query2 = "SELECT email, subsection FROM User Natural Join User_Section Natural Join Section Natural Join Role Natural Join User_Role Where section_id = '"
						+ request.getParameter("subsection") + "' AND role_type = 'Redakteur' ORDER BY random() LIMIT 1;";
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

				SendEmail.emailUpdateBlog(toEmail, Servlet.username, request.getParameter("title"), subsection);

			} catch (Exception e) {
				e.printStackTrace();
			}
			System.err.println("Blog " + getData() + " has been Updated !");

			response.sendRedirect("UserFrame.jsp");
		} else {
			System.err.println("other");
		}
	}
}
