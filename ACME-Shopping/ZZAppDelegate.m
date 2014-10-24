//
//  ZZAppDelegate.m
//  ACME-Shopping
//
//  Created by fady on 13-10-23.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ZZAppDelegate.h"

@implementation ZZAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(3);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	NSString *string = [url absoluteString];
	NSArray *array = [string componentsSeparatedByString:@":"];
	if ([[array objectAtIndex:1] isEqualToString:@"test"]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"12456"
															message:@"276543"
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles: nil];
		[alertView show];
	}
	
	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
