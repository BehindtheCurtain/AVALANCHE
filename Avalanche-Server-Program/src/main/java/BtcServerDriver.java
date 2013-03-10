import java.io.IOException;



public class BtcServerDriver {
	/**
	 * @main 
	 * @param args
	 * [0] the ip
	 * [1] the port
	 * [2] the user name
	 * [3] the password
	 */
	public static void main(String args[]){
		String ip = args[0];
		String port = args[1];
		String user = args[2];
		String password = args[3];
		try {
			BtcServer server = new BtcServer(ip, port);
			server.transferData("This is data to transfer!!!!".getBytes());
		} catch (IOException e) {
			System.out.println(e.getMessage());
			System.out.println("Please reformat your inputs\nSee user manual for instructions");
		}
	}
}
