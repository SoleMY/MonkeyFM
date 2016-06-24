//
//  AppDelegate.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AppDelegate.h"
#import "RecommendViewController.h"
#import "BaseNavigationViewController.h"
#import "SWRevealViewController.h"
#import "DrawerViewController.h"

@interface AppDelegate ()<SWRevealViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    BaseNavigationViewController *recommendNav = [[BaseNavigationViewController alloc] initWithRootViewController:[[RecommendViewController alloc] init]];
    DrawerViewController *drawerVC = [[DrawerViewController alloc] init];
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:drawerVC frontViewController:recommendNav];
    mainRevealController.delegate = self;
    self.window.rootViewController = mainRevealController;
    
    
    return YES;
}

//- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
//{
//    NSString *str = nil;
//    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
//    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
//    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
//    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
//    return str;
//}
//- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
//{
//    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
//}
//
//- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
//{
//    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
//}
//
//- (void)revealController:(SWRevealViewController *)revealController willRevealRearViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController willHideRearViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//- (void)revealController:(SWRevealViewController *)revealController didHideRearViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController willShowFrontViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController didShowFrontViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController willHideFrontViewController:(UIViewController *)rearViewController
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)revealController:(SWRevealViewController *)revealController didHideFrontViewController:(UIViewController *)rearViewController
//
//{
//    NSLog( @"%@", NSStringFromSelector(_cmd));
//}
//

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
