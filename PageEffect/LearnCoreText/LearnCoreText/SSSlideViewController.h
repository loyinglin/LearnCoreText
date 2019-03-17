//
//  SSPageScrollViewController.h
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/15.
//  Copyright © 2019 Loying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSSlideViewController;
@protocol SSSlideViewControllerDelegate <NSObject>

- (UIViewController *)slideViewControllerGetLastVC:(SSSlideViewController *)scrollVC;

- (UIViewController *)slideViewControllerGetNextVC:(SSSlideViewController *)scrollVC;

- (void)slideViewController:(SSSlideViewController *)scrollVC previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed;

- (void)slideViewController:(SSSlideViewController *)scrollVC willTransitionToViewControllers:(UIViewController *)pendingViewController;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SSSlideViewController : UIViewController

@property (nonatomic, weak) id<SSSlideViewControllerDelegate> delegate;

- (void)setInitVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
