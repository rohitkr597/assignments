//
//  JSONBuilder.h
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONBuilder : NSObject

+ (NSArray *)pharmaListFromJSON:(NSData *)objectNotation error:(NSError **)error;

+ (NSDictionary *)dictionaryForAuthtication:(NSData *)objectNotation error:(NSError **)error;

@end
