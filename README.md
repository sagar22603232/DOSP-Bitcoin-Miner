
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
