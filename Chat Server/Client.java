import java.net.Socket;

/**
 * Client.java
 * represents a client in the chat application
 */
public class Client {
  public Socket connectionSocket = null;
  public String username = "";
  public int score = 0;
  public boolean isHost = false;

  /**
   * Constructs a new Client object with the given socket connection.
   * 
   * <p>@param sock The socket connection for the client.
   */
  public Client(Socket sock) {
    this.connectionSocket = sock;
  }

  /**
   * Gets the socket connection associated with this client.
   * 
   * <p>@return The socket connection.
   */
  public Socket getSocket() {
    return connectionSocket;
  }

  /**
   * Gets the username of this client.
   * 
   * <p>@return The username.
   */
  public String getUsername() {
    return username;
  }

  /**
   * Sets the username for this client.
   * 
   * <p>@param username The username to set.
   */
  public void setUsername(String username) {
    this.username = username;
  }

  /**
   * Gets the score for this client.
   * 
   * <p>@return The score.
   */
  public int getScore(){
    return score;
  }

  /**
   * Increases the score by one.
   */
  public void earnPoint() {
    score++;
  }

  /**
   * Sets the client as the host.
   */
  public void setHost() {
    isHost = true;
    setUsername("Host");
  }

}