# LiverPoolObjC
A port of [@slyd0g](https://twitter.com/slyd0g)'s ([github](https://github.com/slyd0g)) SwiftLiverPool from Swift to Objective-C

## Blogpost
[@slyd0g](https://medium.com/@slyd0g)'s Medium post:
https://medium.com/@slyd0g/where-in-the-world-is-carmen-sandiego-abusing-location-services-on-macos-10e9f4eefb71

## Description

This tool leverages the CoreLocation API on macOS to enumerate Location Services data. You need to enable "Location Services" permission for the tool for this to work.

## Usage
- Build with XCode
- Analyze availability of Location Services and dump location, speed, and course data if available
    - ```./LiverPoolObjC```
    - Enable ```System Preferences > Privacy > Location Services``` for ```LiverPoolObjC```
    - Run ```./LiverPoolObjC``` again

## References
- https://developer.apple.com/documentation/corelocation/cllocationmanager
