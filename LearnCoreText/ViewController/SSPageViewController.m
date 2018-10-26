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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *batteryLabel;

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
    self.view.backgroundColor = [UIColor greenColor];
    self.pageView = [[SSPageView alloc] initWithFrame:CGRectMake(PageHorizontalMargin, PageTop, CGRectGetWidth(self.view.bounds) - PageHorizontalMargin * 2, CGRectGetHeight(self.view.bounds) - PageTop - PageBottom)];
    self.pageView.pageData = self.pageData;
    [self.view addSubview:self.pageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.pageData.chapterTitle;
    [self.titleLabel sizeToFit];
    self.titleLabel.width = self.view.width - 100;
    self.titleLabel.left = 10;
    self.titleLabel.top = 42;
    [self.view addSubview:self.titleLabel];
    
    self.indexLabel = [[UILabel alloc] init];
    self.indexLabel.text = [NSString stringWithFormat:@"%lu/%lu", self.pageData.pageIndex + 1, self.pageData.pageCount];
    [self.indexLabel sizeToFit];
    self.indexLabel.bottom = self.view.height - 10;
    self.indexLabel.left = 10;
    [self.view addSubview:self.indexLabel];
    
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    self.batteryLabel = [[UILabel alloc] init];
    self.batteryLabel.text = [NSString stringWithFormat:@"电量%d%%", (int)[UIDevice currentDevice].batteryLevel * 100];
    [self.batteryLabel sizeToFit];
    self.batteryLabel.bottom = self.view.height - 10;
    self.batteryLabel.right = self.view.right - 10;
    [self.view addSubview:self.batteryLabel];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceBatteryLevelDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
                                                      self.batteryLabel.text = [NSString stringWithFormat:@"电量%d%%", (int)[UIDevice currentDevice].batteryLevel * 100];
                                                      [self.batteryLabel sizeToFit];
                                                      self.batteryLabel.bottom = self.view.height - 10;
                                                      self.batteryLabel.right = 10;
                                                      }];
        
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
