//
//  ViewController.m
//  LearnHTMLtoNSString
//
//  Created by loyinglin on 2018/10/23.
//  Copyright © 2018年 loyinglin. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "SSContentViewController.h"
#import "SSBackViewController.h"
#import "SSReadingContextData.h"
#import "SSPageViewController.h"
#import "SSDataManager.h"
#import "SSConfigData.h"
#import "SSLayoutManager.h"
#import "SSLayoutChapterData.h"
#import "SSPageControllManager.h"
#import "SSAdViewController.h"
#import "SSLoadingViewController.h"

@interface SSContentViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) SSPageControllManager *pageControllManager;
@property (nonatomic, strong) SSConfigData *configData;

@property (nonatomic, assign) NSUInteger scrollCount;
@end

@implementation SSContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadPageControllManager];
    [self loadPageViewController];
    [self customInitFirstPage];
    [self setupGesture];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setupGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPageView:)];
    [self.pageViewController.view addGestureRecognizer:tap];
}

#define TapGap (100)

- (void)onTapPageView:(UITapGestureRecognizer *)tap {
    if (tap.view == self.pageViewController.view) {
        CGPoint point = [tap locationInView:tap.view];
        if (point.x <= TapGap || point.x > CGRectGetWidth(tap.view.bounds) - TapGap) {
            [self manualChangePageWithIsNext:point.x > CGRectGetWidth(tap.view.bounds) - TapGap];
        }
        else {
            self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
        }
    }
}

- (void)manualChangePageWithIsNext:(BOOL)isNext {
    UIViewController *vc = [self getNearVCWithIsNext:isNext curViewController:self.pageViewController.viewControllers[0]];
    if (!vc) {
        NSLog(@"manualChangePageWithIsNext empty, is next : %d", isNext);
        return ;
    }
    __weak typeof(self) weakSelf = self;
    NSArray *vcArr;
    if (self.pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        SSBackViewController *backVC = [[SSBackViewController alloc] init];
        [backVC updateWithViewController:vc];
        vcArr = @[vc, backVC];
    }
    else {
        vcArr = @[vc];
    }
    
    if ([vc isKindOfClass:[SSBasePageViewController class]]) { // 这段统计需要提前。
        [self.pageControllManager onNewPageDidAppear:[(SSBasePageViewController *)vc pageControllData]];
        ++self.scrollCount; // 统计曝光
    }
    
    self.pageViewController.view.userInteractionEnabled = NO;
    NSLog(@"manualChangePageWithIsNext ");
    UIPageViewControllerNavigationDirection direction = isNext ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageViewController setViewControllers:vcArr
                                      direction:direction
                                       animated:NO // 为NO，可以和微信读书对齐，同时也防止在连续点击的时候，出现异常
                                     completion:^(BOOL finished) {
                                         NSLog(@"manualChangePageWithIsNext setViewControllers finished:%d", finished);
                                         __strong typeof(self) strongSelf = weakSelf;
                                         strongSelf.pageViewController.view.userInteractionEnabled = YES;
                                     }];
}

- (void)loadPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.doubleSided = YES;
    self.pageViewController.view.backgroundColor = BackgroundColor;
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
}


- (void)loadPageControllManager {
    SSReadingContextData *readingContextData = [self loadReadingContextData];
    self.configData = [self loadConfigData];
    self.pageControllManager = [[SSPageControllManager alloc] initWithReadingContextData:readingContextData configData:self.configData];
}


- (void)customInitFirstPage {
    SSPageControllData *pageData = [self.pageControllManager getFirstPageControllData];
    UIViewController *vc = [self getViewControllerWithPageControllData:pageData];
    self.scrollCount = 0;
    NSArray *vcArr = @[vc];
    if (self.pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        SSBackViewController *backVC = [[SSBackViewController alloc] init];
        [backVC updateWithViewController:vc];
        vcArr = @[vc, backVC];
    }
    
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:vcArr
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:^(BOOL finished) {
                                         __strong typeof(self) strongSelf = weakSelf;
                                         [strongSelf.pageControllManager onNewPageDidAppear:pageData];
                                     }];
}


