/**
 * @author Mohammed Ali Anis
 */
package elbiscms;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/Servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username;
	public static String password;
	public static String role;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Servlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 * 
	 *      /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.username = request.getParameter("slct");
		this.password = request.getParameter("password");

		try {
			if (sqlConnection.sqlLogin(username, password) == 1) {
				RequestDispatcher rd = request.getRequestDispatcher("AdminFrame.jsp");
				role = "Admin";
				rd.forward(request, response);
				System.out.println("Found and Loged in as Admin");
			} else if (sqlConnection.sqlLogin(username, password) == 2) {
				RequestDispatcher rd = request.getRequestDispatcher("EditorFrame.jsp");
				rd.forward(request, response);
				role = "Editor";
				System.out.println("Found and Loged in as Editor");

			} else if (sqlConnection.sqlLogin(username, password) == 3) {
				RequestDispatcher rd = request.getRequestDispatcher("UserFrame.jsp");
				rd.forward(request, response);
				System.out.println("Found and Loged in as User");
				role = "User";
			} else
				response.sendRedirect("Wrong.jsp");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
