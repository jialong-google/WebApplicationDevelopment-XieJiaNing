package product;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.sql.Connection;

public class ProductDbUtil {
	private Connection conn;
	
	public ProductDbUtil(Connection conn) {
		super();
		this.conn = conn;
	}

	public List<Product> getCategoryProducts(String categoryName) throws SQLException {
		// TODO Auto-generated method stub
		List<Product> productList = new ArrayList<>();
	
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			String sql = "SELECT * FROM products p WHERE p.category = ? ORDER BY p.name";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, categoryName);
			rSet = pStmt.executeQuery();
			
			while (rSet.next()) {
				String productName = rSet.getString("name");
				String category = rSet.getString("category");
				String sku = rSet.getString("sku");
				float price = rSet.getFloat("price");
				
				Product theProduct = new Product(productName, category, sku, price);
				productList.add(theProduct);
			}
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		
		return productList;
	}

	public void addProduct(Product theProduct) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			//System.out.println("insert into products");
			String sql = "INSERT INTO products (sku, price, name, category) VALUES(?, ?, ?,?);";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, theProduct.getSku());
			pStmt.setFloat(2, theProduct.getPrice());
			pStmt.setString(3, theProduct.getName());
			pStmt.setString(4, theProduct.getCategory());
			
			pStmt.executeUpdate();
			conn.commit();
			
			//System.out.println("insert into classification");
			sql = "INSERT INTO classification (product, category) VALUES(?, ?)";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, theProduct.getSku());
			pStmt.setString(2, theProduct.getCategory());
			
			pStmt.executeUpdate();
			conn.commit();
			
			conn.setAutoCommit(true);		
		}
		catch (SQLException exc) {
			throw exc;
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
	}
	
	public List<Product> getAllProducts(String parameter) throws SQLException {
		// TODO Auto-generated method stub
		List<Product> productList = new ArrayList<>();
		
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			String sql = "SELECT * FROM products p ORDER BY p.name";
			pStmt = conn.prepareStatement(sql);
			rSet = pStmt.executeQuery();
			
			conn.commit();
			conn.setAutoCommit(true);	
			
			while (rSet.next()) {
				String productName = rSet.getString("name");
				String category = rSet.getString("category");
				String sku = rSet.getString("sku");
				float price = rSet.getFloat("price");
				
				Product theProduct = new Product(productName, category, sku, price);
				productList.add(theProduct);
			}
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		
		return productList;
	}

	public List<Product> getSearchProducts(String searchCategory, String searchProduct) throws SQLException {
		List<Product> productList = new ArrayList<>();
		
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		//System.out.println("searchCategory " + searchCategory);
		//System.out.println("searchProduct " + searchProduct);
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			String sql = "";
			
			if (searchCategory == null || searchCategory == "") {
				//System.out.println("category not selected");
				sql = "SELECT * FROM products p WHERE p.name LIKE ? ";
				pStmt = conn.prepareStatement(sql);
				pStmt.setString(1, "%" + searchProduct + "%");
			}
			else {
				if (searchProduct == null || searchProduct == "") {
					sql = "SELECT * FROM products p WHERE p.category=?";
					pStmt = conn.prepareStatement(sql);
					pStmt.setString(1, searchCategory);
				}
				else {
					sql = "SELECT * FROM products p WHERE p.category=?"
							+ "AND p.name LIKE ? ";
					pStmt = conn.prepareStatement(sql);
					pStmt.setString(1, searchCategory);
					pStmt.setString(2, "%" + searchProduct + "%");
				}	
			}
			
			rSet = pStmt.executeQuery();
			conn.commit();
			conn.setAutoCommit(true);
			
			while (rSet.next()) {
				String productName = rSet.getString("name");
				String category = rSet.getString("category");
				String sku = rSet.getString("sku");
				float price = rSet.getFloat("price");
				
				Product theProduct = new Product(productName, category, sku, price);
				//System.out.println(productName);
				productList.add(theProduct);		
			}
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		
		return productList;		
	}
	
	public void deleteProduct(String productName) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		//System.out.println("searchCategory " + searchCategory);
		//System.out.println("searchProduct " + searchProduct);
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			System.out.println(productName);
			String sql = "";
			sql = "DELETE FROM classification WHERE EXISTS "
					+ "(SELECT * FROM products WHERE classification.product=products.sku "
					+ "AND products.name=?)";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, productName);
			pStmt.executeUpdate();
			conn.commit();
			
			sql = "DELETE FROM products WHERE products.name=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, productName);
			pStmt.executeUpdate();
			conn.commit();
			
			conn.setAutoCommit(true);
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
	}
	
	

	public Product loadProduct(String productName) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		Product theProduct = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			String sql = "SELECT * FROM products WHERE name=?";
			pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, productName);
			rSet = pStmt.executeQuery();
			conn.commit();
			conn.setAutoCommit(true);
			
			if(rSet.next()) {
				String sku = rSet.getString("sku");
				float price = rSet.getFloat("price");
				String name = rSet.getString("name");
				String category = rSet.getString("category");
				theProduct = new Product(name, category, sku, price);
			}
			else {
				throw new SQLException("nothing to load for this product");
			}
			
			return theProduct;
		
		}
		catch(SQLException exc) {
			throw exc;
		}
		catch(Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		return null;
	}

	public void updateProduct(Product theProduct, String oldProduct) throws SQLException {
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			//System.out.println("insert into products");
			String sql = "UPDATE products SET sku=?, price=?, name=?, category=? "
					+ "WHERE products.sku=?;";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, theProduct.getSku());
			pStmt.setFloat(2, theProduct.getPrice());
			pStmt.setString(3, theProduct.getName());
			pStmt.setString(4, theProduct.getCategory());
			pStmt.setString(5, oldProduct);
			
			pStmt.executeUpdate();
			conn.commit();
			
			//System.out.println("insert into classification");
			sql = "UPDATE classification SET product=?, category=? "
					+ "WHERE product=?;";
			pStmt = conn.prepareStatement(sql);
			
			pStmt.setString(1, theProduct.getSku());
			pStmt.setString(2, theProduct.getCategory());
			pStmt.setString(3, oldProduct);

			
			pStmt.executeUpdate();
			conn.commit();
			
			conn.setAutoCommit(true);		
		}
		catch (SQLException exc) {
			throw exc;
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		
	}
	
	public List<String> getCategory() throws SQLException {
		// TODO Auto-generated method stub
		List<String> categoryList = new ArrayList<>();
		PreparedStatement pStmt = null;
		ResultSet rSet = null;
		
		try {
			conn = DriverManager.getConnection(
    	            "jdbc:postgresql://localhost:5432/postgres?" +
        	        "user=postgres&password=003426");
			conn.setAutoCommit(false);
			
			//System.out.println("insert into products");
			String sql = "SELECT * FROM categories ORDER BY name";
			pStmt = conn.prepareStatement(sql);
						
			rSet = pStmt.executeQuery();
			conn.commit();
			
			conn.setAutoCommit(true);
			
			while (rSet.next()) {
				String category = rSet.getString("name");
				categoryList.add(category);
			}
			
		}
		catch (SQLException exc) {
			throw exc;
		}
		catch (Exception exc) {
			exc.printStackTrace();
		}
		finally {
			close(conn, pStmt, rSet);
		}
		
		return categoryList;	
	}
	
	private void close(Connection conn, PreparedStatement pStmt, ResultSet rSet) {

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

	

	


}
