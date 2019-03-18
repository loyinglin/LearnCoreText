//
//  UIGestureRecognizer+SSUtil.m
//  TTReading
//
//  Created by loyinglin on 2019/3/17.
//  Copyright © 2019 ByteDance. All rights reserved.
//

#import "UIGestureRecognizer+SSUtil.h"

@implementation UIGestureRecognizer (SSUtil)

- (void)cancelCurrentGestureReccongizing {
    // disabled gesture recognizers will not receive touches. when changed to NO the gesture recognizer will be cancelled if it's currently recognizing a gesture
    self.enabled = NO;
    self.enabled = YES;
}

@end
