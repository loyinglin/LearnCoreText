//
//  BasePageViewController.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/31.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPageControllData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSBasePageViewController : UIViewController

@property (nonatomic, strong, readonly) SSPageControllData *pageControllData;

- (instancetype)initWithSSPageControllData:(SSPageControllData *)pageControllData;

@end

NS_ASSUME_NONNULL_END
