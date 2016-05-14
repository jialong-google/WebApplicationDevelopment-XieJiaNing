package login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginControlServlet
 */
@WebServlet("/LoginControlServlet")
public class LoginControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     * 
     */
	private loginValidate loginvalidate; 

    public LoginControlServlet() {
        super();
        loginvalidate = new loginValidate(); 
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] validate = new String[2];
			validate[0] = request.getParameter("username");
			validate[1] = request.getParameter("password");
			
			boolean isUserSigned = loginvalidate.isUserSigned(validate);
			String userRole = loginvalidate.getUserRole();
			
			if (isUserSigned) {
				HttpSession session = request.getSession();
				session.setAttribute("username", validate[0]);
				session.setAttribute("role", userRole);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/product-order.jsp");//replace with home.jsp	
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("/login-fail.jsp");//replace with home.jsp	
				dispatcher.forward(request, response);
			}
			
		}
		catch (Exception exc) {
			throw new ServletException(exc);
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
