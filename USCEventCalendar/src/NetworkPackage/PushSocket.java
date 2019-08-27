package NetworkPackage;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.tomcat.util.net.SSLSessionManager;

import java.util.List; 
import java.util.ArrayList; 
import java.util.Collections; 
import java.util.Timer;
import java.util.TimerTask;

@ServerEndpoint("/push/")
public class PushSocket {
	static List<Session> sessionManager = Collections.synchronizedList(new ArrayList<Session>());

    @OnMessage
    public void onMessage(String message, final Session session) throws IOException {

        System.out.println("Message from " + session.getId() + ": " + message);
//        TimerTask timerTask = new TimerTask() {
//            @Override
//            public void run() {
//                try {
//                    broadcast(message);
//                } catch (IOException ex) {
//                    Logger.getLogger(PushSocket.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        };
//        Timer timer = new Timer(true);
//        timer.scheduleAtFixedRate(timerTask, 0, 3 * 1000);
    	System.out.println("Broadcastng");
    	broadcast(message);

    }
    
    @OnOpen
    public void open(Session session) {
      sessionManager.add(session);
      System.out.println(sessionManager.size());
    }

    @OnClose
    public void close(Session session) {
      sessionManager.remove(session);
      System.out.println("removed 1 session. now: " + sessionManager.size());

    }
    public void broadcast(String message) throws IOException{
    	System.out.println(message);
    	System.out.println(sessionManager.size());
        for(Session session: sessionManager){
            session.getBasicRemote().sendText(message);
        }
    }
}