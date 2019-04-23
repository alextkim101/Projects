package EventPackage;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Vector;

public class SortEvents {
	public static Vector<Event> getPastEvents(Vector<Event> allEvents) {
		Vector<Event> pastEvents = new Vector<Event>();
		for (Event e : allEvents) {
			String date = e.getDate();
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			Timestamp curTime = new Timestamp(System.currentTimeMillis());
			String curDate = sdf.format(curTime);
			try {
				if (sdf.parse(date).before(sdf.parse(curDate))) {
					pastEvents.add(e);
				}
			} catch (ParseException pe) {
				System.out.println("pe: " + pe.getMessage());
			}
		}
		return pastEvents;
	}
	
	public static Vector<Event> getFutureEvents(Vector<Event> allEvents) {
		Vector<Event> futureEvents = new Vector<Event>();
		for (Event e : allEvents) {
			String date = e.getDate();
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			Timestamp curTime = new Timestamp(System.currentTimeMillis());
			String curDate = sdf.format(curTime);
			try {
				if (sdf.parse(curDate).before(sdf.parse(date))) {
					futureEvents.add(e);
				}
			} catch (ParseException pe) {
				System.out.println("pe: " + pe.getMessage());
			}
		}
		return futureEvents;
	}
}
