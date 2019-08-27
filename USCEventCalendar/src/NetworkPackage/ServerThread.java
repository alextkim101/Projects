package NetworkPackage;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ServerThread extends Thread {
	private BufferedReader br;
	private PrintWriter pw;
	private AppRoom ar;

	public ServerThread(Socket s, AppRoom ar) {
		// design decision
		this.ar = ar;
		try {
			InputStreamReader ipr = new InputStreamReader(s.getInputStream());
			br = new BufferedReader(ipr);
			pw = new PrintWriter(s.getOutputStream());
			this.start();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void run() {
		try {
			while (true) {
				String line = br.readLine();
				//System.out.println("received: " + line);
				ar.broadcast(line, this);
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}

	public void sendMsg(String msg) {
		pw.println("ChatRoom: " + msg);
		pw.flush();
	}

}
