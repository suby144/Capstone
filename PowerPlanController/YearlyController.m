//
//  YearlyController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "YearlyController.h"

@interface YearlyController ()

@end

@implementation YearlyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lbl_goal.text = [NSString stringWithFormat:@"Your goal percentage : %@%%",self.goal];
    self.lbl_year.text = [NSString stringWithFormat:@"Year-%@",[self.dictionary_user_data objectForKey:@"year"]];
    [self loadChartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark IBACTIONS
- (IBAction)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark
#pragma PRIVATE METHODS
-(void)loadChartView{
    NSArray *array_monthly_consumption = [[self.dictionary_user_data objectForKey:@"monthly_consumption"] componentsSeparatedByString:@","];
    NSArray *array_color = @[PNRed,PNGreen,PNBlue,PNStarYellow,PNLightGreen,PNLightBlue,PNLightGrey,PNYellow,PNBrown,PNDeepGreen,PNTwitterColor,PNWeiboColor];
    NSArray *array_month = @[@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC"];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i=0; i < array_monthly_consumption.count; i++) {
        [items addObject:[PNPieChartDataItem dataItemWithValue:[[array_monthly_consumption objectAtIndex:i] floatValue] color:[array_color objectAtIndex:i] description:[array_month objectAtIndex:i]]];
    }
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 140, (CGRectGetHeight(self.view.frame)-70)*0.5-50  , 250, 250) items:items];
    }
    else{
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 130, (CGRectGetHeight(self.view.frame)-70)*0.5-50  , 250, 250) items:items];
    }
    self.pieChart.descriptionTextColor = [UIColor blackColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    [self.pieChart strokeChart];
    
    
    self.pieChart.legendStyle = PNLegendItemStyleStacked;
    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [self.pieChart getLegendWithMaxWidth:80];
    [legend setFrame:CGRectMake(self.view.frame.size.width-45, 130, 30, legend.frame.size.height)];
    [self.view addSubview:legend];
    
    [self.view addSubview:self.pieChart];
}
@end
