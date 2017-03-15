//
//  ZNKVOManager.m
//  RuntimeTest
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import "ZNKVOManager.h"

@interface ZNKVOObserverInfo : NSObject

@property (nonatomic, strong) id object;
@property (nonatomic, copy) NSString *keyPath;

- (id)initWithObject:(id)object
          andKeyPath:(NSString *)keyPath;

@end

@implementation ZNKVOObserverInfo

- (id)initWithObject:(id)object
          andKeyPath:(NSString *)keyPath {
    
    if (self = [super init]) {
        _object = object;
        _keyPath = keyPath;
    }
    
    return self;
}

@end

@interface ZNKVOManager ()

@property (nonatomic, strong) NSMutableSet *observerInfos;

@end

@implementation ZNKVOManager

- (instancetype)initWithObserver:(id)observer {
    
    if (self = [super init]) {
        _observer = observer;
        _observerInfos = [NSMutableSet new];
    }
    
    return self;
}

- (void)observe:(id)object
     forKeyPath:(NSString *)keyPath
       callBack:(ZNKVOCallBack)callBack {
    
    // 保存信息，在dealloc时用于removeObserver
    ZNKVOObserverInfo *info = [[ZNKVOObserverInfo alloc] initWithObject:object
                                                             andKeyPath:keyPath];
    [self.observerInfos addObject:info];
    
    // 真正的observer一直都是self，也就是ZNKVOManager
    // 初始化时传入的observer用于回调，这样看起来像是原对象直接观察
    [object addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                context:(void *)callBack];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    // 通过context来执行block，将所有的参数回传过去
    ZNKVOCallBack callBack = (__bridge ZNKVOCallBack)context;
    callBack(self.observer, object, keyPath, change);
}

- (void)dealloc {
    
    // 只需要在这里进行removeObserver，因为真正的观察者只有此类，这样就不需要在多个地方进行removeObserver操作了
    for (ZNKVOObserverInfo *info in self.observerInfos) {
        [info.object removeObserver:self forKeyPath:info.keyPath];
    }
}

@end
