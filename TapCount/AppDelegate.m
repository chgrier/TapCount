//
//  AppDelegate.m
//  TapCount
//
//  Created by Charles Grier on 9/10/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ReportViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    /* -- for single view controller
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    
    ViewController *controller = (ViewController *)navigationController.topViewController;
    
    controller.managedObjectContext = self.managedObjectContext;
    

    return YES;
    */
    
    // for TabViewController - Main counter ViewController
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    ViewController *viewController = (ViewController *)tabBarController.viewControllers[0];
    
    viewController.managedObjectContext = self.managedObjectContext;
    
    // for ReportViewController (table list of reports)
    UINavigationController *navigationController = (UINavigationController *)tabBarController.viewControllers[1];
    
    ReportViewController *reportViewController = (ReportViewController *)navigationController.viewControllers[0];
    
    reportViewController.managedObjectContext = self.managedObjectContext;
    
    return YES;
    
    /*
     UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
     
     CurrentLocationViewController *currentLocationViewController = (CurrentLocationViewController *)tabBarController.viewControllers[0];
     currentLocationViewController.managedObjectContext = self.managedObjectContext;
     
     UINavigationController *navigationController = (UINavigationController *)tabBarController.viewControllers[1];
     LocationsViewController *locationsViewController = (LocationsViewController *)navigationController.viewControllers[0];
     locationsViewController.managedObjectContext = self.managedObjectContext;
     
     MapViewController *mapViewController = (MapViewController *)tabBarController.viewControllers[2];
     mapViewController.managedObjectContext = self.managedObjectContext;
     
*/

}
						

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel == nil) {
        NSString *modelPath = [[NSBundle mainBundle]
                               pathForResource:@"DataModel" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        _managedObjectModel = [[NSManagedObjectModel alloc]
                               initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}
- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    return documentsDirectory;
}
- (NSString *)dataStorePath

{
    return [[self documentsDirectory]
            stringByAppendingPathComponent:@"DataStore.sqlite"];
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:
                           [self dataStorePath]];
        _persistentStoreCoordinator =
        [[NSPersistentStoreCoordinator alloc]
         initWithManagedObjectModel:self.managedObjectModel];
        NSError *error;
        if (![_persistentStoreCoordinator
              addPersistentStoreWithType:NSSQLiteStoreType
              configuration:nil URL:storeURL options:nil
              error:&error]) {
            NSLog(@"Error adding persistent store %@, %@", error,
                  [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *coordinator =
        self.persistentStoreCoordinator;
        if (coordinator != nil) {
            _managedObjectContext =
            [[NSManagedObjectContext alloc] init];
            [_managedObjectContext
             setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}


@end
