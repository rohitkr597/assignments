//
//  JSONBuilder.m
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "JSONBuilder.h"
#import "Prescription.h"

@implementation JSONBuilder


+(NSDictionary *)dictionaryForAuthtication:(NSData *)objectNotation error:(NSError **)error {
    NSError *localError = nil;
    NSDictionary *result;
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    result = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    return result;
}

+ (NSArray *)pharmaListFromJSON:objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    NSArray *prescriptionListFromJSON = [parsedObject objectForKey:@"prescriptions"];
    
    NSMutableArray *prescriptionList = [[NSMutableArray alloc] init];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    for (NSDictionary *dict in prescriptionListFromJSON) {
        Prescription *prescription = [[Prescription alloc] init];
        for (NSString *key in dict) {
        
            if([prescription respondsToSelector:NSSelectorFromString(key)]) {
                [prescription setValue:[dict valueForKey:key] forKey:key];
            }
        }
        [prescriptionList addObject:prescription];
        
    }
    return prescriptionList;
}


@end
