//
//  MonthlyController.h
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TWRCharts/TWRChart.h>
@interface MonthlyController : UIViewController
{
    NSMutableArray *array_monthly_consumption;
    NSMutableArray *array_max;
}
@property (strong, nonatomic) NSString *goal;
@property (strong, nonatomic) NSDictionary *dictionary_user_data;
@property(strong, nonatomic) TWRChartView *chartView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_goal;
@property (strong, nonatomic) IBOutlet UIView *view_powerplaned;
@property (strong, nonatomic) IBOutlet UIView *view_powerconsumed;

- (IBAction)btnBack:(id)sender;
@end
