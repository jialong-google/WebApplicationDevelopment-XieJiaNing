package productorder;

import java.util.*;

public class ProductUtil {
	private List<ProductObj> productlist = new ArrayList<>();
	private double cartTotalCost;
	
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
	
	

