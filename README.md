# Network-Security-Project

## Introduction

This project is a simulation of the [Mirai](https://en.wikipedia.org/wiki/Mirai_(malware)) malware. 

## Structure
Components of the project are:
- Attacker machin
- 3 victim servers
- A web server as a control panel for hacker

Simulation runs in docker and devices are connected to each other in a docker network.

## Description
Attacker machine scans the networks and use ssh brute-force to connect target servers, then loads a script on target servers that gathers security informations and post then to attacker's web server. Finally you can see host informations in django implemented web server.

More information about the components and scripts and also steps to run the project is mentioned in the document. (document is in Farsi)
