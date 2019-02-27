//
//  SSConfigData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSConfigData : NSObject

@property (nonatomic, strong) UIFont *font; // 字体
@property (nonatomic, strong) UIFont *titleFont; // 字体
@property (nonatomic, strong) UIColor *textColor; // 字体颜色
@property (nonatomic, assign) CGFloat paragraph; // 段间距
@property (nonatomic, assign) CGFloat character; // 字间距
@property (nonatomic, assign) CGFloat line; // 行间距

@end

NS_ASSUME_NONNULL_END
