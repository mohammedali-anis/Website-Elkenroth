package elbiscms;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ForgetPassword
 */
@WebServlet("/ForgetPassword")
public class ForgetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static HashMap<String, Integer> map = new HashMap<String, Integer>();
	static String username = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ForgetPassword() {
		super();
		// TODO Auto-generated constructor stub
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
		username = request.getParameter("username");
		System.out.println(username);

		ResultSet r = null;
		Statement s = null;
		String email = "";
		try {

			/*
			 * Select email From User Where username = 'mohammedali.anis'
			 */
			String Query = "Select email From User Where username = '" + username + "';";
			s = sqlConnection.connect().createStatement();
			r = s.executeQuery(Query);
			while (r.next()) {
				email = r.getString("email");
			}
			r.close();
			s.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(!email.equals("")) {
		Random random = new Random();
		
		int randomCode = Integer.parseInt(String.format("%04d", random.nextInt(10000))); 
		
		map.put(username, randomCode);

		SendEmail.emailResetPassword(email, map.get(username));
		response.sendRedirect("NewPassword.jsp");
		}
		else
			response.sendRedirect("Wrong.jsp");
	}

}
