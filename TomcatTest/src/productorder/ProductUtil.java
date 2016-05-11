package productorder;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

public class ProductUtil {
	private List<ProductObj> productlist = new ArrayList<>();
	private double cartTotalCost;
	
	//for db connection
	Connection conn = null;
	PreparedStatement pStmt = null;
	ResultSet rSet = null;
	
	public void deleteList(Object username){
		String strname = (String) username;
		storeList(strname);
		productlist.clear();
	}
	
	
	private void storeList(String username) {
		//connect jdbc
		try{
		Class.forName("org.postgresql.Driver");
		conn = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/xiejianing", "jwxie", "12345");
		conn.setAutoCommit(false);
		
		//create a statement from connection
		Statement statement = conn.createStatement();
		//insert the data
		for (ProductObj product:productlist){
			String name = product.getpName();
			double price = product.getPrice();
			int quantity = product.getQuantity();
			String user = username;
			
			String sql = "INSERT INTO purchase (price, quantity, time, buyer, product) VALUES (?, ?, ?, ?, ?)";
			pStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			pStmt.setString(1, );
			pStmt.setString(2, validate[1]);
			rSet = pStmt.executeQuery();
			
			
			
		}
		//statement.executeUpdate("INSERT INTO Customers " + "VALUES (?, ?, ?, ?, ?)");
		
		}catch(Exception e){
			
		}finally {
			close(conn, pStmt, rSet);
		}
		
	}


	private void close(Connection conn2, PreparedStatement pStmt2, ResultSet rSet2) {
		try {
			if (conn != null) {
				conn.close();
			}
			
			if (pStmt != null) {
				pStmt.close();
			}
			
			if (rSet != null) {
				rSet.close();   // doesn't really close it ... just puts back in connection pool
			}
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		
	}


	//add this product to product list
	public void addProduct(String name, String quantity, double cost){
		int pQuantity = 0;
		double totalprice = 0.0;
		//create obj
		ProductObj productObj = new ProductObj();
		pQuantity = Integer.parseInt(quantity);
		try{	
		if (pQuantity > 0){
				totalprice = pQuantity * cost;
				productObj.setpName(name);
				productObj.setPrice(cost);
				productObj.setQuantity(pQuantity);
				productObj.setTotalprice(totalprice);
				productlist.add(productObj);
				
				//calculate the total cost in cart
				calculateCartTotal();
			}
		}catch (NumberFormatException error){
			System.out.println("error when parsing string to double");
			error.printStackTrace();
		}
	}
	private void calculateCartTotal() {
		double total = 0.0;
		for (ProductObj product:productlist){
			total += product.getTotalprice();
		}
		setCartTotalCost(total);
		System.out.println("product added");
		System.out.println(total);
	}
	
	//getters and setters for productlist & ordertotal
	public List<ProductObj> getProductlist() {
		System.out.println("getProductlist called");
		return productlist;
	}
	public void setProductlist(List<ProductObj> productlist) {
		this.productlist = productlist;
	}
	
	public double getCartTotalCost() {
		return cartTotalCost;
	}
	public void setCartTotalCost(double cartTotalCost) {
		this.cartTotalCost = cartTotalCost;
	}
	
	
	
	
}
	
	

