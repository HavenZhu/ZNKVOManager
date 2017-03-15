//
//  ZNKVOManager.h
//  RuntimeTest
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZNKVOCallBack)(id observer, id object, NSString *keyPath, NSDictionary<NSKeyValueChangeKey, id> *change);

@interface ZNKVOManager : NSObject

@property (nonatomic, weak) id observer;

- (instancetype)initWithObserver:(id)observer;

- (void)observe:(id)object
     forKeyPath:(NSString *)keyPath
       callBack:(ZNKVOCallBack)callBack;

@end
