//
//  SSPageViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSPageViewController.h"

@interface SSPageViewController ()

@property (nonatomic, strong) SSPageView *pageView; // 渲染视图

@end

@implementation SSPageViewController

- (instancetype)initWithPageData:(SSLayoutPageData *)pageData {
    self = [super init];
    if (self) {
        self.pageData = pageData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageView = [[SSPageView alloc] initWithFrame:self.view.bounds];
    self.pageView.pageData = self.pageData;
    [self.view addSubview:self.pageView];
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
