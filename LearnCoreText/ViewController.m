//
//  ViewController.m
//  LearnHTMLtoNSString
//
//  Created by loyinglin on 2018/10/23.
//  Copyright © 2018年 loyinglin. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"
#import "BackViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic, strong) IBOutlet UIButton *nextBtn;

@property(nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.doubleSided = YES;
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    // 设置UIPageViewController初始化数据，将数据放到NSArray里面
    // 如果 options 设置了 UIPageViewControllerSpineLocationMid,注意viewControllers至少包含两个数据,且 doubleSided = YES
//    BackViewController *backVC = [[BackViewController alloc] init];
//    [backVC updateWithViewController:contentVC];
    [self.pageViewController setViewControllers:@[contentVC]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         NSLog(@"setViewControllers");
                                     }];
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerBeforeViewController");
    UIViewController *ret;
    if ([viewController isKindOfClass:[ContentViewController class]]) {
        BackViewController *backVC = [[BackViewController alloc] init];
        [backVC updateWithViewController:viewController];
        ret = backVC;
    }
    else {
        ContentViewController *contentVC = [[ContentViewController alloc] init];
        ret = contentVC;
    }
    return ret;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerAfterViewController");
    UIViewController *ret;
    if ([viewController isKindOfClass:[ContentViewController class]]) {
        BackViewController *backVC = [[BackViewController alloc] init];
        [backVC updateWithViewController:viewController];
        ret = backVC;
    }
    else {
        ContentViewController *contentVC = [[ContentViewController alloc] init];
        ret = contentVC;
    }
    return ret;
}

-(IBAction)onNext:(id)sender {
//    self.pageViewController
}

@end
