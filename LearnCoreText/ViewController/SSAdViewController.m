//
//  SSAdViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/26.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSAdViewController.h"

@interface SSAdViewController ()

@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation SSAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我是广告页";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
