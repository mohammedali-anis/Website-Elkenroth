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
 * Servlet implementation class loadTemplate
 */
@WebServlet("/loadTemplate")
public class loadTemplate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username1 = Servlet.username;
	public static String password1 = Servlet.password;
	public static String template_id;
	public static String template;
	public static String role = Servlet.role;
	ArrayList<String> al = new ArrayList<String>();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	public loadTemplate() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static void setData(String bl) {
		template = bl;
	}

	public String getData() {
		return this.template;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.template_id = request.getParameter("template_id");
		al.add(request.getParameter("template_id"));
		String act = request.getParameter("act");
		System.out.println(username1 + " " + password1);

		if (act == null) {
			System.out.println("null !! Id is Null here !");
		} else if (act.equals("Löschen")) {
			System.out.println("Delete Template Id is " + template_id);

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 1) {
					System.out.println("Found and Loged in as Admin");
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {

					System.out.println("Found and Loged in as Editor");

					response.sendRedirect("ManageTemplate.jsp");
					System.out.println("Found and Loged in as User");
					if (!template_id.equals("cancel")) {
						sqlConnection.sqlDeleteTemplate(template_id);
						System.out.println("Template has been deleted !");
					} else
						System.out.println("Blog id is null it can not be deleted !");

				} else if (sqlConnection.sqlLogin(username1, password1) == 3) {
					// RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
					// rd.forward(request, response);

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		else if (act.equals("Laden")) {

			if (!template_id.equals("cancel")) {

				System.out.println("Load Template Id is " + template_id);
				// response.sendRedirect("EditBlogFrame.jsp");
				request.setAttribute("template", template_id);
				request.getRequestDispatcher("Template.jsp").forward(request, response);
			} else {
				System.out.println("Template id is null it can not be loaded !");

				try {
					if (sqlConnection.sqlLogin(username1, password1) == 3) {
						RequestDispatcher rd = request.getRequestDispatcher("TemplateOverview.jsp");
						rd.forward(request, response);
					} else {
						response.sendRedirect("ManageTemplate.jsp");
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
		} else if (act.equals("Bearbeiten")) {

			if (!template_id.equals("cancel")) {

				System.out.println("Edit Template Id is " + template_id);
				// response.sendRedirect("EditBlogFrame.jsp");
				request.setAttribute("template", template_id);
				request.getRequestDispatcher("EditTemplate.jsp").forward(request, response);
			} else {
				System.out.println("Template id is null it can not be loaded !");
				try {
					if (sqlConnection.sqlLogin(username1, password1) == 3) {
						RequestDispatcher rd = request.getRequestDispatcher("TemplateOverview.jsp");
						rd.forward(request, response);
					} else {
						response.sendRedirect("ManageTemplate.jsp");
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
		} else if (act.equals("Send Update Request")) {

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
			try {
				String query1 = "Insert into Blog (blog_title, blog_description, fromDate, toDate, user_id, section_id, website, terminal, approved, writtenby_user_id, checkedby_user_id, editedby_user_id)"
						+ " values ('" + request.getParameter("title") + "', '" + request.getParameter("content")
						+ "', '" + request.getParameter("from") + "', '" + request.getParameter("to")
						+ "', ( Select user_id from User Where username = '" + username1 + "'),'"
						+ request.getParameter("section_id") + "', '" + website1 + "', '" + terminal1
						+ "', '?',(Select user_id from User where username = '" + request.getParameter("username")
						+ "') ,'?', '-');";
				PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);

				posted1.execute();
				posted1.close();
				System.out.println("Blog has been added!");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.err.println("Blog " + getData() + " has been Updated !");

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 3) {
					RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
					rd.forward(request, response);
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {
					RequestDispatcher rd = request.getRequestDispatcher("EditorFrame.jsp");
					rd.forward(request, response);
				} else if (sqlConnection.sqlLogin(username1, password1) == 1) {
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
		else if ( act.equals("Löschen")) {
			try {
				sqlConnection.sqlDeleteTemplate(template_id);
				System.out.println("Template has been deleted !");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
