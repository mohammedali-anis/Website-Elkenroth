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
@WebServlet("/DeletEditByEditor")
public class DeletEditByEditor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username1 = Servlet.username;
	public static String password1 = Servlet.password;
	public static String user_id;
	public static String user;
	ArrayList<String> al = new ArrayList<String>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeletEditByEditor() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public static void setData(String us) {
		user = us;
	}
	public String getData(){
		return this.user;
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
		this.user_id = request.getParameter("user_id");

		al.add(request.getParameter("user_id"));
		String act = request.getParameter("act");
		//System.out.println(username1 + " " + password1);

		if (act == null) {
			System.out.println("null !! Id is Null here !");
		} else if (act.equals("Löschen")) {
			System.out.println("Delete User Id is " + user_id);

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 1) {
					System.out.println("Found and Loged in as Admin");
					
					RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
//					rd.forward(request, response);
					response.sendRedirect("ManageUser.jsp");
					System.out.println("Found and Loged in as User");
					if (!user_id.equals("cancel")) {
						sqlConnection.sqlDeleteUser(user_id);
						System.out.println("User has been deleted !");
					} else
						System.out.println("User id is null, can not be deleted !");
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {

					System.out.println("Found and Loged in as Editor");
					
					response.sendRedirect("ManageUserByEditor.jsp");
					if (!user_id.equals("cancel")) {
						sqlConnection.sqlDeleteUser(user_id);
						System.out.println("User has been deleted !");
					} else
						System.out.println("User id is null, can not be deleted !");

				} else if (sqlConnection.sqlLogin(username1, password1) == 3) {
//					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (act.equals("Bearbeiten")) {

			if (!user_id.equals("cancel")) {

				System.out.println("Edit User Id is " + user_id);
				//response.sendRedirect("EditUserByEditor.jsp");
				request.setAttribute("user",user_id);
				request.getRequestDispatcher("EditUserByEditor.jsp").forward(request, response);
			} else {
				System.out.println("User id is null, can not be edited !");
				response.sendRedirect("ManageUserByEditor.jsp");
			}
		} else if (act.equals("Aktualisieren")) {

			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String username = request.getParameter("username");
			String email = request.getParameter("email");
			String role = request.getParameter("role");
			String password = request.getParameter("password1");
			String[] sectionArr = request.getParameterValues("section");
			ArrayList<String> selectedSections = new ArrayList<String>();
			for (int i = 0; i < sectionArr.length; i++) {
				selectedSections.add(sectionArr[i]);
			}
			try {
				sqlConnection.sqlUpdateUser(getData(), firstname, lastname, username, password, email, selectedSections, role);
				System.out.println("User has been Updated !");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.sendRedirect("ManageUserByEditor.jsp");
		} else {

		}
	}
}
