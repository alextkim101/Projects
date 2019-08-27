package ServletPackage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DatabasePackage.DatabaseInsert;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 102 * 1024 * 5 * 5)
@WebServlet("/RegisterUser")
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("fname") + " " + request.getParameter("lname");
		String password = request.getParameter("password");
		String confirm = request.getParameter("Cpassword");
		String email = request.getParameter("email");
		String bio = request.getParameter("bio");
		String nextPage = "/Register.jsp";
			
		String picPath = "";
		for (Part part : request.getParts()) {
			for (String content : part.getHeader("content-disposition").split(";")) {
		        if (content.trim().startsWith("filename")) {
		            String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
			        String extension = "";
					int i = fileName.lastIndexOf('.');
					int p = Math.max(fileName.lastIndexOf('/'), fileName.lastIndexOf('\\'));
					if (i > p) {
					    extension = fileName.substring(i+1);
					}
					picPath = username.replace(' ', '_') + "." + extension;
        		}
			}
		}
		
		if (!password.equals(confirm)) {
			request.getSession(true).setAttribute("reg_error", "The passwords do not match");
		} else if (!DatabaseInsert.registerUser(username, password, email, bio, picPath)) {
			request.getSession(true).setAttribute("reg_error", "That email is already taken");
		} else {
			String uploadPath = getServletContext().getRealPath("");
			uploadPath = uploadPath.substring(0, uploadPath.lastIndexOf(".metadata")) + "CSCI201-Final-PartyPeople/WebContent/images/profile-pics/";
			for (Part part : request.getParts()) {
				part.write(uploadPath + picPath);
			}
			request.getSession(true).setAttribute("loggedin", true);
			request.getSession(true).setAttribute("username", username);
			nextPage = "/HomePage.jsp";
		}
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
