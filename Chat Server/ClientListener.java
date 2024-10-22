import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * ClientListener.java
 *
 * <p>This class runs on the client end and just
 * displays any text received from the server.
 *
 */

public class ClientListener implements Runnable {
  private Socket connectionSock = null;

  ClientListener(Socket sock) {
    this.connectionSock = sock;
  }

  /**
   * Gets message from server and dsiplays it to the user.
   */
  public void run() {
    try {
      BufferedReader serverInput = new BufferedReader(
          new InputStreamReader(connectionSock.getInputStream()));
      while (true) {
        String message = serverInput.readLine();
        if (message != null) {
          if (message.equalsIgnoreCase("Goodbye")) {
            System.out.println("Server has closed the connection.");
            break;
          }
          System.out.println(message);
        } else {
          System.out.println("Server has closed the connection.");
          break;
        }
      }
      connectionSock.close();
    } catch (IOException e) {
      System.out.println("Error: " + e.getMessage());
    }
  }
} // ClientListener for MtClient