- (SSReadingContextData *)loadReadingContextData {
    SSReadingContextData *ret = [[SSReadingContextData alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_READ_PAGE]) {
        ret.curPage = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_READ_PAGE] intValue];
    }
    else {
        ret.curPage = 0;
    }
    ret.chapterId = @"1";
    ret.bookId = @"abc";
    ret.pageSize = CGSizeMake(CGRectGetWidth(self.view.bounds) - 2 * PageHorizontalMargin, CGRectGetHeight(self.view.bounds) - PageTop - PageBottom);
    return ret;
}

- (SSConfigData *)loadConfigData {
    SSConfigData *configData = [[SSConfigData alloc] init];
    configData.font = [UIFont systemFontOfSize:16];
    configData.titleFont = [UIFont systemFontOfSize:20];
    configData.textColor = [UIColor grayColor];
    configData.character = 1;
    configData.paragraph = 10;
    configData.line = 5;
    return configData;
}

- (UIViewController *)getNearVCWithIsNext:(BOOL)isNext curViewController:(UIViewController *)curVC {
    UIViewController *ret;
    SSPageControllData *pageControllData = [self.pageControllManager getNearPageDataWithIsNext:isNext];
    ret = [self getViewControllerWithPageControllData:pageControllData];
//    if ([ret isKindOfClass:[SSPageViewController class]]) {
//        
//    }
//    else if (random() % 4 == 0) {
//        ret = [[SSAdViewController alloc] init];
//    }
//    else if (random() % 4 == 1) {
//        ret = [[SSBackViewController alloc] init];
//    }
//    else if (random() % 4 == 2) {
//        ret = [[SSPageViewController alloc] init];
//    }
//    else if (random() % 4 == 3) {
//        ret = [[SSLoadingViewController alloc] init];
//    }
    return ret;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerBeforeViewController");
    UIViewController *ret;
    if ([viewController isKindOfClass:[SSPageViewController class]] && pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        SSBackViewController *backVC = [[SSBackViewController alloc] init];
        [backVC updateWithViewController:viewController];
        ret = backVC;
    }
    else {
        ret = [self getNearVCWithIsNext:NO curViewController:viewController];
    }
    NSLog(@"return %@ ", [ret description]);
    return ret;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSLog(@"viewControllerAfterViewController");
    UIViewController *ret;
    if ([viewController isKindOfClass:[SSPageViewController class]] && pageViewController.transitionStyle == UIPageViewControllerTransitionStylePageCurl) {
        SSBackViewController *backVC = [[SSBackViewController alloc] init];
        [backVC updateWithViewController:viewController];
        ret = backVC;
    }
    else {
        ret = [self getNearVCWithIsNext:YES curViewController:viewController];
    }
    NSLog(@"return %@ ", [ret description]);
    return ret;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && [self.pageViewController.viewControllers[0] isKindOfClass:[SSBasePageViewController class]]) {
        SSBasePageViewController *pageViewController = (SSBasePageViewController *)self.pageViewController.viewControllers[0];
        [self.pageControllManager onNewPageDidAppear:pageViewController.pageControllData];
        ++self.scrollCount; // 统计曝光
    }
}

- (UIViewController *)getViewControllerWithPageControllData:(SSPageControllData *)pageControllData {
    UIViewController *ret;
    if (pageControllData) {
        switch (pageControllData.pageControllType) {
            case SSPageControllTypeNormal:
            {
                ret = [[SSPageViewController alloc] initWithSSPageControllData:pageControllData];
                break;
            }
            case SSPageControllTypeLoading:
            {
                ret = [[SSLoadingViewController alloc] initWithSSPageControllData:pageControllData];
                break;
            }
            case SSPageControllTypeAd:
            {
                ret = [[SSAdViewController alloc] initWithSSPageControllData:pageControllData];
                break;
            }
                
            default:
                break;
        }
    }
//    NSLog(@"getViewControllerWithPageControllData vc:%@, view: %@", ret, ret.view);
    return ret;
}

@end
