//
//  SSScorllViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/18.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SSScrollViewController.h"
#import "UIView+LYLayout.h"
#import "UIGestureRecognizer+SSUtil.h"

@interface SSScrollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIViewController *> *vcArr;
@property (nonatomic, weak) UIViewController *currentVC;

@end

@implementation SSScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vcArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height * 3);
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - init

#pragma mark - getter&setter

- (void)setInitVC:(UIViewController *)vc {
    [self resetStatus];
    
    [self addChildViewController:vc];
    [self.vcArr addObject:vc];
    vc.view.top = self.scrollView.contentOffset.y;
    [self.scrollView addSubview:vc.view];
    self.currentVC = vc;
}

- (void)fullFillContent {
    CGFloat downFillY;
    if (self.viewControllers && self.viewControllers.count > 0) {
        UIViewController *vc = [self.viewControllers lastObject];
        downFillY = vc.view.bottom;
    }
    else {
        downFillY = self.scrollView.contentOffset.y;
    }
    while (downFillY < self.scrollView.contentOffset.y + self.scrollView.height) {
        if (!self.delegate) {
            NSLog(@"error, empty delegate");
            break;
        }
        UIViewController *vc = [self.delegate scrollViewControllerGetNextVC:self];
        if (!vc) {
            NSLog(@"info, reach next end");
            break;
        }
        
        [self.vcArr addObject:vc];
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        vc.view.top = downFillY;
        downFillY = vc.view.bottom;
        NSLog(@"info, add next vc, frame:%@", NSStringFromCGRect(vc.view.frame));
    }
}

- (NSArray<UIViewController *> *)viewControllers {
    return self.vcArr;
}

- (void)resetStatus {
    for (int i = 0; i < self.vcArr.count; ++i) {
        UIViewController *vc = [self.vcArr lastObject];
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    [self.vcArr removeAllObjects];
    [self safeSetContentOffsetY:self.scrollView.height];
}
#pragma mark - action

- (void)updateAllViewsWithOffset:(CGFloat)offset {
    SSLOG_INFO(@"updateAllViewsWithOffset, offset:%f", offset);
    for (int i = 0; i < self.vcArr.count; ++i) {
        UIViewController *vc = [self.vcArr objectAtIndex:i];
        vc.view.top += offset;
    }
    SSLOG_INFO(@"current offset:%@", NSStringFromCGPoint(self.scrollView.contentOffset));
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + offset)];
}

- (CGFloat)getVCMaxY {
    CGFloat ret = 0;
    if (self.viewControllers.count > 0) {
        ret = [self.viewControllers lastObject].view.bottom;
    }
    return ret;
}

- (CGFloat)getVCMinY {
    CGFloat ret = 0;
    if (self.viewControllers.count > 0) {
        ret = [self.viewControllers firstObject].view.top;
    }
    return ret;
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < [self getVCMinY]) { // 上面没vc了
        if (self.delegate) {
            UIViewController *vc = [self.delegate scrollViewControllerGetLastVC:self];
            if (vc) {
                [self addChildViewController:vc];
                vc.view.bottom = [self getVCMinY];
                [self.scrollView addSubview:vc.view];
                [self.vcArr insertObject:vc atIndex:0];
            }
        }
        if (scrollView.contentOffset.y < [self getVCMinY]) {
            [self safeSetContentOffsetY:[self getVCMinY]];
            [scrollView.panGestureRecognizer cancelCurrentGestureReccongizing];
        }
    }
    else if (scrollView.contentOffset.y + scrollView.height > [self getVCMaxY]) {
        if (self.delegate) {
            UIViewController *vc = [self.delegate scrollViewControllerGetNextVC:self];
            if (vc) {
                [self addChildViewController:vc];
                [self.scrollView addSubview:vc.view];
                vc.view.top = [self getVCMaxY];
                [self.vcArr addObject:vc];
            }
        }
        if (scrollView.contentOffset.y + scrollView.height > [self getVCMaxY]) {
            [self safeSetContentOffsetY:[self getVCMaxY] - scrollView.height];
        }
    }
    
    // check top
    if (self.vcArr && self.vcArr.count > 0) {
        UIViewController *vc = [self.vcArr firstObject];
        if (vc.view.bottom < scrollView.contentOffset.y) { // 看不见
            SSLOG_INFO(@"remove firstVC");
            [self.vcArr removeObject:vc];
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
            [self updateAllViewsWithOffset:-vc.view.height];
        }
    }
//
    // check bottom
    if (self.vcArr && self.vcArr.count > 0) {
        UIViewController *vc = [self.vcArr lastObject];
        if (vc.view.top > scrollView.contentOffset.y + scrollView.height) { //
            SSLOG_INFO(@"remove lastVC");
            [self.vcArr removeObject:vc];
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
            [self updateAllViewsWithOffset:vc.view.height];
        }
    }
    
    [self checkCurrentVC];
}

- (void)checkCurrentVC {
    for (int i = 0; i < self.vcArr.count; ++i) {
        if (self.vcArr[i].view.bottom > self.scrollView.contentOffset.y + self.scrollView.height / 2) {
            if (self.vcArr[i] != self.currentVC) {
                self.currentVC = self.vcArr[i];
                if (self.delegate) {
                    [self.delegate scrollViewController:self currentShowViewController:self.currentVC];
                }
            }
            break;
        }
    }
}

- (void)safeSetContentOffsetY:(CGFloat)y {
    self.scrollView.delegate = nil;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, y) animated:NO];
    self.scrollView.delegate = self;
}
#pragma mark - private

@end
