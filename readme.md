# nrelay-exalt

A console based modular client for Realm of the Mad God built with Node.js and TypeScript.

This software was originally written by [Thomas Crane](https://github.com/thomas-crane) and you can find the original version for flash [here](https://github.com/thomas-crane/nrelay)  

All credit goes to Thomas for writing this and the only commits I am making are to allow the project keep working with the RotMG Unity client.  

## Contents

+ [Unity Changes](#unity-changes)
+ [Docs](#docs)
+ [Install](#install)
  + [Prerequisites](#prerequisites)
+ [Setup](#setup)
  + [Using proxies](#using-proxies)
  + [Using the Local Server](#using-the-local-server)
+ [Run](#run)
+ [Command line arguments](#command-line-arguments)
+ [Build](#build)
+ [Acknowledgements](#acknowledgements)

## Unity Changes

The following changes have been made to nrelay to port it over to Unity: 

+ The auto-updater has been completely removed as there is now no way to download the current Unity client and parse the assets 
+ Because of the above, the `--no-update`, `--force-update` and `--update-from` arguments have been removed
+ The incoming and outgoing RC4 cipher keys have changed in the [realmlib library](https://github.com/abrn/realmlib-exalt)
+ All HTTP requests made to the appspot now use the same headers as the Unity client, mainly the `User-Agent` and the `X-Unity-Version` to avoid clients being banned
+ DECA's CompressedInt type has been added to the [realmlib library](https://github.com/abrn/realmlib-exalt) and some packet structures have been updated accordingly
+ Added the `QUEUE_INFO` packet due to servers now possibly having a player queue - the client will now wait a reasonable time before trying to reconnect
+ Various other packets have been added and updated

## Docs

The documentation in this repository consists mostly of guides and tutorials about how to use nrelay and its components, and how to create plugins. All of the docs can be found [in the docs folder.](/docs/readme.md)

There is also extensive inline API documentation, which can be viewed [on the docs website.](https://docs.nrelay.net/)

## Install

### Prerequisites

Make sure you have [Nodejs v12+](https://nodejs.org/en/download/) installed before running nrelay.

1. Install the nrelay cli:

```bash
npm install -g nrelay-cli
```

2. Create a new nrelay project:

```bash
nrelay new my-new-project
```

3. Navigate to the project folder:

```bash
cd my-new-project
```

## Setup

When you create a new nrelay project, you will need to set up your `accounts.json` file. It will be generated for you, but only contains an example account.

The contents of the file will resemble the following.

```json
[
  {
    "alias": "Main Client",
    "guid": "example@email.com",
    "password": "password10",
    "serverPref": "Australia"
  }
]

```

To use your own account, simply replace the `guid` and `password` values with your own account's email and password.

If you have multiple accounts which you want to run at the same time, you can add them by duplicating the segment in the curly braces `{ ... }`. E.g.

```json
[
  {
    "alias": "Main Client",
    "guid": "first.account@email.com",
    "password": "SecretPassWord11",
    "serverPref": "AsiaSouthEast"
  },
  {
    "alias": "Secondary Client",
    "guid": "second.account@email.com",
    "password": "Password22",
    "serverPref": "USSouth"
  }
]

```

### Using proxies

nrelay supports the use of SOCKSv4, SOCKSv4a, and SOCKSv5 proxies to route client connections through. Proxies can be added in the account config as a property of the account

```json-with-comments
{
    "alias": "Main Client",
    "guid": "first.account@email.com",
    "password": "SecretPassWord11",
    "serverPref": "AsiaSouthEast",
    "proxy": {
        "host": "127.0.0.1",  // The ip of the proxy.
        "port": 8080,         // The port of the proxy. Use a number here, e.g. 8080 not "8080".
        "type": 5,            // The type of the proxy. Use 5 for SOCKSv5 and 4 for SOCKSv4 or SOCKSv4a.
        "userId": "username", // The username for the proxy, if one is required.
        "password": "secret"  // The password for the proxy, if one is required.
    }
}
```

If a proxy is specified, nrelay will route all traffic including the initial web request to get the character lists. Because of this, there may be greater delays when using proxies.
The proxy a client is using can also be changed during runtime by using the `Client.setProxy(proxy: IProxy): void` method.

### Using the Local Server

nrelay has a built in Local Server which can be used to transfer data between nrelay and another process, such as KRelay. If you are interested in using the local server, take a look at the [local server guide.](/docs/the-local-server.md)

## Run

After setting up the `accounts.json` file, nrelay is ready to go. To run nrelay, use the command `nrelay run` in the console. If you have setup your `accounts.json` properly (and used the correct credentials) you should see an output similar to this

```bash
C:\Documents> nrelay run
[17:25:23 | NRelay]           Starting...
...
[17:25:26 | Main Client]      Authorized account
[17:25:26 | Main Client]      Starting connection to AsiaSouthEast
[17:25:26 | Main Client]      Connected to server!
[17:25:26 | Main Client]      Connecting to Nexus
[17:25:27 | Main Client]      Connected!
```

The `alias` property in the account config is optional. If one is not specified, the log will use a censored email instead

```bash
[17:25:26 | f***@e***.com]    Authorized account
[17:25:26 | f***@e***.com]    Starting connection to AsiaSouthEast
[17:25:26 | f***@e***.com]    Connected to server!
```

## Commands

Using the `nrelay` command in the CLI there are several arguments you can pass:

#### `nrelay run`  
Run the current nrelay project

#### `nrelay new <projectname>`  
Create a new nrelay project folder  

#### `nrelay build`  
Compile the TypeScript inside the `/src` folder into JavaScript  

#### `nrelay eject`  
Create an `index.js` file which can be ran the usual way with Node - not using the nrelay CLI  

#### `nrelay fix`  
Check the current folder is a valid nrelay project and fix any issues

#### `nrelay update`  
Update the nrelay-cli to the newest version  


## Extra arguments

There are other extra command line arguments which can be provided when starting nrelay to change the behaviour:

#### `--version` or `-v`

This will print the nrelay version number to the console and exit.

#### `--debug`

This will start nrelay in debug mode. Debug mode provides a higher detail of logging. It is not recommended to use debug mode unless you are experiencing errors and need more info.

#### `--no-log`

This will stop nrelay from writing to the log file.

#### `--no-plugins`

This will stop nrelay from loading any plugins.

### Examples

To start nrelay without checking for updates or log file writing:

```bash
nrelay run --no-update --no-log
```

To start nrelay in verbose mode and not load any plugins:  

```bash
nrelay run --debug --no-plugins
```

To print the version number:

```bash
nrelay -v
```

## Build

Whenever any changes are made to the plugins, they will need to be recompiled in order for the changes to take effect.

To recompile the plugins simply use

```bash
nrelay build
``` 

If this doesn't work, you will need to install the TypeScript compiler:

```bash
npm install -g typescript
```  

Then to compile everything in the plugin folder:

```bash
tsc
```

## Acknowledgements

This project uses the following open source software:

+ [Il2CppDumper](https://github.com/Perfare/Il2CppDumper) - to decompile the Unity client and parse the assets
+ [ghidra](https://github.com/NationalSecurityAgency/ghidra) - to reverse engineer edits to the network structure of the game
