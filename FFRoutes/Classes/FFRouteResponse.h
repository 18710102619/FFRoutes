//
//  FFRouteResponse.h
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//  路由响应

#import <Foundation/Foundation.h>

@interface FFRouteResponse : NSObject

@property (nonatomic, assign) BOOL match;
@property (nonatomic, copy)NSDictionary *parameters;

+ (instancetype)validMatchResponseWithParameters:(NSDictionary *)parameters;

@end
