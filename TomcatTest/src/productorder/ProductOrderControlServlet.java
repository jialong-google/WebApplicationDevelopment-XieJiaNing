package productorder;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ProductOrderControlServlet
 */
@WebServlet(name="ProductOrderServlet",urlPatterns={"/productorder/ProductOrderControlServlet"})
public class ProductOrderControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductOrderControlServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strAction = request.getParameter("action");
		if (strAction.equals("add")){
		addToCart(request);//add product to cart
		}else if (strAction.equals("buy")){
			
			//get message: cart empty or not
			String message = deleteCart(request);
			
			request.setAttribute("message", message);
			//go to confirm page
			RequestDispatcher dispatcher = request.getRequestDispatcher("/confirmpage.jsp");	
			dispatcher.forward(request, response);
		}
		response.sendRedirect("testproductorder2.jsp");
	}

	private String deleteCart(HttpServletRequest request) {
		//get cart
		HttpSession session = request.getSession(true);
		ProductUtil productUtil = null;
		Object objProductUtil = session.getAttribute("cart");
		
		if (objProductUtil != null){
			productUtil = (ProductUtil) objProductUtil;
			//delete cart list
			productUtil.deleteList(session.getAttribute("username"));
			return "notEmpty";
		}else{
			return "empty";
		}
		
		
		
	}

	private void addToCart(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		String strQuantity = request.getParameter("quantity");
		//System.out.println(strQuantity);
		double price = (double)session.getAttribute("price");
		//System.out.println(price);
		String strName = (String)session.getAttribute("pName");
		//System.out.println(strName);
		
		//get cart
		ProductUtil productUtil = null;
		Object objProductUtil = session.getAttribute("cart");
		
		if (objProductUtil != null){
			productUtil = (ProductUtil) objProductUtil;
		}else{
			productUtil = new ProductUtil();
			session.setAttribute("cart", productUtil);
		}
		
		productUtil.addProduct(strName, strQuantity, price);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
