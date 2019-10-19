#import "NSTask.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIAlertController (slide) 
- (void)slideRespringIntoSleepAlertIfNecessary;
@end

%hook UIAlertController

//an alternate but no long used approach to achieve the same goal, i think may change the ordering of the alert options
+(id)alertControllerWithTitle:(id)arg1 message:(id)arg2 preferredStyle:(long long)arg3 {

    %log;
    id orig = %orig;
    if ([orig respondsToSelector:@selector(slideRespringIntoSleepAlertIfNecessary)]){
        //[orig slideRespringIntoSleepAlertIfNecessary];
    }
    return orig;
}


- (void)viewWillAppear:(BOOL)animated {

    %orig;
    [self slideRespringIntoSleepAlertIfNecessary];
    
}

%new - (void)slideRespringIntoSleepAlertIfNecessary {

       NSString *sleepTitle = NSLocalizedString(@"PBSystemMenuSleepNowTitle", nil) ;
       NSString *sleepMessage = NSLocalizedString(@"PBSystemMenuSleepNowMessage", nil);
       if ([self.title isEqualToString:sleepTitle] && [self.message isEqualToString:sleepMessage]){
             self.title = [NSString stringWithFormat:@"Respring or %@", sleepTitle];
             UIAlertAction *respringAction = [UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                   [NSTask launchedTaskWithLaunchPath:@"/usr/bin/killall" arguments:@[@"-9", @"backboardd"]];
             }];
            [self addAction:respringAction];
            UIAlertAction *ldrestartAction = [UIAlertAction actionWithTitle:@"Reload Daemons" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                   [NSTask launchedTaskWithLaunchPath:@"/usr/bin/nitoHelper" arguments:@[@"-l"]];
             }];
            [self addAction:ldrestartAction];
        }
}

%end



