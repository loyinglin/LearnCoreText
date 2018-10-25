//
//  SSReadingContextData.h
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/24.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSReadingContextData : NSObject

@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, assign) NSUInteger curPage;

@end

NS_ASSUME_NONNULL_END
