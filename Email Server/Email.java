import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

/**
*  Email Program.
*  This class is responsible for sending an email and outputting 
*  the server's response to the commands. 
*  This program reads all of the information (email addresses, 
   subject, etc.) from a user's input if a file is not provided.
*  author: Tiffany Le
*  Email:  tifle@chapman.edu
*  Date:  2/16/2024
*  version: 3.2
*/

class Email {
  public static void main(String[] args) {
    String fileName = "";
    BufferedReader configFile = null;
    BufferedReader userInput = null;
    // Check if a file name is provided as a command-line argument
    if (args.length > 0) {
      fileName = args[0];
      try {
        configFile = new BufferedReader(new FileReader(fileName));
      } catch (IOException e) {
        System.out.println("Error reading file: " + e.getMessage());
        return;
      }
    } else {
      // No file provided, use standard input
      userInput = new BufferedReader(new InputStreamReader(System.in));
    }
    try {
      // declare variables
      String fromAddress = "";
      String toAddress = "";
      String senderName = "";
      String receiverName = "";
      String subject = "";
      String line = "";
      String message = "";
      final StringBuilder messageBuilder = new StringBuilder();
      // check if a file is provided
      if (args.length != 0) {
        fileName = args[0];
        configFile = new BufferedReader(new FileReader(fileName));
        fromAddress = configFile.readLine();
        toAddress = configFile.readLine();
        senderName = configFile.readLine();
        receiverName = configFile.readLine();
        subject = configFile.readLine();
          
        while ((line = configFile.readLine()) != null) {
          messageBuilder.append(line).append("\n");
        }
        message = messageBuilder.toString();
        configFile.close();
      } else {
        // get user input; will run until input is provided
        userInput = new BufferedReader(new InputStreamReader(System.in));
        while (!fromAddress.contains("@")) {
          System.out.println("Enter the sender's email address: ");
          fromAddress = userInput.readLine();
        }
        while (!toAddress.contains("@")) {
          System.out.println("Enter the receiver's email address: ");
          toAddress = userInput.readLine();
        }
        while (senderName.length() == 0) {
          System.out.println("Enter the sender's name: ");
          senderName = userInput.readLine();
        }
        while (receiverName.length() == 0) {
          System.out.println("Enter the receiver's name: ");
          receiverName = userInput.readLine();
        }
        while (subject.length() == 0) {
          System.out.println("Enter the email's subject: ");
          subject = userInput.readLine();
        }
        System.out.println("Enter the body of the email (end with a period on a new line): ");
        while (!(line = userInput.readLine()).equals(".")) {
          messageBuilder.append(line).append("\n");
        }
        message = messageBuilder.toString();
      }
      Socket clientSocket = new Socket("smtp.chapman.edu", 25);
      PrintWriter outToServer = new PrintWriter(clientSocket.getOutputStream(), true);
      BufferedReader fromServer =  new BufferedReader(
          new InputStreamReader(clientSocket.getInputStream()));

      // Display the Welcome Message
      String welcomeMessage = fromServer.readLine();
      System.out.println("SERVER: " + welcomeMessage);
      // Send HELO message from server
      System.out.println("CLIENT: HELO icd.chapman.edu");
      outToServer.println("HELO icd.chapman.edu");
      String modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);

      //Send FROM email
      System.out.println("CLIENT: MAIL FROM: " + fromAddress);
      outToServer.println("MAIL FROM: " + fromAddress);
      modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);
      //Send Receiver email
      System.out.println("CLIENT: RCPT TO: " + toAddress);
      outToServer.println("RCPT TO: " + toAddress);
      modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);

      //Send DATA message
      System.out.println("CLIENT: DATA");
      outToServer.println("DATA");
      modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);
      //Send sender name
      System.out.println("CLIENT: From: " + senderName);
      outToServer.println("From: " + senderName);
      //Send recipient name
      System.out.println("CLIENT: To: " + receiverName);
      outToServer.println("To: " + receiverName);
      //Send Subject
      System.out.println("CLIENT: Subject: " + subject);
      outToServer.println("Subject: " + subject); 
      // Splitting the message into lines
      String[] messageLines = message.split("\\r?\\n"); 
      for (int i = 0; i < messageLines.length; i++) {
        System.out.println("CLIENT: " + messageLines[i]);
        outToServer.println(messageLines[i]);
      }
      // Print the remaining lines
      System.out.println("CLIENT: .");
      outToServer.println(".");
      modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);

      // Send QUIT command
      System.out.println("CLIENT: QUIT");
      outToServer.println("QUIT");

      // Print the response to QUIT command
      modifiedSentence = fromServer.readLine();
      System.out.println("SERVER: " + modifiedSentence);
      outToServer.close();
      fromServer.close();
      clientSocket.close();
    } catch (Exception e) {
      System.out.println("An error occurred: " + e.getMessage());
      e.printStackTrace();
    }
  }
}