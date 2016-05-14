package product;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class ProductControllerServlet
 */
@WebServlet("/ProductControllerServlet")
public class ProductControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ProductDbUtil productDbUtil;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public void init() throws ServletException {
    	super.init();
    	try {
    		Class.forName("org.postgresql.Driver");
    		Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/main?" + "user=postgres&password=mn1987");
    		productDbUtil = new ProductDbUtil(conn);
    	}
    	catch(Exception e) {
    		throw new ServletException(e);
    	}
    	
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String theCommand = request.getParameter("command");
			if (theCommand == null) {
				theCommand = "other";
			}
			
			switch(theCommand) {
				case "SETUP":
					setUpCategory(request, response);
					break;
				case "CATEGORY":
					listCategoryProduct(request, response);
					break;
				case "ADD":
					addProduct(request, response);
					break;
				case "SEARCH":
					listSearchProduct(request, response);
					break;
				case "ALLPRODUCTS":
					listAllProduct(request, response);
					break;
				case "LOAD":
					loadProduct(request, response);
					break;
				case "UPDATE":
					updateProduct(request, response);
					break;
				case "DELETE":
					deleteProduct(request, response);
					break;
				default:
					RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
					dispatcher.forward(request, response);
			}
		}
		catch(SQLException exc) {
			//exc.printStackTrace();
			request.setAttribute("sqlMessage", "SQL:" + exc.getMessage());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	//TO BE DELETED
	private void setUpCategory(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		// TODO Auto-generated method stub
		List<String> categoryList = productDbUtil.getCategory();
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
		dispatcher.forward(request, response);
		
		HttpSession session = request.getSession();
	    session.setAttribute("category_list", categoryList);
		
	}
	
	private void listCategoryProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException,ServletException, IOException {
		List<Product> products = productDbUtil.getCategoryProducts(request.getParameter("category"));
		request.setAttribute("productList", products);
			
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
		dispatcher.forward(request, response);
				
	}
	
	private void addProduct(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		try {
			String productName = request.getParameter("productName");
			productName = (productName == "") ? null : productName; 
			
			String category = request.getParameter("category");
			category = (category == "") ? null : category;
			
			String sku = request.getParameter("sku");
			sku = (sku == "") ? null : sku;
			
			float price = Float.parseFloat(request.getParameter("price"));
			
			Product theProduct = new Product(productName, category, sku, price);
			productDbUtil.addProduct(theProduct);
			
			request.setAttribute("sqlMessage", "Product is successfully inserted");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
			dispatcher.forward(request, response);
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		
	}
	
	private void listAllProduct(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		List<Product> products = productDbUtil.getAllProducts(request.getParameter("category"));
		request.setAttribute("productList", products);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
		dispatcher.forward(request, response);
		// TODO Auto-generated method stub
		
	}
	
	private void listSearchProduct(HttpServletRequest request,
			HttpServletResponse response)  throws SQLException,ServletException, IOException {
		// TODO Auto-generated method stub
		String searchCategory = request.getParameter("searchCategory");
		String searchString = request.getParameter("searchString");
		request.setAttribute("searchString", searchString);
		request.setAttribute("searchCategory", searchCategory);

		List<Product> products = productDbUtil.getSearchProducts(searchCategory, searchString);
		
		request.setAttribute("productList", products);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
		dispatcher.forward(request, response);
	}
	
	private void deleteProduct(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		String productName = request.getParameter("productName");
		productDbUtil.deleteProduct(productName);
		
		request.setAttribute("sqlMessage", "Product is successfully deleted");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
		dispatcher.forward(request, response);
	}
	
	private void loadProduct(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		// TODO Auto-generated method stub
		String productName = request.getParameter("productName");
		Product theProduct = productDbUtil.loadProduct(productName);
		request.setAttribute("productToUpdate", theProduct);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/update-product.jsp");
		dispatcher.forward(request, response);
	}
	

	private void updateProduct(HttpServletRequest request,
			HttpServletResponse response) throws SQLException,ServletException, IOException {
		
		try {
			String productName = request.getParameter("productName");
			String category = request.getParameter("category");
			String sku = request.getParameter("sku");
			float price = Float.parseFloat(request.getParameter("price"));
			
			String oldProduct = request.getParameter("oldProduct");
			Product theProduct = new Product(productName, category, sku, price);
			
			productDbUtil.updateProduct(theProduct, oldProduct);
			
			request.setAttribute("sqlMessage", "Product is successfully updated");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
			dispatcher.forward(request, response);
			
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		
	}

}
