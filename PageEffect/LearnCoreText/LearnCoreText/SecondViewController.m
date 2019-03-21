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
    vc.delegate = self;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    [vc setInitVC:[self getRandomVC]];
}



- (UIViewController *)scrollViewControllerGetLastVC:(SSScrollViewController *)scrollVC {
    return nil;// [self getRandomVC];
}

- (UIViewController *)scrollViewControllerGetNextVC:(SSScrollViewController *)scrollVC {
    return [self getRandomVC];
}

- (void)scrollViewController:(SSScrollViewController *)scrollVC currentShowViewController:(UIViewController *)viewController {
    NSLog(@"currentShowViewController:%ld", (long) viewController.view.tag);
}

- (UIViewController *)getRandomVC {
    static NSInteger index;
    ++index;
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
