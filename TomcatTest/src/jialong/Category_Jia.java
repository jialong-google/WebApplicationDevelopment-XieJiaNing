package jialong;

public class Category_Jia {
	String itemName;
	String itemDes;
	public Category_Jia(){
		itemName=new String("");
		itemDes=new String("");
	}
	public Category_Jia(String name,String des){
		itemName=new String(name);
		itemDes=new String(des);
	}
	public void setName(String name)
	{
		itemName=new String(name);
	}
	public void setDes(String des)
	{
		itemDes=new String(des);
	}
	public String getName()
	{
		return itemName;
	}
	public String getDes()
	{
		return itemDes;
	}
}
