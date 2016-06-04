#import "NSArray+Log.h"
#import <objc/runtime.h>

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}


- (id)objectAtIndex_zrw:(NSUInteger)index{
    if (self.count<=index) {
        ECLog(@"数组越界了");
        return nil;
    }else{
        ECLog(@"交换了系统的方法");
        return [self objectAtIndex:index];
    }
}

//+ (UIImage*)xh_imageNamed:(NSString*)name {
//    
//    doubleversion = [[UIDevicecurrentDevice].systemVersiondoubleValue];
//    
//    if(version >=7.0) {
//        
//        // 如果系统版本是7.0以上，使用另外一套文件名结尾是‘_os7’的扁平化图片
//        
//        name = [name stringByAppendingString:@"_os7"];    }
//    
//    return[UIImage xh_imageNamed:name];
//    
//}


+ (void)load {
    
    // 获取两个类的类方法
    
    Method  m1 = class_getClassMethod([NSArray class],@selector(objectAtIndex:));
    
    Method m2 = class_getClassMethod([NSArray class],@selector(objectAtIndex_zrw:));
    
    // 开始交换方法实现
    
    method_exchangeImplementations(m1, m2);
    
}



@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end