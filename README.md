
# COP5615 - Distributed Operating Systems

## Project 1 – Bitcoin Miner

### Ashish Mhaske –

### Sagar Piyush Parikh – 22603232

**Outline:**

We have worked on implementation of Bitcoin minining project in Erlang using Actor Model which is an inbuild feature of Erlang. The bitcoins are mined based on required number of leading zeros. We have also run and tested this code using Remote Configuration using two machines.

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
- Compile the mainserver.erl file

	``c(mainserver).``
- Run the mainserver file and call main function.

	``Pid = mainserver:main().``
- Complie localserver.erl in different  system's terminal.

	``c(localserver).``
- Run localserver file and call start function.

	``localserver:start(Pid,1).	``
	
**Work Unit**
Multiple Actors are spwaned by the mainserver, with each each actor have a task of generating a new random string and computes the hash and checks if bitcoin has been found. This Actors runs until the condition of leading zeros is found and the hash generated is less than the target value, then the actor is killed. After nearly 90% of actors have executed, the system starts its shutdown.
	
