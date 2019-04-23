package EventPackage;
import java.util.Vector;

public class Event {
	private int eventID;
	private int hostID;
	private String date;
	private String beginTime;
	private String endTime;
	private String eventName;
	private String location;
	private String tags;
	private String affiliation;
	private String details;
	private Vector<Integer> attending;
	private Vector<Integer> interested;
	private Vector<Integer> notAttending;
	
	
	public Event(int eventID, int hostID, String date, String beginTime, String endTime, String eventName, String location,
				String tags, String affiliation, String details, Vector<Integer> attending, Vector<Integer> interested, Vector<Integer> notAttending) {
		this.eventID = eventID;
		this.hostID = hostID;
		this.date = date;
		this.beginTime = beginTime;
		this.endTime = endTime;
		this.location = location;
		this.eventName = eventName;
		this.tags = tags;
		this.affiliation = affiliation;
		this.attending = attending;
		this.interested = interested;
		this.notAttending = notAttending;
	}

	public int getEventID() {
		return eventID;
	}

	public void setEventID(int eventID) {
		this.eventID = eventID;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public void setHostID(int hostID) {
		this.hostID = hostID;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public void setAttending(Vector<Integer> attending) {
		this.attending = attending;
	}

	public void setInterested(Vector<Integer> interested) {
		this.interested = interested;
	}

	public void setNotAttending(Vector<Integer> notAttending) {
		this.notAttending = notAttending;
	}

	public int getHostID() {
		return hostID;
	}
	
	public String getDate() {
		return date;
	}
	
	public String getName() {
		return eventName;
	}
	
	public String getDetails() {
		return details;
	}
	
	public String getBegin() {
		String hour = beginTime.substring(0,2);
		String minute = beginTime.substring(2);
		if (Integer.valueOf(hour) > 12) {
			int newHour = Integer.valueOf(hour) - 12;
			hour = Integer.toString(newHour);
		}
		return hour + minute;
	}
	
	public String getEnd() {
		String hour = endTime.substring(0,2);
		String minute = endTime.substring(2);
		if (Integer.valueOf(hour) > 12) {
			int newHour = Integer.valueOf(hour) - 12;
			hour = Integer.toString(newHour);
		}
		return hour + minute;
	}
	
	public String getLocation() {
		return location;
	}
	
	public String getTags() {
		return tags;
	}
	
	public String getAffiliation() {
		return affiliation;
	}
	
	public Vector<Integer> getAttending() {
		return attending;
	}
	
	public int getNumAttending() {
		return attending.size();
	}
	
	public Vector<Integer> getInterested() {
		return interested;
	}
	
	public int getNumInterested() {
		return interested.size();
	}
	
	public Vector<Integer> getNotAttending() {
		return notAttending;
	}
	
	public int getNumNotAttending() {
		return notAttending.size();
	}
}
