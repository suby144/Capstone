//
//  YearlyController.h
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
@interface YearlyController : UIViewController
@property (nonatomic) PNPieChart *pieChart;
@property (strong, nonatomic) NSDictionary *dictionary_user_data;
@property (strong, nonatomic) NSString *goal;
@property (strong, nonatomic) IBOutlet UILabel *lbl_goal;
@property (strong, nonatomic) IBOutlet UILabel *lbl_year;

- (IBAction)btnBack:(id)sender;
@end
