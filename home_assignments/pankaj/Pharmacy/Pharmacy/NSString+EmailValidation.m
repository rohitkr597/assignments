//
//  NSString+EmailValidation.m
//  Pharmacy
//
//  Created by Rohit Kumar on 08/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "NSString+EmailValidation.h"

@implementation NSString (EmailValidation)

-(BOOL)isValidEmail
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:self];
    return isValid;
}


@end
