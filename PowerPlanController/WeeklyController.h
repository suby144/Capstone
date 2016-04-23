//
//  WeeklyController.h
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"

@interface WeeklyController : UIViewController
{
    NSArray *array_weeks;
    NSArray *array_month;
    NSString *month;
    NSString *week;
}
@property (nonatomic) PNPieChart *pieChart;
@property (strong, nonatomic) NSString *goal;
@property (strong, nonatomic) NSDictionary *dictionary_user_data;
@property (strong, nonatomic) IBOutlet UILabel *lbl_goal;
@property (strong, nonatomic) IBOutlet UITableView *tableview_month;
@property (strong, nonatomic) IBOutlet UITableView *tableview_week;
@property (strong, nonatomic) IBOutlet UILabel *lbl_month;
@property (strong, nonatomic) IBOutlet UILabel *lbl_week;
@property (strong, nonatomic) IBOutlet UIButton *btn_monthDD;
@property (strong, nonatomic) IBOutlet UIButton *btn_weekDD;
@property (strong, nonatomic) IBOutlet UILabel *lbl_footer;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnMonthDropdown:(id)sender;
- (IBAction)btnWeekDropDown:(id)sender;
- (IBAction)btnDone:(id)sender;

@end
