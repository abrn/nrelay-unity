# realmlib/resx

[![CodeFactor](https://www.codefactor.io/repository/github/thomas-crane/realmlib-resx/badge)](https://www.codefactor.io/repository/github/thomas-crane/realmlib-resx)

A library for downloading Realm of the Mad God resources and assets.

## Contents

+ [Install](#install)
+ [Use](#use)
  + [Methods](#methods)
  + [Putting it all together](#putting-it-all-together)
+ [Acknowledgements](#acknowledgements)

## Install

```bash
$ npm install @realmlib/resx
```

## Use

This package exports several functions for downloading the latest game resources as well as extracting packet IDs from the RotMG flash clients.

To use these functions, import it into your project.

```ts
import * as resx from '@realmlib/resx';
```

or import just the functions you need.

```ts
import { getClientVersion } from '@realmlib/resx';
```

### Methods

#### `getClientVersion`

Fetches the latest client version. Returns a promise that resolves to a string.

```ts
resx.getClientVersion().then((version) => {
  console.log(`The current version of the game is ${version}`);
});
```

#### `getClient`

Downloads the provided version of the game client. Returns a promise that resolves to a `Buffer` which contains the client.

```ts
resx.getClientVersion().then((version) => {
  return resx.getClient(version);
}).then((clientBuffer) => {
  console.log(`Client file size: ${clientBuffer.byteLength} bytes.`);
});
```

Optionally, you can pass a `WriteStream` instance to this method. If a `WriteStream` is passed, the buffer will be piped into the stream, and the promise will resolve with `void`.

```ts
const clientFile = fs.createWriteStream('./client.swf');

resx.getClient(currentVersion, clientFile).then(() => {
  console.log('Client finished downloading.');
});
```

Note that the option of passing a `WriteStream` into which the downloaded buffer will be piped is available on several other methods. The methods which take a `WriteStream` as an optional parameter are

+ `getClient`
+ `getGroundTypes`
+ `getObjects`

#### `getAssetVersion`

Fetches the latest asset version. Returns a promise that resolves to a string. Note that this version is usually the same as the client version, but can be behind for a few hours after the game updates.

```ts
resx.getAssetVersion().then((version) => {
  console.log(`The current version of the assets are ${version}`);
});
```

#### `getGroundTypes`

Downloads the latest `GroundTypes.json` file. Returns a promise which resolves to a `Buffer`, or `void` if a `WriteStream` is passed to the method.

```ts
const groundTypesFile = fs.createWriteStream('./ground-types.json');

resx.getGroundTypes(groundTypesFile).then(() => {
  console.log('GroundTypes.json finished downloading.');
});
```

#### `getObjects`

Downloads the latest `Objects.json` file. Returns a promise which resovles to a `Buffer`, or `void` if a `WriteStream` is passed to the method.

```ts
resx.getObjects().then((objects) => {
  console.log(`Objects.json file size: ${objects.byteLength} bytes.`);
});
```

#### `getVersions`

Simply combines `getClientVersion` and `getAssetVersion` in a `Promise.all` and returns a promise which resolves to an object containing both versions.

```ts
resx.getVersions().then((info) => {
  console.log(`The current client version is ${info.clientVersion}`);
  console.log(`The current asset version is ${info.assetVersion}`);
});
```

#### `Extractor`

The `Extractor` is a class which provides functionality for extracting various bits of information from the game client.

To create an extractor, it must be given a `Uint8Array` containing a valid RotMG swf file.

```ts
const clientPath = path.join(__dirname, 'client.swf');
const client = fs.readFileSync(clientPath);

const extractor = new Extractor(client);
```

If the parsing of the swf fails, the constructor will throw an error.

The extractor a few methods which can be used:

+ `packets()`
+ `parameters()`
+ `free()`

##### `packets`

This method extracts packet types and their IDs from the given client and returns a bidirectional map object.

If the extraction process fails, this method will throw.

```ts
const packetMap = extractor.packets();

console.log(packetMap[0]); // 'FAILURE'
console.log(packetMap['FAILURE']); // 0
```

##### `parameters`

This method extracts some constants from the parameters file in the game client.

```ts
const parameters = extractor.parameters();

console.log(parameters.version); // 'X33.0.1'
console.log(parameters.nexus_gameid); // -2
```

##### `free`

The extractor contains a handle to some unmanaged resources. The `free` method can be used to release these resources, and should always be called when the extractor is no longer needed.

```ts
const packets = extractor.packets();

// release the resources.
extractor.free();
```

### Putting it all together

The following is an example of a program which uses several of the methods from the `resx` class in order to download the latest client and extract the packet IDs from it.

```ts
import * as resx from '@realmlib/resx';
import * as fs from 'fs';
import * as path from 'path';

// fetch the latest version first.
resx.getClientVersion().then((version) => {
  console.log('Fetched version.');
  // then download the client.
  // it will be downloaded into memory in a `Buffer` instance.
  return resx.getClient(version);
}).then((clientBuffer) => {
  console.log('Downloaded client.');
  // create an extractor
  const extractor = new resx.Extractor(clientBuffer);

  // extract the packets and free the resources.
  const packets = extractor.packets();
  extractor.free();
  console.log('Extracted packets.');

  // length is divided by 2 because the map is bidirectional.
  console.log(`Extracted ${Object.keys(packets).length / 2} packets.`);

  const packetPath = path.join(__dirname, 'packets.json'); // save to the current directory.
  fs.writeFileSync(packetPath, JSON.stringify(packets));
  console.log('Done!');
});
```

## Acknowledgements

This project uses the following open source software

+ [rusted_realm](https://github.com/dmarcuse/rusted_realm)
