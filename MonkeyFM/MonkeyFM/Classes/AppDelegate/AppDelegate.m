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
#import <AVFoundation/AVFoundation.h>
#import "AVOSCloud/AVOSCloud.h"
#import "UMSocial.h"
//#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()<SWRevealViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    //获取夜间模式状态
    [ThemeManage shareThemeManage].isNight = [[NSUserDefaults standardUserDefaults] boolForKey:@"night"];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    BaseNavigationViewController *recommendNav = [[BaseNavigationViewController alloc] initWithRootViewController:[[RecommendViewController alloc] init]];
    [recommendNav.navigationBar NightWithType:UIViewColorTypeNormal];
    DrawerViewController *drawerVC = [[DrawerViewController alloc] init];
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:drawerVC frontViewController:recommendNav];
    mainRevealController.delegate = self;
    self.window.rootViewController = mainRevealController;
    
    // leanCloud
    [AVOSCloud setApplicationId:@"DU8A6QciEbo7IlkJccidr2Ko-gzGzoHsz"
                      clientKey:@"BYJ3oaaNNK0C6W6v9JtWdwjs"];
    // 跟踪统计应用的打开情况
    
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
     [UMSocialData setAppKey:@"577ba4d967e58e5e15002839"];
    
    //设置友盟社会化组件appkey
//    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
        secret:@"04b48b094faeb16683c32669824ebdad"
        RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
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
