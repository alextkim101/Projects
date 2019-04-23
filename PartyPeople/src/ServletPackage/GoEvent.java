package ServletPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DatabasePackage.DatabaseQuery;
import EventPackage.Event;


@WebServlet("/GoEvent")
public class GoEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("eventID");
		Event e = DatabaseQuery.getEvent(Integer.valueOf(id));
		request.getSession().setAttribute("thisEvent", e);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/Event.jsp");
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
