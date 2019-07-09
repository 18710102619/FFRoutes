//
//  FFRouteRequest.h
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//  路由请求

#import <Foundation/Foundation.h>

@interface FFRouteRequest : NSObject

@property(nonatomic,copy)NSURL *URL;
@property(nonatomic,strong)NSArray *pathComponents;
@property(nonatomic,strong)NSDictionary *queryParams;

/**
 初始化路由请求

 @param URL 路由URL
 @return 实例
 */
- (instancetype)initWithURL:(NSURL *)URL;

@end
