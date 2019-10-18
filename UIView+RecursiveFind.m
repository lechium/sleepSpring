//
//  UIView+UIView_RecursiveFind.m
//  nitoTV4
//
//  Created by Kevin Bradley on 3/12/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import "UIView+RecursiveFind.h"



@implementation UIView (RecursiveFind)



- (UIView *)findFirstSubviewWithClass:(Class)theClass {
    
    if ([self isKindOfClass:theClass]) {
            return self;
        }
    
    for (UIView *v in self.subviews) {
        UIView *theView = [v findFirstSubviewWithClass:theClass];
        if (theView != nil)
        {
            return theView;
        }
    }
    return nil;
}
- (void)printAutolayoutTrace
{
    // NSString *recursiveDesc = [self performSelector:@selector(recursiveDescription)];
    //NSLog(@"%@", recursiveDesc);
#if DEBUG
    NSString *trace = [self _recursiveAutolayoutTraceAtLevel:0];
    NSLog(@"%@", trace);
#endif
}


- (void)printRecursiveDescription
{
#if DEBUG
    NSString *recursiveDesc = [self performSelector:@selector(recursiveDescription)];
    NSLog(@"%@", recursiveDesc);
#else
    NSLog(@"BUILT FOR RELEASE, NO SOUP FOR YOU");
#endif
}

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}


@end
