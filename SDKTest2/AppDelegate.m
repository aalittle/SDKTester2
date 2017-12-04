//
//  AppDelegate.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "AppDelegate.h"
#import "ColorHelper.h"
#import "ViewController.h"

// AppCenter AppIDs and Access Tokens for the debug and production versions of your app
// These values should be stored securely by your application or retrieved from a remote server
static NSString *kETAppID_Debug       = @"c81c3343-f4f2-4e8f-97e9-0dada2386868";            // uses Sandbox APNS for debug builds
static NSString *kETAccessToken_Debug = @"qke7h2vckbc8xm6js8xh7anm";
static NSString *kETAppID_Prod        = @"f8b6bbda-3ee0-4341-9930-1071fd75b421";       // uses Production APNS
static NSString *kETAccessToken_Prod  = @"yu5nj62ad99xday3rcngaxfy";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  BOOL successful = NO;
  NSError *error = nil;

  self.sfmcSDK = [[MarketingCloudSDK alloc] init];
  BOOL configured = [self.sfmcSDK sfmc_configure:&error completionHandler:^(BOOL configured, NSError * _Nullable error) {
    if (error) {
      NSLog(@"%@", [error localizedDescription]);
    }
    else {
      [UNUserNotificationCenter currentNotificationCenter].delegate = self;
      [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error == nil) {
          if (granted == YES) {
            os_log_info(OS_LOG_DEFAULT, "Authorized for notifications = %s", granted ? "YES" : "NO");
          }
        }
      }];
    }
  }];
  
  if (configured == YES) {
    // This method is required in order for location messaging to work and the user's location to be processed
    // Only call this method if you have LocationServices set to YES in configureSDK()
    //[self.sfmcSDK sfmc_startWatchingLocation];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *currentDeviceId = [[[device identifierForVendor]UUIDString] substringToIndex:3];
    NSString *emailAddress = [NSString stringWithFormat:@"alittle+%@@salesforce.com", currentDeviceId];
    NSLog(@"%@", emailAddress);
    [self.sfmcSDK sfmc_setContactKey:emailAddress];
    [self.sfmcSDK sfmc_setAttributeNamed:@"Phone Name" value: device.name];
  } else {
    
  }
  
  //clear the badge number
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
  return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  // inform the JB4ASDK of the device token
  //[[ETPush pushManager] registerDeviceToken:deviceToken];
  [self.sfmcSDK sfmc_setDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  // inform the JB4ASDK that the device failed to register and did not receive a device token
  //[[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}


// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
  
  // tell the MarketingCloudSDK about the notification
  [self.sfmcSDK sfmc_setNotificationRequest:response.notification.request];
  
  if (completionHandler != nil) {
    completionHandler();
  }
}

// handle category actions for remote notifications
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
  // inform the JB4ASDK that the device received a remote notification
  if ([identifier isEqualToString:@"Approve"]) {
    // specific code to handle the notification
  }
  else if ([identifier isEqualToString:@"Decline"]) {
    // specific code to handle the notification
  }
  
  completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {
  
  // inform the JB4ASDK that the device received a remote notification
  // is it a silent push?
  if (userInfo[@"aps"][@"content-available"]) {
    // received a silent remote notification...
    
    // indicate a silent push
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
  }
  else {
    // received a remote notification...    
  }
  
  [AppDelegate setColorFromUserInfo:userInfo viewController:((ViewController *)self.window.rootViewController)];
  
  handler(UIBackgroundFetchResultNoData);
}

+ (void)setColorFromUserInfo:(NSDictionary *)userInfo viewController:(ViewController *)controller {
  // get the custom key from the payload as defined in the SFMC
  NSString *colorHex = [userInfo objectForKey:@"ColorPrimary"];
  NSLog(@"color string: %@", colorHex);
  UIColor *colorFromServer = [ColorHelper colorWithHexString:colorHex];
  if(colorFromServer != nil) {
    [controller setBackgroundColor:colorFromServer];
  }
}
@end
