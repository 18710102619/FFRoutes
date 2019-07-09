//
//  FFParsingUtilities.m
//  FFRoutes
//
//  Created by 张玲玉 on 2018/7/27.
//

#import "FFRouteUtilities.h"

@implementation FFRouteUtilities

+ (NSString *)encodeJsonObjectToString:(NSDictionary *)jsonObject
{
    if ([jsonObject isKindOfClass:[NSDictionary class]])
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:nil];
        
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *json=CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) jsonString,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                 kCFStringEncodingUTF8));
        return json;
    }
    return @"";
}

+ (NSDictionary *)decodeJsonStringToObject:(NSString *)jsonString
{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return jsonObject;
}

@end
