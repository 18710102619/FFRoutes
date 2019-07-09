//
//  FFParsingUtilities.h
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import <Foundation/Foundation.h>

@interface FFRouteUtilities : NSObject

+ (NSString *)encodeJsonObjectToString:(NSDictionary *)jsonObject;

+ (NSDictionary *)decodeJsonStringToObject:(NSString *)jsonString;

@end
