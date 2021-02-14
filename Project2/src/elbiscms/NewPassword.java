package elbiscms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/NewPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewPassword() {
		super();
		// TODO Auto-generated constructor stub
	}

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = ForgetPassword.username;
		int code = ForgetPassword.map.get(username);
		int code2 = Integer.parseInt(request.getParameter("code"));
		String newPassword = request.getParameter("newPass");
		String confirmNewPassword = request.getParameter("confirmNewPass");

		System.err.println(code);
		System.out.println(code2);
		System.out.println(newPassword);
		System.out.println(confirmNewPassword);

		if (code == code2 && newPassword.equals(confirmNewPassword)) {

			/*
			 * UPDATE User SET password = 'newPass' Where username = 'mohammedali.anis'; 
			 */
			String query1 = "UPDATE User SET password = '" + newPassword + "' Where username = '" + username + "';";
			try {
				PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);
				posted1.execute();
				
				posted1.close();
				
				response.sendRedirect("Login.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		else {

			response.sendRedirect("Wrong.jsp");
		}

	}

}
