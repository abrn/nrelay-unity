# Changelog

## [4.1.2] - 2020-01-08

### Added

+ Exported some interfaces for servers and version info.

## [4.1.1] - 2020-01-08

### Fixed

+ Removed the clean step of the build process.

## [4.1.0] - 2020-01-08

### Added

+ Added a `getServers` function to get the list of game servers.

## [4.0.0] - 2019-05-30

### Changes

+ The rusted_realm extractor binaries have been replaced with a WASM binary.
+ `extractPackets` now takes a `Uint8Array` that contains the swf data instead of taking a path to the swf file.

## [3.0.3] - 2019-05-17

### Fixes

+ Spaces in the path to the executable will no longer prevent the executable from running.

## [3.0.2] - 2019-05-14

+ No code changes, uploaded build to npm properly.

## [3.0.1] - 2019-05-14

### Fixed

+ Made the lib files executable.

## [3.0.0] - 2019-05-14

### Added

+ Added the rusted_realm lib.
+ Added the `extractPackets` method to replace the functionality of the removed methods. See the readme for more info about this method.

### Removed

+ The JPEXS lib has been removed.
+ The exported methods `makeGSCPath`, `unpackSwf` and `extractPacketInfo` have been removed.

## [2.0.0] - 2019-02-24

### Added

+ Methods which were previously members of the `ResX` class are now simply exported functions. This means that `import * as resx from ...` will still work, but code such as `import { unpackSwf } from ...` will now work as well.

### Removed

+ The `ResX` class.

## [1.0.0] - 2019-02-22

+ Initial release.
