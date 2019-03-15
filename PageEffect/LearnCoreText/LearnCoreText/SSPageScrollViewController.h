//
//  SSPageScrollViewController.h
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/15.
//  Copyright © 2019 Loying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSPageScrollViewController;
@protocol SSPageScrollViewControllerDelegate <NSObject>

- (UIViewController *)pageScrollViewControllGetLastVC:(SSPageScrollViewController *)scrollVC;

- (UIViewController *)pageScrollViewControllGetNextVC:(SSPageScrollViewController *)scrollVC;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SSPageScrollViewController : UIViewController

@property (nonatomic, weak) id<SSPageScrollViewControllerDelegate> delegate;

- (void)setInitVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
