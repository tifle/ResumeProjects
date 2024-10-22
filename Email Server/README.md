# email

The Email Program is an application designed to facilitate the sending of an email using SMTP. This program takes in the email details, including sender and receiver information, subject, and message content from provided by the user in the command line when prompted. The message will be sent by connecting to the smtp.chapman.edy server, and it displays all of the SMTP comamnds that is sent to the server and the responses received from the server.

## Identifying Information

* Name: Tiffany Le
* Email: tifle@chapman.edu
* Course: CPSC 353-01 Data Communications/Computer Networks
* Assignment: PA01 Email

## Source Files

* Email.java (code)
* email.input (input file)

## References

* Matthew Favela (Student) - Assistance with Checkstyle installations 
  and running checkstyle
* Ethan Santana (Student) - Assistance with the code for the "CLIENT:" message of the email

## Known Errors

* The program will not run with the "java Email < email.input" command, but
it works with the "java Email email.input" command on my computer (this is only
applicable when reading in a file, not taking a user input).

## Build Insructions

* Compile the Email.java file (javac Email.java)

## Execution Instructions

* Execute the Email.java file (java Email)
* Note! This program will prompt the user to provide information via the
  command line, and it will not connect to the smtp server until all of 
  required information is provided.
