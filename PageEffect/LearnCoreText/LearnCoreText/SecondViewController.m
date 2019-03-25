//
//  SecondViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/2/27.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "SecondViewController.h"
#import "SSScrollViewController.h"
#import "UIView+LYLayout.h"

@interface SecondViewController () <SSScrollViewControllerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SSScrollViewController *vc = [[SSScrollViewController alloc] init];
    vc.shouldFullFill = YES;
    vc.delegate = self;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [vc setInitVC:[self getRandomVCWithIndex:5]];
}



- (UIViewController *)scrollViewControllerGetLastVC:(SSScrollViewController *)scrollVC {
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

- (UIViewController *)scrollViewControllerGetNextVC:(SSScrollViewController *)scrollVC {
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

- (void)scrollViewController:(SSScrollViewController *)scrollVC currentShowViewController:(UIViewController *)viewController {
    NSLog(@"currentShowViewController:%ld", (long) viewController.view.tag);
}

- (UIViewController *)getRandomVCWithIndex:(NSInteger)index {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0
                                              green:arc4random_uniform(255) / 255.0
                                               blue:arc4random_uniform(255) / 255.0
                                              alpha:1];
    vc.view.height = 333;
    vc.view.tag = index;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = [NSString stringWithFormat:@"页数%ld", (long)index];
    label.textColor = [UIColor blackColor];
    [vc.view addSubview:label];
    
    return vc;
}

@end
