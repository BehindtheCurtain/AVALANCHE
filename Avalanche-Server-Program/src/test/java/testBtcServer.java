import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Test;


public class testBtcServer {

	@Test
	public void testBtcServerConstructor() {
		try {
			BtcServer btc = new BtcServer("127.0.0.1","1234","user","pass");
			assertNotNull(btc);
		} catch (IOException e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testtransferData(){
		try {
			BtcServer btc = new BtcServer("127.0.0.1","8080");
			btc.transferData("12345".getBytes());
		} catch (IOException e) {
			fail(e.getMessage());
		}
	}

}
