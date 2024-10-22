import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.ArrayList;

/**
 * ClientHandler.java
 *
 * <p>This class handles communication between the client
 * and the server. It runs in a separate thread but has a
 * link to a common list of sockets to handle broadcast.
 *
 */

public class ClientHandler implements Runnable {
  private Socket connectionSock = null;
  private ArrayList<Client> clientList;
  private Client client;

  ClientHandler(Client client, ArrayList<Client> clientList) {
    this.connectionSock = client.getSocket();
    this.clientList = clientList;
    this.client = client;
  }

  /**
   * Run Method
   *
   * <p>Runs the client handler program.
   */  
  public void run() {
    try {
      System.out.println("Connection made with socket " + connectionSock);
      BufferedReader clientInput = new BufferedReader(
          new InputStreamReader(connectionSock.getInputStream()));
      DataOutputStream clientOutput = new DataOutputStream(
          client.getSocket().getOutputStream());
      
      // Assign "host" to the first client if none have the host role
      if (clientList.size() == 1) {
        client.setHost();
        // Provide host instructions
        clientOutput.writeBytes("\n=== Host Instructions ===\n");
        clientOutput.writeBytes("1. To ask questions, type the " 
            + "question and send it as a message.\n");
        clientOutput.writeBytes("   You can copy and paste a "  
            + "question or use a pre-prepared file if available.\n");
        clientOutput.writeBytes("2. To give a player a point, "  
            + "type their username.\n");
        clientOutput.writeBytes("3. Type 'SCORES' to see the scores " 
            + "of all clients.\n");
        clientOutput.writeBytes("=========================\n\n");
      } else {
        clientOutput.writeBytes("Welcome to the game! Please provide your username:\n");
        String username = clientInput.readLine();
        while (containsUsername(username)) {
          clientOutput.writeBytes("Username is currently in use.\nEnter a username:\n");
          username = clientInput.readLine();
        }  
        client.setUsername(username);
        clientOutput.writeBytes("\n=== Player Instructions ===\n");
        clientOutput.writeBytes("1. Be the first to answer questions correctly to earn points.\n");
        clientOutput.writeBytes("2. To see who else is playing, type 'who?'\n");
        clientOutput.writeBytes("3. Type 'goodbye' to leave the game.\n");
        clientOutput.writeBytes("=========================\n\n");
      }

      // Notify other clients about the new client's arrival
      System.out.println(client.getUsername() + " has joined the game.");
      for (Client c : clientList) {
        if (c.getSocket() != connectionSock) {
          DataOutputStream otherClientOutput = new DataOutputStream(
              c.getSocket().getOutputStream());
          otherClientOutput.writeBytes(client.getUsername() + " has joined the game.\n");
        } else {
          clientOutput.writeBytes("Welcome to the game, " + client.getUsername() + "!\n");
        }
      }

      // Main message handling loop
      while (true) {
        String message = clientInput.readLine();
        message = message.toLowerCase();
        if (message != null) {
          switch (message) {
            case "goodbye":
              System.out.println(client.getUsername() + ": Goodbye");
              // Notify other clients about the departure
              for (Client c : clientList) {
                if (c.getSocket() != connectionSock) {
                  DataOutputStream otherClientOutput = new DataOutputStream(
                      c.getSocket().getOutputStream());
                  otherClientOutput.writeBytes(client.getUsername() + " has left the chat.\n");
                }
              }
              // Close the connection and remove the client from the list
              clientInput.close();
              connectionSock.close();
              clientList.remove(client);
              return;
            case "who?":
              // reply with a list of all other clients
              for (Client c : clientList) {
                if (!c.isHost) {
                  clientOutput.writeBytes(c.username + "\n");
                }
              }
              break;
            case "scores":
              if (client.isHost) {
                // reply with a list of all other clients and their scores
                if (clientList.size() >= 2) {
                  for (Client c : clientList) {
                    if (!c.isHost) {
                      clientOutput.writeBytes(c.username + ": " + c.getScore() + "\n");
                    }
                  }
                } else {
                  clientOutput.writeBytes("No other clients are online.\n");
                }
              } else {
                clientOutput.writeBytes("You are not the host\n");
              }
              break;
            default:
              // Broadcast the message to other clients
              if (client.isHost) {
                // Check if the message is a command to give a point
              }
              for (Client c : clientList) {
                if (c.getSocket() != connectionSock) {
                  DataOutputStream otherClientOutput = new DataOutputStream(
                      c.getSocket().getOutputStream());
                  if (c.getUsername().equals(message) && client.isHost) {
                    c.earnPoint();
                    clientOutput.writeBytes("Point given to " + c.getUsername() + ".\n");
                    otherClientOutput.writeBytes(c.getUsername() + " got a point.\n");
                  } else {
                    String messageBroadcast = client.getUsername() + ": " + message + "\n";
                    otherClientOutput.writeBytes(messageBroadcast);  
                  }
                }
              }
          }
        } else {
          // Close the connection and remove the client from the list
          System.out.println("Closing connection for socket " + connectionSock);
          clientInput.close();
          connectionSock.close();
          clientList.remove(client);
          break;
        }
      }
    } catch (Exception e) {
      System.out.println("Error: " + e.toString());
      // Remove from arraylist
      clientList.remove(client);
    }
  }

  private Boolean containsUsername(String username) {
    for (Client c : clientList) {
      if (username.equals(c.username)) {
        return true;
      }
    }
    return false;
  }
}
