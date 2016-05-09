

import java.io.IOException;

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
			String[] name = new String[2];
			name[0] = request.getParameter("firstname");
			name[1] = request.getParameter("lastname");
			
			String strAge = request.getParameter("Age");
			//boolean isAgeValid = (strAge != null && !strAge.isEmpty());
			//if () System.out.println("This string is null, length is " + strAge.length());
			
			boolean isUserExist = signUpValidate.isUserExist(name);
			if (isUserExist) {
				userSignFailPage(request, response);
			}
			else {
				userSignSuccessPage(request, response);
			}
			
		}
		catch (Exception exc) {
			throw new ServletException(exc);
		}
	}
	
	private void userSignSuccessPage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/sign-up-success.jsp");	
			dispatcher.forward(request, response);
	}

	private void userSignFailPage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/sign-up-fail.jsp");
			dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
