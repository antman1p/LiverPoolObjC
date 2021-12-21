//
//  main.m
//  LiverPoolObjC
//
//  Created by Antonio Piazza on 12/16/21.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

BOOL checkAuth(CLLocationManager *manager) {
    BOOL isAuth = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"[*] Determining availability of Location Services ...");
        NSLog(@"    [+] Location services is enabled on this device");
        //[manager startUpdatingLocation];
        //sleep(1);
        [manager requestWhenInUseAuthorization];
        [manager requestAlwaysAuthorization];
        
        NSString *authString;
        switch([manager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined :
                authString = @"    [-] The User has not chosen whether the app can use location services ";
                break;
            case  kCLAuthorizationStatusDenied :
                authString = @"    [-] The user denied the use of location services for the app or they are disabled globally in Settings";
                break;
            case kCLAuthorizationStatusRestricted :
                authString = @"    [-] The app is not authorized to use location services";
                isAuth = YES;
                break;
            case kCLAuthorizationStatusAuthorizedAlways :
                authString = @"    [+] The user authorized the app to start location services at any time";
                isAuth = YES;
                break;
            default:
                authString = @"    [-]LiverPoolObjC was unable to determine authorizationStatus";
        }
        NSLog(@"%@", authString);
      }
      else {
          NSLog(@"    [-] Location services is disabled on this device");
      }
    return isAuth;
}

void getAccuracy(CLLocationManager *manager) {
    if ([manager accuracyAuthorization] == CLAccuracyAuthorizationFullAccuracy) {
        NSLog(@"    [+] The application has access to location data with full accuracy");
    }
    else {
        NSLog(@"    [-] The application has access to location data with reduced accuracy");
    }
}

void getHeading(CLLocationManager *manager) {
    if ([manager headingAvailable]) {
            NSLog(@"    [+] Location manager can generate heading-related events");
        }
        else {
            NSLog(@"    [-] Location manager cannot generate heading-related events");
        }
}

void getLocation(CLLocationManager *manager) {
    NSString *latitude = [@([[manager location]coordinate].latitude) stringValue];
    NSString *longitude = [@([[manager location]coordinate].longitude) stringValue];
    NSString *altitude = [@([manager location].altitude) stringValue];
    NSString *horizontalAccuracy = [@([[manager location]horizontalAccuracy]) stringValue];
    NSString *verticalAccuracy = [@([[manager location]verticalAccuracy]) stringValue];
    id timestamp = [[manager location]timestamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MMM d, YYYY, HH:mm:ss";
    NSString *formattedTimestamp = [dateFormatter stringFromDate:timestamp];
    
    // Get floor level
    long level = 0;
    if ([[manager location]floor] != nil) {
        // https://stackoverflow.com/questions/60837128/clfloor-returns-level-2146959360, it's a bug ...
        if ([[manager location]floor].level != 2146959360) {
            level = [[manager location] floor].level;
        }
    }
    
    NSLog(@"[*] Getting location data ...");
    NSLog(@"     [+] Timestamp: %@", formattedTimestamp);
    NSLog(@"     [+] Latitude, Longitude: %@ %@", latitude, longitude);
    NSLog(@"     [+] Horizontal Accuracy: %@ meters", horizontalAccuracy);
    NSLog(@"     [+] Altitude: %@ meters", altitude);
    NSLog(@"     [+] Vertical Accuracy: %@ meters", verticalAccuracy);
    NSLog(@"     [+] Floor: %ld", level);
    
    // Get speed and course information
    NSLog(@"[*] Getting speed and course information ...");

    NSString *speed = [@([[manager location]speed]) stringValue];
    NSString *speedAccuracy = [@([[manager location]speedAccuracy]) stringValue ];
    NSString *course = [@([[manager location]course]) stringValue];
    NSString *courseAccuracy = [@([[manager location]courseAccuracy]) stringValue];
    if (([[manager location]speed] -1) > 0) {
        NSLog(@"     [+] Speed: %@ meters/second", speed);
    }
    else {
        NSLog(@"     [-] Speed could not be obtained");
    }
    
    if (([[manager location] speedAccuracy] -1) > 0) {
        NSLog(@"     [+] Speed Accuracy: %@ meters/second", speedAccuracy);
    }
    else {
        NSLog(@"     [-] Speed Accuracy could not be obtained");
    }
    if (([[manager location]course] -1) > 0) {
        NSLog(@"     [+] Course: %@° relative to due north", course);
    }
    else {
        NSLog(@"     [-] Course could not be obtained");
    }
    if (([[manager location] courseAccuracy]  -1) > 0) {
        NSLog(@"     [+] Course Accuracy: %@°", courseAccuracy);
    }
    else {
        NSLog(@"     [-] Course Accuracy could not be obtained");
    }

    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CLLocationManager *locMan = [[CLLocationManager alloc]init];
        BOOL authed = checkAuth(locMan);
        if (authed) {
            getAccuracy(locMan);
            getHeading(locMan);
            getLocation(locMan);
        }
        
    return 0;
    }
}
