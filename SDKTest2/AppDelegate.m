//
//  AppDelegate.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "AppDelegate.h"
#import "ETPush.h"
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
#ifdef DEBUG
  // Set to YES to enable logging while debugging
  [ETPush setETLoggerToRequiredState:YES];
  
  // configure and set initial settings of the JB4ASDK
  successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug
                                            andAccessToken:kETAccessToken_Debug
                                             withAnalytics:YES
                                       andLocationServices:YES       // ONLY SET TO YES IF PURCHASED AND USING GEOFENCE CAPABILITIES
                                      andProximityServices:NO       // ONLY SET TO YES IF PURCHASED AND USING BEACONS
                                             andCloudPages:YES       // ONLY SET TO YES IF PURCHASED AND USING CLOUDPAGES
                                           withPIAnalytics:YES
                                                     error:&error];
#else
  // configure and set initial settings of the JB4ASDK
  successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod
                                            andAccessToken:kETAccessToken_Prod
                                             withAnalytics:YES
                                       andLocationServices:YES       // ONLY SET TO YES IF PURCHASED AND USING GEOFENCE CAPABILITIES
                                      andProximityServices:NO       // ONLY SET TO YES IF PURCHASED AND USING BEACONS
                                             andCloudPages:YES       // ONLY SET TO YES IF PURCHASED AND USING CLOUDPAGES
                                           withPIAnalytics:YES
                                                     error:&error];
  
#endif
  //
  // if configureSDKWithAppID returns NO, check the error object for detailed failure info. See PushConstants.h for codes.
  // the features of the JB4ASDK will NOT be useable unless configureSDKWithAppID returns YES.
  //
  if (!successful) {
    dispatch_async(dispatch_get_main_queue(), ^{
      // something failed in the configureSDKWithAppID call - show what the error is
      [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed configureSDKWithAppID!", @"Failed configureSDKWithAppID!")
                                  message:[error localizedDescription]
                                 delegate:nil
                        cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                        otherButtonTitles:nil] show];
    });
  }
  else {
    
    // create "interactive notification" buttons and register for push notifications with a category
    //
    // this is a sample only.  Please adjust for your specific circumstances.
    // when the notification is displayed in the notification center and the category named "Example"
    // is included with the payload, then the notification displayed in the notification center will
    // have 2 buttons ("View Offer" and "Add to Passbook"), depending on how much room is available
    
    // create a user action for View Offer Button
    UIMutableUserNotificationAction *actionButton1 = [[UIMutableUserNotificationAction alloc] init];
    actionButton1.identifier = @"Approve";
    actionButton1.title = @"Approve Now";
    
    // create a user action for Add to Passbook Button
    UIMutableUserNotificationAction *actionButton2 = [[UIMutableUserNotificationAction alloc] init];
    actionButton2.identifier = @"Decline";
    actionButton2.title = @"Decline Now";
    
    // create a category to let Apple know that we want these buttons displayed - will be sent down with the APNS payload
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"INTER_1";
    
    // these will be the default context button(s)
    [category setActions:@[actionButton1, actionButton2] forContext:UIUserNotificationActionContextDefault];
    
    // these will be the minimal context button(s)
    [category setActions:@[actionButton1] forContext:UIUserNotificationActionContextMinimal];
    
    // make a set of all categories the app will support - just one for now
    NSSet *categories = [NSSet setWithObjects:category, nil];
    
    // register for push notifications - enable all notification types, one category
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                                                             categories:categories];
    
    // register for push notifications - enable all notification types, one category
    [[ETPush pushManager] registerUserNotificationSettings:settings];
    [[ETPush pushManager] registerForRemoteNotifications];

    // inform the JB4ASDK of the launch options
    // possibly UIApplicationLaunchOptionsRemoteNotificationKey or UIApplicationLaunchOptionsLocalNotificationKey
    [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
    
    
    // This method is required in order for location messaging to work and the user's location to be processed
    // Only call this method if you have LocationServices set to YES in configureSDK()
    [[ETLocationManager sharedInstance] startWatchingLocation];
  }
  
  //clear the badge number
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
  return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
  // inform the JB4ASDK of the notification settings requested
  [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  // inform the JB4ASDK of the device token
  [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  // inform the JB4ASDK that the device failed to register and did not receive a device token
  [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
  // inform the JB4ASDK that the device received a local notification
  [[ETPush pushManager] handleLocalNotification:notification];
}

// handle category actions for remote notifications
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
  // inform the JB4ASDK that the device received a remote notification
  [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
  
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
  [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
  
  // is it a silent push?
  if (userInfo[@"aps"][@"content-available"]) {
    // received a silent remote notification...
    
    // indicate a silent push
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
  }
  else {
    // received a remote notification...
    
    // clear the badge
    [[ETPush pushManager] resetBadgeCount];
  }
  
  [AppDelegate setColorFromUserInfo:userInfo viewController:((ViewController *)self.window.rootViewController)];
  
  handler(UIBackgroundFetchResultNoData);
}

+ (void)setColorFromUserInfo:(NSDictionary *)userInfo viewController:(ViewController *)controller {
  // get the custom key from the payload as defined in the SFMC
  NSString *colorHex = [userInfo objectForKey:@"ColorPrimary"];
  NSLog(@"color string: %@", colorHex);
  UIColor *colorFromServer = [ColorHelper colorWithHexString:colorHex];
  [controller setBackgroundColor:colorFromServer];
}

@end
