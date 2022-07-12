package egovframework.example.vo;

public class LottoInfo {
	int order;
	String przwin_no;
	
	public LottoInfo() {
	}
	
	public LottoInfo(int order, String przwin_no) {
		super();
		this.order = order;
		this.przwin_no = przwin_no;
	}
	
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public String getPrzwin_no() {
		return przwin_no;
	}
	public void setPrzwin_no(String przwin_no) {
		this.przwin_no = przwin_no;
	}
	
	
}
