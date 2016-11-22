//
//  Pharmacy.h
//  Pharmacy
//
//  Created by Rohit Kumar on 07/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Prescription : NSObject

@property (nonatomic ,strong) NSString *RxNumber;
@property (nonatomic ,strong) NSString *drugName;
@property (nonatomic ,strong) NSString *noOfRemainingRefill;
@property (nonatomic ,strong) NSString *lastRefillDate;
@property (nonatomic ,strong) NSString *prescriberName;
@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *expirationDate;


@end
