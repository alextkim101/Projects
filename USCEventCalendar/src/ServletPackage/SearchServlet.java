package ServletPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DatabasePackage.DatabaseManager;
import DatabasePackage.DatabaseQuery;

/**
 * Servlet implementation class NavigationServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DatabaseManager.checkDatabase();
		String search = (String) request.getAttribute("search");
		String this_event = (String)request.getAttribute("this_event"); 
		HttpSession session = request.getSession();
		if(search != null && search.trim().length() != 0) {
			session.setAttribute("currentEvents", DatabaseQuery.searchEvents(search));
			return;
		}
		
		if(this_event != null && this_event.trim().length() > 0) {
			session.setAttribute("this_event", this_event);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/event.jsp");
			dispatch.forward(request, response);
			return;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
