//
//  SSPageScrollViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/15.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SSPageScrollViewController.h"
#import "UIView+LYLayout.h"

typedef NS_ENUM(NSUInteger, SSReaderPageEffectViewStatus) {
    SSReaderPageEffectViewStatusDefault, // 没有页面移动
    SSReaderPageEffectViewStatusMovingToNextPage, // 移动旧的页面，则是翻下一页
    SSReaderPageEffectViewStatusMovingToLastPage, // 移动新的界面，则是返回上一页
};

@interface SSPageScrollViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) SSReaderPageEffectViewStatus currentStatus;
@property (nonatomic, strong) UIViewController *moveVC;
@property (nonatomic, strong) UIViewController *showVC;


@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, assign) BOOL bMoveNextEnable;
@property (nonatomic, assign) BOOL bMoveLastEnable;

@end

@implementation SSPageScrollViewController

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
    if (vc) {
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        self.showVC = vc;
    }
    else {
        NSLog(@"error, set empty initVC");
    }
}

#pragma mark - action

#pragma mark - delegate

#pragma mark - private

#define kCompleteRate (0.0)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panRecognizer) {
        return self.currentStatus == SSReaderPageEffectViewStatusDefault;
    }
    return YES;
}

- (void)onPanGes:(UIPanGestureRecognizer *)rec {
    if (!self.showVC) {
        NSLog(@"error, no current show vc");
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
                    UIViewController *lastVC = [self.delegate pageScrollViewControllGetLastVC:self];
                    if (!lastVC) {
                        self.bMoveLastEnable = NO;
                        self.currentStatus = SSReaderPageEffectViewStatusDefault;
                        NSLog(@"info, reach last end");
                        return ;
                    }
                    [self addChildViewController:lastVC];
                    [self.view insertSubview:lastVC.view aboveSubview:self.showVC.view];
                    self.moveVC = lastVC;
                }
                else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
                    UIViewController *nextVC = [self.delegate pageScrollViewControllGetNextVC:self];
                    if (!nextVC) {
                        self.bMoveNextEnable = NO;
                        self.currentStatus = SSReaderPageEffectViewStatusDefault;
                        NSLog(@"info, reach next end");
                        return ;
                    }
                    [self addChildViewController:nextVC];
                    [self.view insertSubview:nextVC.view belowSubview:self.showVC.view];
                    self.moveVC = self.showVC;
                    self.showVC = nextVC;
                }
                if (self.moveVC) {
                    self.moveVC.view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
                    self.moveVC.view.layer.shadowOffset = CGSizeMake(-3, -3);
                    self.moveVC.view.layer.shadowOpacity = 1;
                    self.moveVC.view.layer.shadowRadius = 10;
                }
            }
            // todo delegate get view
        }
        if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage && self.bMoveNextEnable) {
            self.moveVC.view.right = self.view.width * (1 - rate);
        }
        else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage && self.bMoveLastEnable) {
            self.moveVC.view.right = self.view.width * rate;
        }
    }
    //手势结束
    else if (rec.state == UIGestureRecognizerStateEnded) {
        NSLog(@"info, gesture end with status:%lu", self.currentStatus);
        if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage || self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
            rate = rate >= kCompleteRate ? 1 : 0;
            [UIView animateWithDuration:0.2 animations:^{
                if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
                    self.moveVC.view.right = self.view.width * (1 - rate);
                }
                else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage) {
                    self.moveVC.view.right = self.view.width * rate;
                }
            } completion:^(BOOL finished) {
                if (self.currentStatus == SSReaderPageEffectViewStatusMovingToLastPage) {
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
                }
                else if (self.currentStatus == SSReaderPageEffectViewStatusMovingToNextPage) {
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
                }
                
                self.currentStatus = SSReaderPageEffectViewStatusDefault;
            }];
        }
        else {
            NSLog(@"error");
        }
        
    }
}

- (void)onGestureEnd {
    
}
@end
