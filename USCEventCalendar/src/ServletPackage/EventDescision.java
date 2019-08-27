package ServletPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DatabasePackage.DatabaseInsert;


@WebServlet("/EventDescision")
public class EventDescision extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String id = request.getParameter("eventID");
		String username = (String) request.getSession().getAttribute("username");
		if (type.equals("interested")) {
			DatabaseInsert.insertInterested(username, Integer.valueOf(id));
		}
		else if (type.equals("attending")) {
			DatabaseInsert.insertAttending(username, Integer.valueOf(id));
		}
		else {
			DatabaseInsert.insertNotAttending(username, Integer.valueOf(id));
		}
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/HomePage.jsp");
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
