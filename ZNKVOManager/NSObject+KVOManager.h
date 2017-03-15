//
//  NSObject+KVOManager.h
//  RuntimeTest
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZNKVOManager;

@interface NSObject (KVOManager)

@property (nonatomic, strong) ZNKVOManager *kvoManager;

@end
