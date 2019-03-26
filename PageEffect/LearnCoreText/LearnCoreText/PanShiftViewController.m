//
//  PanShiftViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/26.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "PanShiftViewController.h"


@interface PanShiftViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageVC;

@end

@implementation PanShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageVC = [[UIPageViewController alloc]
                   initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                   options:
                   @{
                     UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)
                     }];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    [self customInitFirstPage];
}

- (void)customInitFirstPage {
    UIViewController *vc = [self getRandomVCWithIndex:5];
    
    [self.pageVC setViewControllers:@[vc]
                          direction:UIPageViewControllerNavigationDirectionReverse
                           animated:NO
                         completion:^(BOOL finished) {
                         }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - UIPageViewControllerDelegate

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController *ret;
    UIViewController *vc = viewController;
    if (vc) {
        NSInteger index = vc.view.tag;
        if (index > 0) {
            ret = [self getRandomVCWithIndex:index - 1];
        }
    }
    return ret;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController *ret;
    UIViewController *vc = viewController;
    if (vc) {
        NSInteger index = vc.view.tag;
        if (index < 10) {
            ret = [self getRandomVCWithIndex:index + 1];
        }
    }
    return ret;
}


- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    // do something
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    // do something
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
