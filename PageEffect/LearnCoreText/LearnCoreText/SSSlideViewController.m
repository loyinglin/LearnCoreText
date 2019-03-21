//
//  SSPageScrollViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/15.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SSSlideViewController.h"
#import "UIView+LYLayout.h"
#import "UIGestureRecognizer+SSUtil.h"

typedef NS_ENUM(NSUInteger, SSReaderPageEffectViewStatus) {
    SSReaderPageEffectViewStatusDefault, // 没有页面移动
    SSReaderPageEffectViewStatusMovingToNextPage, // 移动旧的页面，则是翻下一页
    SSReaderPageEffectViewStatusMovingToLastPage, // 移动新的界面，则是返回上一页
};

@interface SSSlideViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) SSReaderPageEffectViewStatus currentStatus;
@property (nonatomic, strong) UIViewController *moveVC;
@property (nonatomic, strong) UIViewController *showVC;


@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, assign) BOOL bMoveNextEnable;
@property (nonatomic, assign) BOOL bMoveLastEnable;

@end

@implementation SSSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customInit];
}


- (void)customInit {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGes:)];
    [self.view addGestureRecognizer:panRecognizer];
    panRecognizer.delegate = self;
    self.panRecognizer = panRecognizer;
    
    self.bMoveLastEnable = self.bMoveNextEnable = YES;
    
}

#pragma mark - getter&setter

- (void)setInitVC:(UIViewController *)vc {
    [self resetStatus];
    if (vc) {
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        self.showVC = vc;
    }
    else {
        SSLOG_INFO(@"error, set empty initVC");
    }
}

- (void)resetStatus {
    if (self.showVC) {
        [self.showVC removeFromParentViewController];
        [self.showVC.view removeFromSuperview];
    }
    if (self.moveVC) {
        [self.moveVC removeFromParentViewController];
        [self.moveVC.view removeFromSuperview];
    }
    self.currentStatus = SSReaderPageEffectViewStatusDefault;
    self.bMoveLastEnable = self.bMoveNextEnable = YES;
}
#pragma mark - action

#pragma mark - delegate

#pragma mark - private

#define kCompleteRate (0.33)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panRecognizer) {
        return self.currentStatus == SSReaderPageEffectViewStatusDefault;
    }
    return YES;
}

- (void)onPanGes:(UIPanGestureRecognizer *)rec {
    if (!self.showVC) {
        SSLOG_INFO(@"error, no current show vc");
        return ;
    }
    CGPoint point = [rec translationInView:self.view];
    static CGPoint startPoint;
    //手势开始
    if (rec.state == UIGestureRecognizerStateBegan) {
        startPoint = point;
    }
    CGFloat dis = (point.x - startPoint.x);
    if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
        dis = MIN(dis, 0);
    }
    else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage) {
        dis = MAX(dis, 0);
    }
    CGFloat rate = fabs(dis / (self.view.width * 0.5));
    if (rate <= 0) {
        rate = 0;
    }
    else if (rate > 1) {
        rate = 1;
    }
    
    //手势进行
    if (rec.state == UIGestureRecognizerStateChanged) {
        if (self.currentStatus == SSReaderPageEffectViewStatusDefault) { // 用户开始移动，此时判断是左移还是右移
            if (point.x >= startPoint.x) { // 右移
                self.currentStatus = SSReaderPageEffectViewStatusMovingToLastPage;
            }
            else {
                self.currentStatus = SSReaderPageEffectViewStatusMovingToNextPage;
            }
            if (self.delegate) {
                if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage) {
                    UIViewController *lastVC = [self.delegate slideViewControllerGetLastVC:self];
                    if (!lastVC) {
                        [rec cancelCurrentGestureReccongizing];
                        self.currentStatus = SSReaderPageEffectViewStatusDefault;
                        SSLOG_INFO(@"info, reach last end");
                    }
                    else {
                        [self addChildViewController:lastVC];
                        [self.view insertSubview:lastVC.view aboveSubview:self.showVC.view];
                        self.moveVC = lastVC;
                        [self addMaskToVC:self.moveVC];
                    }
                }
                else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
                    UIViewController *nextVC = [self.delegate slideViewControllerGetNextVC:self];
                    if (!nextVC) {
                        [rec cancelCurrentGestureReccongizing];
                        self.currentStatus = SSReaderPageEffectViewStatusDefault;
                        SSLOG_INFO(@"info, reach next end");
                    }
                    else {
                        [self addChildViewController:nextVC];
                        [self.view insertSubview:nextVC.view belowSubview:self.showVC.view];
                        self.moveVC = self.showVC;
                        self.showVC = nextVC;
                        [self addMaskToVC:self.moveVC];
                    }
                }
                
                if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage) {
                    [self.delegate slideViewController:self willTransitionToViewControllers:self.moveVC];
                }
                else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
                    [self.delegate slideViewController:self willTransitionToViewControllers:self.showVC];
                }
            }
        }
        if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage && self.bMoveNextEnable) {
            self.moveVC.view.right = self.view.width * (1 - rate);
        }
        else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage && self.bMoveLastEnable) {
            self.moveVC.view.right = self.view.width * rate;
        }
    }
    //手势结束
    else if (rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateCancelled) {
        SSLOG_INFO(@"info, gesture end with status:%lu", (unsigned long)self.currentStatus);
        rate = rate >= kCompleteRate ? 1 : 0;
        if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage && self.bMoveLastEnable) {
            if (self.moveVC) { 
                [UIView animateWithDuration:0.2 animations:^{
                    self.moveVC.view.right = self.view.width * rate;
                } completion:^(BOOL finished) {
                    if (self.delegate) {
                        [self.delegate slideViewController:self previousViewController:self.showVC transitionCompleted:rate == 1];
                    }
                    if (rate == 1) {
                        [self.showVC removeFromParentViewController];
                        [self.showVC.view removeFromSuperview];
                        self.showVC = self.moveVC;
                    }
                    else {
                        [self.moveVC removeFromParentViewController];
                        [self.moveVC.view removeFromSuperview];
                    }
                    self.moveVC = nil;
                    
                    self.currentStatus = SSReaderPageEffectViewStatusDefault;
                }];
            }
        }
        if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage && self.bMoveNextEnable) {
            if (self.moveVC) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.moveVC.view.right = self.view.width * (1 - rate);
                } completion:^(BOOL finished) {
                    if (self.delegate) {
                        [self.delegate slideViewController:self previousViewController:self.moveVC transitionCompleted:rate == 1];
                    }
                    if (rate == 1) {
                        [self.moveVC removeFromParentViewController];
                        [self.moveVC.view removeFromSuperview];
                    }
                    else {
                        [self.showVC removeFromParentViewController];
                        [self.showVC.view removeFromSuperview];
                        self.showVC = self.moveVC;
                    }
                    self.moveVC = nil;
                    
                    self.currentStatus = SSReaderPageEffectViewStatusDefault;
                }];
            }
        }
        else {
            SSLOG_INFO(@"error");
        }
    }
}

- (void)addMaskToVC:(UIViewController *)vc {
    vc.view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8].CGColor;
    vc.view.layer.shadowOffset = CGSizeMake(5, 5);
    vc.view.layer.shadowOpacity = 0.8;
    vc.view.layer.shadowRadius = 6;
}

- (NSArray<UIViewController *> *)viewControllers {
    return self.childViewControllers;
}

- (void)onGestureEnd {
    
}
@end
