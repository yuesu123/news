//
//  UIViewController+WGWhichOne.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/22.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "UIViewController+WGWhichOne.h"
#import  <objc/runtime.h>

@implementation UIViewController (WGWhichOne)

+ (void)load
{
//方法交换应该被保证 在程序中只能执行一次
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    //获取 viewcontroller 的生命周期方法
    SEL systemMethod = @selector(viewWillAppear:);
    SEL systemMethodDis = @selector(viewWillDisappear:);
    //自己实现将要交换的方法
    SEL changeMethod = @selector(statistics_viewWillAppear);
    SEL changeMethodDis = @selector(statistics_viewWillDisappear);

    //两个方法的 method
    Method system = class_getInstanceMethod([self class], systemMethod);
    Method change = class_getInstanceMethod([self class], changeMethod);

    //两个消失方法的实现
    Method systemDis = class_getInstanceMethod([self class], systemMethodDis);
    Method changeDis = class_getInstanceMethod([self class], changeMethodDis);

    //首先动态添加方法 实现是被交换的方法 返回值表示成功或者失败
    //替换viewwillappear
    BOOL isAdd = class_addMethod(self, systemMethod, method_getImplementation(change), method_getTypeEncoding(change));
    if (isAdd) {
        //如果成功 说明类中不存在这个方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(self, changeMethod, method_getImplementation(system), method_getTypeEncoding(system));
    } else {
        //交换来个方法的实现
        method_exchangeImplementations(system, change);
    }


    BOOL isDis = class_addMethod(self, systemMethodDis, method_getImplementation(changeDis), method_getTypeEncoding(changeDis));
    if (isDis) {
        class_replaceMethod(self, changeMethodDis, method_getImplementation(systemDis), method_getTypeEncoding(systemDis));
    } else {
        method_exchangeImplementations(systemDis, changeDis);
    }

});
}

- (void)statistics_viewWillAppear
{
    NSLog(@"看我现在  来到  那个类了 %@", [self class]);
}

- (void)statistics_viewWillDisappear
{
    NSLog(@"看我现在  离开  这个类了 %@", [self class]);
}


@end