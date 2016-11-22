//
//  PrescriptionViewController.m
//  Pharmacy
//
//  Created by Rohit Kumar on 08/11/16.
//  Copyright © 2016 Walmart. All rights reserved.
//

#import "PrescriptionViewController.h"
#import "CommunicationManager.h"
#import "Prescription.h"

@interface PrescriptionViewController()<ComunicationMangerDelegate>{
    CommunicationManager *manager;
}
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation PrescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [[CommunicationManager alloc] init];
    manager.communicator = [[ServerCommunication alloc] init];
    manager.communicator.delegate = manager;
    manager.delegate = self;
    
    self.preceptionTableView.delegate  =self;
     self.preceptionTableView.dataSource  =self;
    
    self.dataList = [[NSMutableArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // 1
       
         [manager fetchDataFromURL:[NSString stringWithFormat:@"http://172.28.124.224:8081/prescriptions/%@",self.customerId] withParameter:nil forRequestType:PHPrescription];
    });
}

#pragma mark - CommunicationManager delegate implementation

- (void)didReceiveResult:(id)result{
    
    if ([result isKindOfClass:[NSArray class]]) {
        self.dataList = (NSMutableArray *)result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.preceptionTableView reloadData];
        });
    }
    else {
        NSDictionary *resultDictionary = (NSDictionary *)result;
        if ([[resultDictionary objectForKey:@"status"] isEqualToString:@"OK"]) {
            [self showAlert: [resultDictionary objectForKey:@"description"] ];
        }
    }
}

-(void)didFailWithError:(NSError *)error {
    NSLog(@"Error log %@",error);
}

#pragma mark - Alert View

-(void)showAlert: (NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)submitAction:(id)sender{
    
    NSMutableDictionary *paramDictionary = [[NSMutableDictionary alloc] init];
    [paramDictionary setObject:@"1234567" forKey:@"rxNumber"];
    
     [manager fetchDataFromURL:[NSString stringWithFormat:@"http://172.28.124.224:8081/refill/%@",self.customerId] withParameter:paramDictionary forRequestType:PHSubmitPrescription];
}

#pragma mark -  Table View delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    if ([self.dataList count]) {

    Prescription *preception = [self.dataList objectAtIndex:section];
    return preception.drugName;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    Prescription *preception = [self.dataList objectAtIndex:indexPath.section];
    NSString *titleName = [[NSString alloc] init];
    
    switch (indexPath.row) {
        case 0:
            titleName = preception.RxNumber;
            break;
        case 1:
            titleName = preception.drugName;
            break;
        case 2:
            titleName =  [NSString stringWithFormat:@"%@",preception.noOfRemainingRefill];
            break;
        case 3:
            titleName = preception.lastRefillDate;
            break;
        case 4:
            titleName = preception.prescriberName;
            break;
        case 5:
            titleName = [NSString stringWithFormat:@"%@",preception.price];
            break;
        case 6:
            titleName = preception.expirationDate;
            break;
            
        default:
            break;
    }

    // Configure the cell.
    cell.textLabel.text = titleName;
    return cell;
}

@end
