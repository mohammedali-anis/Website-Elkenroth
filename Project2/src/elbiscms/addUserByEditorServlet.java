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
@WebServlet("/addUserByEditorServlet")
public class addUserByEditorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addUserByEditorServlet() {
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
		//this.username = Servlet.username;
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String role = request.getParameter("role");
		String password = request.getParameter("password1");
		String[] sectionArr = request.getParameterValues("section");

		System.out.println(
				firstname + " " + lastname + " " + username + " " + email + " " + role + " " + password);
		ArrayList<String> list = new ArrayList<String>();
		for (int i = 0; i < sectionArr.length; i++) {
			list.add(sectionArr[i]);
		}
		System.err.println(list);
		try {
			sqlConnection.sqlAddUser(firstname, lastname, username, password, email, list, role);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("ManageUserByEditor.jsp");
		System.out.println("User has been added !");
		
		}
	
}
