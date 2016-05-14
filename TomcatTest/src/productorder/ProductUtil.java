package productorder;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

public class ProductUtil {
	private List<ProductObj> productlist = new ArrayList<>();
	private double cartTotalCost;
	
	//for db connection
	Connection conn = null;
	PreparedStatement pStmt = null;
	ResultSet rSet = null;
	
	public void deleteList(Object username) throws ClassNotFoundException, SQLException{
		try
		{String strname = (String) username;
		storeList(strname);
		productlist.clear();
		}catch (SQLException e){
			throw e;
		}
		
	}
	
	
	private void storeList(String username) throws SQLException, ClassNotFoundException {
		//connect jdbc
		try{
		Class.forName("org.postgresql.Driver");
		conn = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/cse135", "postgres", "");
		conn.setAutoCommit(false);
		
		//insert the data
		String timeStamp = new SimpleDateFormat("yyyy/MM/dd/HH/mm/ss").format(new Date());
		System.out.println(timeStamp);
		String user = username;
		
		String tempuser = "xjw";
		System.out.println(productlist.toString());
		//for (ProductObj product:productlist){
		System.out.println("length:"+productlist.size());
		for(int i=0;i<productlist.size();i++){
			ProductObj product=productlist.get(i);
			System.out.println(product.toString());
			String name = product.getpName();
			double price = product.getPrice();
			int quantity = product.getQuantity();
			
			
			//get sku from database
			String sql1 = "SELECT sku FROM products WHERE name=?";
			pStmt = conn.prepareStatement(sql1,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			pStmt.setString(1,name);
			rSet = pStmt.executeQuery();
			rSet.next();
			String sku = rSet.getString("sku");//get sku
			
			String sql2 = "INSERT INTO purchase (price, quantity, time, buyer, product) VALUES (?, ?, ?, ?, ?)";
			
			pStmt = conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			pStmt.setDouble(1, price);
			//System.out.println(price);
			pStmt.setInt(2, quantity);
			//System.out.println(quantity);
			pStmt.setString(3, timeStamp);
			//System.out.println(timeStamp);
			pStmt.setString(4, tempuser);
			//System.out.println(tempuser);
			pStmt.setString(5, sku);
			//System.out.println(name);
			
			pStmt.executeUpdate();
			conn.commit();
		}
		//conn.commit();
		conn.setAutoCommit(true);
		
		}catch(SQLException e){
			System.out.println("Oh fuck!");
			throw e;
			
//			throw new SQLException();
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
	
	

