package product;

public class Product {
	String name;
	String category;
	String sku;
	float price;
	
	public Product(String name, String category, String sku, float price) {
		super();
		this.name = name;
		this.category = category;
		this.sku = sku;
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}
	
	
}
