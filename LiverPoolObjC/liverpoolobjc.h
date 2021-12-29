//
//  liverpoolobjc.h
//  LiverPoolObjC
//
//  Created by Johnny Mnemonic on 12/28/21.
//

#ifndef liverpoolobjc_h
#define liverpoolobjc_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationService : NSObject <CLLocationManagerDelegate>

-(BOOL) checkAuth: (CLLocationManager*) mgr;
-(void) getAccuracy: (CLLocationManager*) mgr;
-(void) getHeading: (CLLocationManager*) mgr;
-(void) getHeading: (CLLocationManager*) mgr;

@end

#endif /* liverpoolobjc_h */
