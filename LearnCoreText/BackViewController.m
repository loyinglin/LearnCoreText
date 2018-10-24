//
//  BackViewController.m
//  LearnHTMLtoNSString
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//
#import "BackViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BackViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *backgroundImage;

@end

@implementation BackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.imageView setImage:self.backgroundImage];
    [self.view addSubview:self.imageView];
}

- (void)updateWithViewController:(UIViewController *)viewController {
    self.backgroundImage = [self captureView:viewController.view];
}

- (UIImage *)captureView:(UIView *)view {
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
