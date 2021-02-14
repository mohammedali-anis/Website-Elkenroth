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
 * Servlet implementation class addTemplateServlet
 */
@WebServlet("/addTemplate")
public class addTemplate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username;
	public static String template_id;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addTemplate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	// protected void doGet(HttpServletRequest request, HttpServletResponse
	// response)
	// throws ServletException, IOException {
	// // TODO Auto-generated method stub
	//
	//
	// }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.username = Servlet.username;
		String act = request.getParameter("act");

		if (act.equals("Hinfügen")) {
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String website = request.getParameter("website");
			String terminal = request.getParameter("terminal");
			String section_id = request.getParameter("subsection");

			System.out.println(title + " " + content + " " + website + " " + terminal + " " + section_id);

			if (website == null)
				website = "No";
			else
				website = "Yes";

			if (terminal == null)
				terminal = "No";
			else
				terminal = "Yes";

			/*
			 * Insert into Template (Template_name, template_description, user_id,
			 * section_id, website, terminal values ( 'title', 'content', (Select user_id
			 * from User where username = 'ezgi.tüfek'), (Select section_id From Section
			 * Where subsection ='Java'),website, terminal);
			 */

			try {
				String query1 = " insert into Template (template_name, template_description, user_id, section_id, website, terminal)"
						+ " values ('" + title + "', '" + content + "' , ( Select user_id from User Where username = '"
						+ username + "'),'" + section_id + "', '" + website + "', '" + terminal + "');";
				PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);
				posted1.execute();
				posted1.close();
				System.out.println("Template has been added!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.sendRedirect("ManageTemplate.jsp");

		} else if (act.equals("Laden")) {

			template_id = request.getParameter("template_id");
			System.out.println("By Laden ID :" + template_id);
			response.sendRedirect("Template.jsp");

		} else {
			//String template_id = request.getParameter("template_id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String website = request.getParameter("website1");
			String terminal = request.getParameter("terminal1");
			String from = request.getParameter("from");
			String to = request.getParameter("to");
			String section_id = request.getParameter("subsection");

			System.out.println(title + " " + content + " " + website + " " + terminal + " " + section_id);

			if (website == null)
				website = "No";
			else
				website = "Yes";

			if (terminal == null)
				terminal = "No";
			else
				terminal = "Yes";

			try {
				System.err.println("By TUP ID :" + template_id);
				String query1 = "Update Template SET template_name = '" + title + "', template_description = '"
						+ content + "', fromDate = '" + from + "', toDate = '" + to
						+ "', user_id = ( Select user_id from User Where username = '" + username + "'), section_id = '"
						+ section_id + "', website = '" + website + "', terminal = '" + terminal
						+ "' where template_id = '" + addTemplate.template_id + "';";

				PreparedStatement posted1 = sqlConnection.connect().prepareStatement(query1);
				posted1.execute();
				posted1.close();
				System.out.println("Template has been Updated!");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			response.sendRedirect("ManageTemplate.jsp");
		}
	}
}
