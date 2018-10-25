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
#import "SSPageControllManager.h"
#import <CoreText/CoreText.h>

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) SSPageControllManager *pageControllManager;
@property (nonatomic, strong) SSConfigData *configData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadPageControllManager];
    [self loadPageViewController];
    [self customInitFirstPage];
}

- (void)loadPageViewController {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionSpineLocationKey:@(UIPageViewControllerSpineLocationMin)}];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.doubleSided = YES;
    self.pageViewController.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.pageViewController.view];
    [self addChildViewController:self.pageViewController];
}


- (void)loadPageControllManager {
    SSReadingContextData *readingContextData = [self loadReadingContextData];
    self.configData = [self loadConfigData];
    self.pageControllManager = [[SSPageControllManager alloc] initWithReadingContextData:readingContextData configData:self.configData];
}


- (void)customInitFirstPage {
    SSLayoutPageData *pageData = [self.pageControllManager getCurrentPageData];
    SSPageViewController *pageVC = [[SSPageViewController alloc] initWithPageData:pageData];
    
    [self.pageViewController setViewControllers:@[pageVC]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         NSLog(@"setViewControllers");
                                     }];
}

- (SSReadingContextData *)loadReadingContextData {
    SSReadingContextData *ret = [[SSReadingContextData alloc] init];
    ret.curPage = 0;
    ret.chapterId = @"1";
    ret.bookId = @"abc";
    ret.pageSize = CGSizeMake(CGRectGetWidth(self.view.bounds) - 2 * PageHorizontalMargin, CGRectGetHeight(self.view.bounds) - PageTop - PageBottom);
    return ret;
}

- (SSConfigData *)loadConfigData {
    SSConfigData *configData = [[SSConfigData alloc] init];
    configData.font = [UIFont systemFontOfSize:16];
    configData.textColor = [UIColor grayColor];
    configData.character = 1;
    configData.paragraph = 10;
    configData.line = 5;
    return configData;
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
        SSLayoutPageData *pageData = [self.pageControllManager getNearPageDataWithIsNext:NO];
        if (pageData) {
            SSPageViewController *pageVC = [[SSPageViewController alloc] initWithPageData:pageData];
            ret = pageVC;
        }
        else {
            NSLog(@"viewControllerBeforeViewController null");
        }
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
        SSLayoutPageData *pageData = [self.pageControllManager getNearPageDataWithIsNext:YES];
        if (pageData) {
            SSPageViewController *pageVC = [[SSPageViewController alloc] initWithPageData:pageData];
            ret = pageVC;
        }
        else {
            NSLog(@"viewControllerAfterViewController null");
        }
    }
    return ret;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"didFinishAnimating");
    if (completed && [self.pageViewController.viewControllers[0] isKindOfClass:[SSPageViewController class]]) {
        SSPageViewController *pageViewController = (SSPageViewController *)self.pageViewController.viewControllers[0];
        [self.pageControllManager onNewPageDidAppear:pageViewController.pageData];
    }
}

-(IBAction)onNext:(id)sender {
//    self.pageViewController
}

@end
