//
//  AppDelegate.h
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MarketingCloudSDK/MarketingCloudSDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MarketingCloudSDK *sfmcSDK;

@end

