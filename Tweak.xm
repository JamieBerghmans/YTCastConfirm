%hook MDXPlaybackRouteButtonController

-(void)didPressButton:(id)arg1 {

    UIAlertController* alertController = [%c(UIAlertController) alertControllerWithTitle:@"Casting"
                               message:@"Are you sure you want to start casting?"
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [%c(UIAlertAction) actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        %orig;
    }];

    UIAlertAction* noButton = [%c(UIAlertAction)
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler: ^(UIAlertAction * action) {
        return;
    }];


    [alertController addAction:defaultAction];
    [alertController addAction:noButton];
    
    id rootViewController = [%c(UIApplication) sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[%c(UINavigationController) class]]) {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if([rootViewController isKindOfClass:[%c(UITabBarController) class]]) {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    if ([rootViewController presentedViewController] != nil) {
        rootViewController = [rootViewController presentedViewController];
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

%end