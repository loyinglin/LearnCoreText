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

- (UIViewController *)pageScrollViewControllerGetLastVC:(SSPageScrollViewController *)scrollVC;

- (UIViewController *)pageScrollViewControllerGetNextVC:(SSPageScrollViewController *)scrollVC;

- (void)pageScrollViewController:(SSPageScrollViewController *)scrollVC previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed;

- (void)pageScrollViewController:(SSPageScrollViewController *)scrollVC willTransitionToViewControllers:(UIViewController *)pendingViewController;


@end


NS_ASSUME_NONNULL_BEGIN

@interface SSPageScrollViewController : UIViewController

@property (nonatomic, weak) id<SSPageScrollViewControllerDelegate> delegate;

- (void)setInitVC:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
