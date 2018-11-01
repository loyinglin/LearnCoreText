//
//  BasePageViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/31.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSBasePageViewController.h"

@interface SSBasePageViewController ()

@end

@implementation SSBasePageViewController

- (instancetype)initWithSSPageControllData:(SSPageControllData *)pageControllData {
    if (self = [super init]) {
        _pageControllData = pageControllData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
