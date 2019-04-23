package NetworkPackage;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Vector;

public class AppRoom {
	Vector<ServerThread> serverthreads;

	public AppRoom(int port) {
		ServerSocket ss = null;
		try {
			System.out.println("trying to connect to port: " + port);
			ss = new ServerSocket(port);
			System.out.println("succesfully bound to port: " + port);
			serverthreads = new Vector<ServerThread>();
			while (true) {
				Socket s = ss.accept();
				System.out.println("connection from " + s.getInetAddress());
				ServerThread st = new ServerThread(s, this);
				serverthreads.add(st);
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
				if (ss != null) {
					ss.close();
				}
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
	}

	public void broadcast(String msg, ServerThread st) {
		if (msg != null) {
			System.out.println(msg);
			for (ServerThread cur : serverthreads) {
				if (cur != st) {
					st.sendMsg(msg);
				}
			}
		}
	}

	public static void main(String[] args) {
		AppRoom cr = new AppRoom(6789);
	}
}
