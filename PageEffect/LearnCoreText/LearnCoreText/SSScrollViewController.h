//
//  SSScorllViewController.h
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/18.
//  Copyright © 2019 Loying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSScrollViewController;
@protocol SSScrollViewControllerDelegate <NSObject>

- (UIViewController *)scrollViewControllerGetLastVC:(SSScrollViewController *)scrollVC;

- (UIViewController *)scrollViewControllerGetNextVC:(SSScrollViewController *)scrollVC;

- (void)scrollViewController:(SSScrollViewController *)scrollVC currentShowViewController:(UIViewController *)viewController;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SSScrollViewController : UIViewController


/**
 是否对首屏内容进行填充，保证满屏显示；default是NO
 */
@property (nonatomic, assign) BOOL shouldFullFill;

@property (nonatomic, weak) id<SSScrollViewControllerDelegate> delegate;

@property(readonly, nonatomic) NSArray<__kindof UIViewController *> *viewControllers;

- (void)setInitVC:(UIViewController *)vc;

@end


NS_ASSUME_NONNULL_END
