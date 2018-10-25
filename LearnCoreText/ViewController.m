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
#import "SSReadingContextData.h"
#import "SSPageViewController.h"
#import "SSDataManager.h"
#import "SSConfigData.h"
#import "SSLayoutManager.h"
#import "SSLayoutChapterData.h"
#import <CoreText/CoreText.h>

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) SSReadingContextData *readingContextData;
@property (nonatomic, strong) SSConfigData *configData;
@property (nonatomic, strong) SSLayoutChapterData *curLayoutChapterData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.doubleSided = YES;
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
    
    self.readingContextData = [self loadReadingContextData];
    SSChapterData *curChapterData = [self loadChapterData:self.readingContextData];
    self.configData = [self loadConfigData];
    
    self.curLayoutChapterData = [self getLayoutChapterData:curChapterData configData:self.configData];
    SSLayoutPageData *pageData = [self getLayoutPageData:self.curLayoutChapterData readingContextData:self.readingContextData];
    
    SSPageViewController *pageVC = [[SSPageViewController alloc] initWithPageData:pageData];
    
    [self.pageViewController setViewControllers:@[pageVC]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         NSLog(@"setViewControllers");
                                     }];
}

- (SSLayoutPageData *)getLayoutPageData:(SSLayoutChapterData *)layoutChapterData readingContextData:(SSReadingContextData *)readingContextData {
    SSLayoutManager *layoutMgr = [[SSLayoutManager alloc] init];
    return [layoutMgr getPageDataWithLayoutChapterData:layoutChapterData pageIndex:readingContextData.curPage];
}

- (SSLayoutChapterData *)getLayoutChapterData:(SSChapterData *)chapterData configData:(SSConfigData *)configData {
    SSLayoutManager *layoutMgr = [[SSLayoutManager alloc] init];
    return [layoutMgr getLayoutChapterDataWithChapterData:chapterData configData:configData pageSize:self.view.bounds.size];
}

- (SSReadingContextData *)loadReadingContextData {
    SSReadingContextData *ret = [[SSReadingContextData alloc] init];
    ret.curPage = 1;
    return ret;
}

- (SSConfigData *)loadConfigData {
    SSConfigData *configData = [[SSConfigData alloc] init];
    configData.font = [UIFont systemFontOfSize:16];
    configData.textColor = [UIColor blackColor];
    configData.character = 1;
    configData.paragraph = 10;
    configData.line = 5;
    return configData;
}

- (SSChapterData *)loadChapterData:(SSReadingContextData *)readingContextData {
    SSDataManager *dataMgr = [[SSDataManager alloc] init];
    SSChapterData *chapterData = [dataMgr getRemoteChatperDataWithId:readingContextData];
    return chapterData;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerBeforeViewController");
    UIViewController *ret;
    if ([viewController isKindOfClass:[ContentViewController class]] && pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
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
    if ([viewController isKindOfClass:[ContentViewController class]] && pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
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
