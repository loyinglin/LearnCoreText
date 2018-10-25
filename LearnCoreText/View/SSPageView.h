//
//  SSPageView.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SSLayoutPageData.h"

NS_ASSUME_NONNULL_BEGIN


/**
 显示一页内容的view
 */
@interface SSPageView : UIView

@property (nonatomic, strong) SSLayoutPageData *pageData;

@end

NS_ASSUME_NONNULL_END
