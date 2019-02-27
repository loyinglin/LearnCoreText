//
//  SSLoadingViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/31.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSLoadingViewController.h"

@interface SSLoadingViewController ()

@end

@implementation SSLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"loading...";
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
