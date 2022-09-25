
# COP5615 - Distributed Operating Systems

## Project 1 – Bitcoin Miner

### Ashish Mhaske –

### Sagar Piyush Parikh – 22603232

**Outline:**

We have worked on implementation of Bitcoin minining project in Erlang using Actor Model which is an inbuild feature of Erlang. The bitcoins are mined based on required number of leading zeros. We have also run and tested this code using Remote Configuration using two machines.

*System1: Mainserver.erl*
- The main logic to mine the bitcoin and finding a hex string with exactly required number of leading zeros is return in this file.
- The Supervisor actor is spawned in the main function of this file, and number of leading zeros is passed to this actor.
- The supervisor actor allocates the sub-problem of generating hashes to worker actors.

*System2: Localserver.erl*
- This file works as client and receives an input as required number of leading zeros from the user.
- The connection is established with main server and the supervisor actor model in the mainserver.erl file and input is passed.


***System1: Mainserver.erl***

 - The main logic to mine the bitcoin and finding a hex string with exactly required number of leading zeros is return in this file.

- The Supervisor actor is spawned in the main function of this file, and number of leading zeros is passed to this actor.

- The supervisor actor allocates the sub-problem of generating hashes to worker actors.

***System2: Localserver.erl***

- This file works as client and receives the an input as required number of leading zeros from the user.
- The connection is established with main server and the supervisor actor model in the mainserver file and input is passed.

**Execution**

- Install Erlang in the system for mac OS system

    ``
brew install erlang``
- Extraction Project1.zip file.
- Go to the directory of Project1 in terminal.

  ``cd Project1``

- Open two terminals in different systems (One Client and One Server)
	- Client Server
		1.	Create the Node and cookie on this terminal for client server.

			``erl -name foo@Ipaddressofsystem -setcookie sagar``

		2.	Inside this erl command compile localserver.erl in terminal.

			``c(localserver).``

		3.	Run the localserver’s start function and pass required number of leading zeros.

			``localserver:serverStart(4).``

	- Server Side
		1.	Create the Node and cookie on this terminal for server.

			``erl -name bar@Ipaddressofsystem -setcookie sagar``

		2.	Inside this erl command compile mainserver.erl in terminal.
		``c(mainserver).``

		3.	Run the mainserver’s start function and pass required servername, and number of actors to be spawned.

			``mainserver:start(‘foo@clientserverIP’,NumberofActors).``

	
**Work Unit**

Multiple Actors are spawned by the mainserver, with each actor have a task of generating a new random string and computes the hash and checks if bitcoin has been found. This Actors runs until the condition of leading zeros is found and the hash generated is less than the target value, then the actor is killed. After nearly 90% of actors have executed, the system starts its shutdown.

**Largest Coin Found**

**String:** "s.parikh122671204"

**Hex:**
"0000000b2694e740a5244f0a360a3aee3dbbddc09cac58445d4b4ec686f1e74c"

**Results:**

	Coins mined : (4 zeroes) 4700
	Total unit size : 300000000
	Machines connected : 2

**Systems Used:**

- Client System: 
macOS Big Sur
Processor: 1.6 GHz Dual Core Intel Core I5

- Server System:
macOS Big Sur
Processor: Apple M1 chip 8 core processor


**Learnings:**

The above tables and figures show that for smaller inputs with low leading zeros, the program performs better as the number of actors grows. When choosing the higher number of leading zeros, the ratio rises as the number of actors does as well.

	
