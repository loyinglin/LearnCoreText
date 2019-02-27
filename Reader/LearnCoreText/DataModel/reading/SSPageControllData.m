//
//  SSPageControllData.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/31.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "SSPageControllData.h"

@implementation SSPageControllData

- (instancetype)initWithType:(SSPageControllType)type {
    self = [super init];
    if (self) {
        self.pageControllType = type;
    }
    return self;
}


@end
