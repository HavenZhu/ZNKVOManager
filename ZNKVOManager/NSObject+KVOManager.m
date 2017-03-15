//
//  NSObject+KVOManager.m
//  RuntimeTest
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import "NSObject+KVOManager.h"
#import <objc/runtime.h>
#import "ZNKVOManager.h"

@implementation NSObject (KVOManager)

- (ZNKVOManager *)kvoManager {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKvoManager:(ZNKVOManager *)kvoManager {
    objc_setAssociatedObject(self, @selector(kvoManager), kvoManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
