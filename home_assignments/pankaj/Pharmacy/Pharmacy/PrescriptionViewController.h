//
//  PrescriptionViewController.h
//  Pharmacy
//
//  Created by Rohit Kumar on 08/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrescriptionViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView *preceptionTableView;
@property (nonatomic,strong) NSString *customerId;

@end
