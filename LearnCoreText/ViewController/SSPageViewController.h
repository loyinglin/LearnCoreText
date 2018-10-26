//
//  SSPageViewController.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSLayoutPageData.h"
#import "SSPageView.h"

NS_ASSUME_NONNULL_BEGIN

#define PageTop (66)
#define PageBottom (50)
#define PageHorizontalMargin (10)

/**
 分页显示的控制器
 */
@interface SSPageViewController : UIViewController

@property (nonatomic, strong) SSLayoutPageData *pageData; // 排版数据

- (instancetype)initWithPageData:(SSLayoutPageData *)pageData;



@end

NS_ASSUME_NONNULL_END