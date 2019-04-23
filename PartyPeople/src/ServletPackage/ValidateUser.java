package ServletPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DatabasePackage.DatabaseQuery;


@WebServlet("/ValidateUser")
public class ValidateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String nextPage = "/Login.jsp";
		
		int result = DatabaseQuery.validateUser(email, password);
		if (result == -1) {
			request.getSession(true).setAttribute("login_err","This user does not exist");
		} else if (result == -2) {
			request.getSession(true).setAttribute("login_err", "Incorrect password");
		} else {
			request.getSession(true).setAttribute("loggedin", true);
			request.getSession(true).setAttribute("username", DatabaseQuery.getUsernameFromEmail(email));
			nextPage = "/HomePage.jsp";
		}
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
