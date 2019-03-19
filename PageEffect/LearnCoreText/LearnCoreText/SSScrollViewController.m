//
//  SSScorllViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/18.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SSScrollViewController.h"
#import "UIView+LYLayout.h"

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
    [self.view addSubview:self.scrollView];

    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height * 3);
//    [self.scrollView setContentOffset:CGPointMake(0, self.view.height) animated:NO];
    
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
    [self.scrollView addSubview:vc.view];
    
    self.currentVC = vc;
    [self fillContent];
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
    [self.scrollView setContentOffset:CGPointMake(0, self.view.height) animated:NO];
}
#pragma mark - action

- (void)fillContent {
    if (!self.vcArr || self.vcArr.count <= 0) {
        return ;
    }
    CGFloat windowMinY = self.scrollView.contentOffset.y, windowMaxY = windowMinY + self.scrollView.height;
    
    {
        CGFloat upFillY;
        if (self.viewControllers && self.viewControllers.count > 0) {
            UIViewController *vc = [self.viewControllers firstObject];
            upFillY = vc.view.top;
        }
        else {
            upFillY = self.scrollView.contentOffset.y;
        }
        while (upFillY > windowMinY) {
            if (!self.delegate) {
                NSLog(@"error, empty delegate");
                break;
            }
            UIViewController *vc = [self.delegate scrollViewControllerGetLastVC:self];
            if (!vc) {
                NSLog(@"info, reach last end");
                break;
            }
            [self.vcArr insertObject:vc atIndex:0];
            [self addChildViewController:vc];
            [self.scrollView addSubview:vc.view];
            vc.view.bottom = upFillY;
            upFillY = vc.view.top;
            NSLog(@"info, add last vc, frame:%@", NSStringFromCGRect(vc.view.frame));
        }
        
    }
    
    {
        CGFloat downFillY;
        if (self.viewControllers && self.viewControllers.count > 0) {
            UIViewController *vc = [self.viewControllers lastObject];
            downFillY = vc.view.bottom;
        }
        else {
            downFillY = self.scrollView.contentOffset.y;
        }
        while (downFillY < windowMaxY) {
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
}

- (void)updateAllViewsWithOffset:(CGFloat)offset {
    NSLog(@"updateAllViewsWithOffset, offset:%f", offset);
    for (int i = 0; i < self.vcArr.count; ++i) {
        UIViewController *vc = [self.vcArr objectAtIndex:i];
        vc.view.top += offset;
    }
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + offset)];
    NSLog(@"current offset:%@", NSStringFromCGPoint(self.scrollView.contentOffset));
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat windowMinY = self.scrollView.contentOffset.y, windowMaxY = windowMinY + self.scrollView.height;
    
//    BOOL sh
    // check top
    if (self.vcArr && self.vcArr.count > 0) {
        UIViewController *vc = [self.vcArr firstObject];
        if (vc.view.bottom < windowMinY) { //
            NSLog(@"remove firstVC");
            [self.vcArr removeObject:vc];
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
        }
    }
    
    // check bottom
    if (self.vcArr && self.vcArr.count > 0) {
        UIViewController *vc = [self.vcArr lastObject];
        if (vc.view.top > windowMaxY) { //
            NSLog(@"remove lastVC");
            [self.vcArr removeObject:vc];
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
        }
    }
    
    if (scrollView.contentOffset.y <= 0) {
        [self updateAllViewsWithOffset:self.scrollView.height];
    }
    else if (scrollView.contentOffset.y >= (2 * self.scrollView.height)) {
        [self updateAllViewsWithOffset:-self.scrollView.height];
    }
    
    [self fillContent];
    [self checkCurrentVC];
}

- (void)checkCurrentVC {
    if (self.vcArr && self.vcArr.count > 0) {
        if ([self.vcArr firstObject] != self.currentVC) {
            self.currentVC = [self.vcArr firstObject];
            if (self.delegate) {
                [self.delegate scrollViewController:self currentShowViewController:self.currentVC];
            }
        }
    }
}

#pragma mark - private

@end
