//
//  UIView+UIView_RecursiveFind.h
//  nitoTV4
//
//  Created by Kevin Bradley on 3/12/16.
//  Copyright © 2016 nito. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (RecursiveFind)

- (UIView *)findFirstSubviewWithClass:(Class)theClass;
- (void)printRecursiveDescription;
- (void)removeAllSubviews;
- (void)printAutolayoutTrace;
@end
