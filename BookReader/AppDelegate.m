//
//  AppDelegate.m
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *choise = [defaults objectForKey:@"showController"];
    NSLog(@"%@", choise);
    
    UISplitViewController *splitViewController = (UISplitViewController *) self.window.rootViewController;
    DetailViewController *detailView = (DetailViewController *) [[splitViewController.viewControllers lastObject] topViewController];
    MasterViewController *masterView = (MasterViewController *) [[splitViewController.viewControllers objectAtIndex:0] topViewController];
    
    masterView.detailDelegate = detailView;
    splitViewController.delegate = detailView;
    
   self.data = [[DataSource alloc] init];
    
    return YES;
}

- (void) addNewBook
{  
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
