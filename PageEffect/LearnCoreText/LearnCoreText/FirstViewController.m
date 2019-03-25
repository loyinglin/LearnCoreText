//
//  FirstViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/2/27.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+LYLayout.h"
#import <CoreText/CoreText.h>
#import "SSSlideViewController.h"

@interface FirstViewController () <SSSlideViewControllerDelegate>

@property (nonatomic, strong) UIButton *lineFrameBtn;
@property (nonatomic, strong) UIButton *columnFrameBtn;
@property (nonatomic, strong) UIButton *nonrectangleFrameBtn;
@property (nonatomic, strong) UIButton *kernBtn; // test char space
@property (nonatomic, strong) UIButton *attachmentBtn;
@property (nonatomic, strong) UIButton *rangeOfFontBtn;

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) UIImageView *topDrawView;



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SSSlideViewController *vc = [[SSSlideViewController alloc] init];
    vc.delegate = self;
    [self addChildViewController:vc];
    [vc setInitVC:[self getRandomVCWithIndex:5]];
    [self.view addSubview:vc.view];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UIViewController *)slideViewControllerGetLastVC:(SSSlideViewController *)scrollVC {
    UIViewController *ret;
    UIViewController *vc = [scrollVC.viewControllers firstObject];
    if (vc) {
        NSInteger index = vc.view.tag;
        if (index > 0) {
            ret = [self getRandomVCWithIndex:index - 1];
        }
    }
    return ret;
}

- (UIViewController *)slideViewControllerGetNextVC:(SSSlideViewController *)scrollVC {
    UIViewController *ret;
    UIViewController *vc = [scrollVC.viewControllers lastObject];
    if (vc) {
        NSInteger index = vc.view.tag;
        if (index < 10) {
            ret = [self getRandomVCWithIndex:index + 1];
        }
    }
    return ret;
}

- (void)slideViewController:(SSSlideViewController *)scrollVC willTransitionToViewControllers:(UIViewController *)pendingViewController {
    NSLog(@"info, willTransitionToViewControllers");
}

- (void)slideViewController:(SSSlideViewController *)scrollVC previousViewController:(UIViewController *)previousViewController transitionCompleted:(BOOL)completed {
    NSLog(@"info, transitionCompleted:%d", completed);
}

- (UIViewController *)getRandomVCWithIndex:(NSInteger)index {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0
                                              green:arc4random_uniform(255) / 255.0
                                               blue:arc4random_uniform(255) / 255.0
                                              alpha:1];
    vc.view.tag = index;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = [NSString stringWithFormat:@"页数%ld", (long)index];
    label.textColor = [UIColor blackColor];
    [vc.view addSubview:label];
    
    return vc;
}

@end
