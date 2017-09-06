//
//  AppDelegate.h
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/2/8.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (instancetype) getInstance;

- (void) runMainViewController : (UIViewController *) childViewController;

- (void) runLoginViewController : (UIViewController *) childViewController;
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret;

@property (nonatomic,strong) UIViewController * mainViewController;

@end

