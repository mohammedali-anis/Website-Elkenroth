/**
 * @author Mohammed Ali Anis
 */
package elbiscms;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteEditSection
 */
@WebServlet("/DeleteEditSection")
public class DeleteEditSection extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String username1 = Servlet.username;
	public static String password1 = Servlet.password;
	public static String section_id;
	public static String sec;
	ArrayList<String> al = new ArrayList<String>();
	ArrayList<String> al2 = new ArrayList<String>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteEditSection() {
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
		this.section_id = request.getParameter("section_id");
		this.sec = request.getParameter("sec");

		al.add(request.getParameter("user_id"));
		al2.add(request.getParameter("sec"));
		String act = request.getParameter("act");
		// System.out.println(username1 + " " + password1);

		if (act == null) {
			System.out.println("null !! Id is Null here !");
		} else if (act.equals("Löschen ")) {
			System.out.println("Delete Subsection Id is " + section_id);

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 1) {
					System.out.println("Found and Loged in as Admin");

					response.sendRedirect("ManageSection.jsp");
					System.out.println("Found and Loged in as User");
					if (!section_id.equals("cancel")) {
						sqlConnection.sqlDeleteSubsection(section_id);
						System.out.println("Subsection has been deleted !");
					} else
						System.out.println("Subsection id is null, can not be deleted !");
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {

					System.out.println("Found and Loged in as Editor");

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

		} else if (act.equals("Löschen")) {
			System.out.println("Delete Subsection Id is " + section_id);

			try {
				if (sqlConnection.sqlLogin(username1, password1) == 1) {
					System.out.println("Found and Loged in as Admin");

					response.sendRedirect("ManageSection.jsp");
					System.out.println("Found and Loged in as User");
					if (!section_id.equals("cancel2")) {
						sqlConnection.sqlDeleteSection(sec);
						System.out.println("Section has been deleted !");
					} else
						System.out.println("Section id is null, can not be deleted !");
				} else if (sqlConnection.sqlLogin(username1, password1) == 2) {

					System.out.println("Found and Loged in as Editor");

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

		} else if (act.equals("Hinfügen ")) {

			String section_type = request.getParameter("section");
			String subsection = request.getParameter("subsection");

			try {
				sqlConnection.sqlAddSection(section_type, subsection);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Section has been added !");
			response.sendRedirect("ManageSection.jsp");

		} else if (act.equals("Hinfügen")) {

			String section_id = request.getParameter("sectionScroll");
			String subsection = request.getParameter("subsection");

			try {
				sqlConnection.sqlAddSubSection(section_id, subsection);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("Subsection has been added !");
			response.sendRedirect("ManageSection.jsp");

		}

		else if (act.equals("Umbenennen")) {

			
			String section_id = request.getParameter("renameId");
			String section_type = request.getParameter("renameType");
			String [] radioBtn = request.getParameterValues("renameRadioBTN");
			String newName = request.getParameter("newName");
			boolean section;
			if(radioBtn[0].equals("RenameSection"))
				section=true;
			else
				section=false;
				
			if(section) {
				try {
					sqlConnection.sqlRenameSection(section_type, newName);
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			else {
				try {
					sqlConnection.sqlRenameSubsection(section_id, newName);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.sendRedirect("ManageSection.jsp");
			
//			for (int i = 0; i < radioBtn.length; i++) {
//				System.err.println(radioBtn[i]);
//			}
//			System.out.println(section_id);
//			System.out.println(section_type);
//			System.out.println(newName);
			
		}
	}

}
