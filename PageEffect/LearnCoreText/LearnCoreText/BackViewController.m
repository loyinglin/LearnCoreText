//
//  BackViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2019/3/26.
//  Copyright © 2019 Loying. All rights reserved.
//

#import "BackViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BackViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = self.backgroundImage;
    [self.view addSubview:self.imageView];
}

- (void)updateWithViewController:(UIViewController *)viewController {
    self.backgroundImage = [self captureView:viewController.view];
}

- (BOOL)checkNullRect:(UIView *)view {
    BOOL ret = CGRectIsNull(view.frame);
    for (UIView *subView in view.subviews) {
        ret = ret || [self checkNullRect:subView];
    }
    return ret;
}

- (UIImage *)captureView:(UIView *)view {
    if ([self checkNullRect:view]) {
        return nil;
    }
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, rect.size.width, 0.0);
    CGContextConcatCTM(context,transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
