package productorder;


public class ProductObj {
		private double price;
		private double totalprice;
		private String pName;
		private int quantity;
		
//		public ProductObj(double price, String pName) {
//			super();
//			this.price = price;
//			this.pName = pName;
//			//this.quantity = 
//		}
		
		public double getTotalprice() {
			return totalprice;
		}

		public void setTotalprice(double totalprice) {
			this.totalprice = totalprice;
		}

		public int getQuantity() {
			return quantity;
		}

		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}

		public double getPrice() {
			return price;
		}

		public void setPrice(double price) {
			this.price = price;
		}

		public String getpName() {
			return pName;
		}

		public void setpName(String pName) {
			this.pName = pName;
		}
}


