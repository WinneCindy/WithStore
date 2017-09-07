//
//  AppDelegate.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/2/8.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "JYHNavigationController.h"
static AppDelegate * appDelegate;
@interface AppDelegate ()<RDVTabBarControllerDelegate>

@end

@implementation AppDelegate

+ (instancetype) getInstance {
    return appDelegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    appDelegate = self;
    [[LoginManager getInstance] checkLoginfinish:^(Boolean success) {
        if (success) {
            [self runMainViewController : nil];
            
        } else {
            
            loginViewController *login = [[loginViewController alloc] init];
            [self runLoginViewController : login];
        }
    }];
    
    
    return YES;
}



- (void) runMainViewController : (UIViewController *) childViewController{
    
    if (childViewController) {
        [childViewController.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (self.mainViewController)
        [self.mainViewController removeFromParentViewController];
    
    MainTabBarController * viewController = [[MainTabBarController alloc] init];
    viewController.delegate = self;
    self.mainViewController = [[JYHNavigationController alloc] initWithRootViewController:viewController];
    
    //        self.drawerController = [[MainTabBarController alloc] init];
    
    [self.window setRootViewController:self.mainViewController];
    
    [self.window makeKeyAndVisible];
    
}

- (void) runLoginViewController : (UIViewController *) childViewController{
    
    if (childViewController) {
        [childViewController.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (self.mainViewController)
        [self.mainViewController removeFromParentViewController];
    
    loginViewController * viewController = [[loginViewController alloc] init];
    
    self.mainViewController = [[JYHNavigationController alloc] initWithRootViewController:viewController];
    
    [self.window setRootViewController:self.mainViewController];
    
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
