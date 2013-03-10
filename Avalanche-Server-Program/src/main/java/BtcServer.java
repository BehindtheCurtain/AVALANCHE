import java.io.IOException;
import java.net.MalformedURLException;
import java.net.SocketException;
import java.net.URL;
import java.net.URLConnection;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;


public class BtcServer {
	
	/**
	 * Constructor
	 * @param ip
	 * 	ip to connect to
	 * @param port
	 *  port to use
	 * @param user
	 * 	user name
	 * @param password
	 *  password
	 * @throws IOException
	 */
	public BtcServer(String ip, String port, String user, String password) throws IOException{
		url = new URL("ftp://" + ip + ":" + port + "/" + user + "/" + password);
		conn = url.openConnection();
		inetAddress = ip;
		iPort = port;
	}
	
	/**
	 * @overload
	 * @param ip
	 * 		ip address to connect to
	 * @param port
	 * 		port to connect to
	 * @throws IOException
	 */
	public BtcServer(String ip, String port) throws IOException{
		url = new URL("http://" + ip + ":" + port);
		conn = url.openConnection();
	}
	
	public void transferData(byte[] dataToTransfer) throws SocketException, IOException{
		FTPClient ftp = new FTPClient();
		FTPClientConfig ftpConfig = new FTPClientConfig();
		ftp.connect("192.168.1.4", Integer.parseInt("21"));
		System.out.println(ftp.getReplyString());
	}
	
	private final URLConnection conn;
	private final URL url;
	private String inetAddress;
	private String iPort;
}
