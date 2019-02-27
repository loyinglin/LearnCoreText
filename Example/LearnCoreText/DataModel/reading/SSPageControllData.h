//
//  SSPageControllData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/31.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLayoutPageData.h"
#import "SSAdvertisingData.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SSPageControllType) {
    SSPageControllTypeNormal = 1, // 正常渲染
    SSPageControllTypeAd,     // 广告页，  暂不翻页逻辑耦合，
    SSPageControllTypeLoading,  // 空页面，显示loading
    SSPageControllTypePay,    // 渲染部分文字，同时覆盖购买界面
};


/**
 当前页面显示的数据类型；
 前期不做继承封装，后期可以抽出基类，每新增一种页面类型，只需要创建新的类
 */
@interface SSPageControllData : NSObject

@property (nonatomic, assign) SSPageControllType pageControllType;

// SSPageControllTypeNormal
@property (nonatomic, strong) SSLayoutPageData *layoutPageData; // 页面渲染的数据

// SSPageControllTypeLoading
@property (nonatomic, strong) NSString *loadingChapterId; // 等待加载的章节id

// SSPageControllTypeAd
@property (nonatomic, strong) SSAdvertisingData *advertisingData; // 广告数据

- (instancetype)initWithType:(SSPageControllType)type;

@end

NS_ASSUME_NONNULL_END
