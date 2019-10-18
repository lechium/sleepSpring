#import "NSTask.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+RecursiveFind.h"
#include <sys/wait.h>
#include <sys/fcntl.h>



@interface UIAlertController (slide) 
- (void)slideRespringIntoSleepAlertIfNecessary;
@end

%hook UIAlertController

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
             //self.message = [NSString stringWithFormat:@"weaoutchea & %@", sleepMessage];
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

%hook PBAppDelegate

- (void)handleTVLongPressEvent:(id)arg1 { %log; %orig; }
- (void)handleTVTripleTapEvent { %log; %orig; }
- (void)handleTVDoubleTapEvent 	{ %log; %orig; }
- (void)handleTVTapEventAsThirdTapEventInAppSwitcher { %log; %orig; }
- (void)handleTVTapEvent { %log; %orig; }

%end



