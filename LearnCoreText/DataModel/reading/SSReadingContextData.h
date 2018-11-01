//
//  SSReadingContextData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "SSPageControllData.h"

NS_ASSUME_NONNULL_BEGIN


#define KEY_READ_PAGE @"KEY_READ_PAGE"

@interface SSReadingContextData : NSObject

@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, assign) NSUInteger curPage;
@property (nonatomic, assign) CGSize pageSize;

@property (nonatomic, strong) SSPageControllData *pageControllData;

@end

NS_ASSUME_NONNULL_END
