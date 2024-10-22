# Chatgame

* MtClient.java handles user keyboard input.
* ClientListener.java receives responses from the server and displays them
* MtServer.java listens for client connections and creates a ClientHandler for each new client
* ClientHandler.java receives messages from a client and relays it to the other clients.
* This program runs a game where one client, the host, asks the players questions. The first one to answer correctly gets a point.

## Identifying Information

* Name: Mason Pennell
* Email: pennell@chapman.edu
* Name: Max Rovenger
* Email: mrovenger@chapman.edu
* Name: Nora Mirabel
* Email: mirabel@chapman.edu
* Name: Tiffany Le
* Email: tifle@chapman.edu
* Course: CPSC 353-02
* Assignment: PA04 - Chatgame

## Source Files

* MtClient.java
* MtServer.java
* ClientHandler.java
* ClientListener.java
* Client.java

## References

* ChatGPT
* Michael Fahy

## Known Errors

* N/A

## Build Instructions

* Compile all of the files: javac *java

## Execution Instructions

* Run MtServer in one terminal
* Run MtClient in as many other terminals as you'd like

## Team Contribution

Nora: 
- When the client connects to the server, the ClientHandler will send a Welcome message prompting the user to enter a username.
- The response from the client will be the username.
- The ClientHandler will send the message to all clients:
- Wrote switch statement for message
- Assigned the first client as the host and provided them with instructions

Mason:
- To keep track of the usernames, create a Client class that contains both the Socket and the username.
- When "Who?" is typed, returns a list of all usernames.
- Added "Score" object to client class
- Added "SCORES" command to host
  
Tiffany
- Create an ArrayList of Client objects instead of the ArrayList of Socket objects
- Fixed the code for Client Handler, Client Listener, MtClient, and Mt Server
- Ran Checkstyle
- Implemented the "Goodbye" quit statement
- Change the port number on which the server listens to your team name.  This is so all your servers can run simultaneously on the icd server.

Max:
- To prevent the duplication of inputted usernames, edited the ClientHandler class to scan through all client usernames to gaurantee unique usernames.
- Wrote instructions for new  clients

Tiffany, Max, Mason, Nora
- Modify the code so that the ClientHandler adds the identifying username to the beginning of every message from every client and sends the updated message, including the username, to all the other clients
- Debugging
