package NetworkPackage;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class UserClient extends Thread {
	private BufferedReader br; 
	private PrintWriter pw; 
	public UserClient (String hostname, int port) {
		Socket s = null; 
		try {
			System.out.println("trying to connect to port: " + port); 
			s = new Socket(hostname, port); 
			System.out.println("successfully connected"); 
			br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			pw = new PrintWriter(s.getOutputStream()); 
			this.start(); 
			Scanner scanner = new Scanner(System.in); 
			while(true) {
				String line = scanner.nextLine();
				pw.println("aaron c.: " + line); 
				pw.flush(); 
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {
			try {
			if(br != null) {
				br.close();
			}
			if(pw != null) {
				pw.close();
			}
			if(s != null) {
				s.close();
			}
			} catch (IOException ioe) {
				ioe.printStackTrace(); 
			}
		}
	}
	public void run() {
		try {
			while(true) {
				String line = br.readLine(); 
				System.out.println("ChatRoom:" + line);
			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}
	public static void main(String[] args ) {
		UserClient cc = new UserClient("localhost", 6789); 
	}
}
