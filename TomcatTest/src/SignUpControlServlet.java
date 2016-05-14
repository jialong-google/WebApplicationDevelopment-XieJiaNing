

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignUpControlServlet
 */
@WebServlet("/SignUpControlServlet")
public class SignUpControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SignUpValidate signUpValidate;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpControlServlet() {
        super();
        
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public void init() throws ServletException {
    	super.init();
    	try {
    		signUpValidate = new SignUpValidate();
    	}
    	catch(Exception e) {
    		throw new ServletException(e);
    	}
    	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String firstName = request.getParameter("firstname");
			String lastName = request.getParameter("lastname");
			
			
			int strAge = Integer.parseInt(request.getParameter("Age"));
			String role = request.getParameter("Role");
			
			String userID = request.getParameter("userID");
			String password = request.getParameter("password");
			String state = request.getParameter("state");
			
			//boolean isAgeValid = (strAge != null && !strAge.isEmpty());
			//if () System.out.println("This string is null, length is " + strAge.length());
			
			signUpValidate.insertUser(firstName, lastName, strAge, role, userID, password,state);
			request.setAttribute("sqlMessage", "Successfully signed up");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/sign-up.jsp");
			dispatcher.forward(request, response);
		}
		catch (SQLException exc) {
			request.setAttribute("sqlMessage", "SQL:" + exc.getMessage());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/sign-up.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
