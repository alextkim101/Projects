package EventPackage;

public class Rating {
	private String eventName;
	private String raterName;
	private String comments;
	private int rating;
	
	public Rating(String eventName, String raterName, String comments, int rating) {
		this.eventName = eventName;
		this.raterName = raterName;
		this.comments = comments;
		this.rating = rating;
	}
	
	public String getEventName() {
		return eventName;
	}
	
	public String getRaterName() {
		return raterName;
	}
	
	public String getComments() {
		return comments;
	}
	
	public int getRating() {
		return rating;
	}
}
