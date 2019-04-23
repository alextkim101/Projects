package ServletPackage;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DatabasePackage.DatabaseInsert;
import DatabasePackage.DatabaseManager;

/**
 * Servlet implementation class EventServlet
 */
@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseManager.checkDatabase();
		String name = (String)request.getParameter("name");
		String location = (String)request.getParameter("location");
		String date = (String)request.getParameter("date");
		String timeBegin = (String)request.getParameter("start_time");
		String timeEnd = (String)request.getParameter("end_time");
		String details = (String)request.getParameter("details");
		String affiliation = (String)request.getParameter("affiliation");
		String tags = (String)request.getParameter("tags");
		
		Timestamp begin = Timestamp.valueOf(date + " " + timeBegin + ":00");
		Timestamp end = Timestamp.valueOf(date + " " + timeEnd + ":00");
		
		DatabaseInsert.insertEvent((String)request.getSession(true).getAttribute("username"), name, location, begin, end, details, affiliation, tags);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/ProfilePage.jsp");
		dispatch.forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
