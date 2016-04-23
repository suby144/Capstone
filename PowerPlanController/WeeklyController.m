//
//  WeeklyController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "WeeklyController.h"
#import "Dropdowncell.h"
#import "WebserviceModel.h"
#import "MBProgressHUD.h"
@interface WeeklyController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WeeklyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableview_week.estimatedRowHeight = 30.0;
    self.tableview_week.rowHeight = UITableViewAutomaticDimension;
    self.tableview_month.estimatedRowHeight = 30.0;
    self.tableview_month.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   // self..text = week;
    //self.lbl_month.text = month;
    
    self.lbl_goal.text = [NSString stringWithFormat:@"Your goal percentage : %@%%",self.goal];
    array_month = [[NSArray alloc]initWithObjects:@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
    array_weeks = [[NSArray alloc] initWithObjects:@"week1",@"week2",@"week3",@"week4",nil];
    month = [self.dictionary_user_data objectForKey:@"month"];
    week = [self.dictionary_user_data objectForKey:@"week"];
    self.lbl_month.text = [array_month objectAtIndex:[month integerValue]-1];
    self.lbl_week.text = week;
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

- (IBAction)btnMonthDropdown:(id)sender {
   
//    [self.view insertSubview:self.view_dd aboveSubview:self.pieChart];
//    self.tableview_month.dataSource = self;
//    self.tableview_month.delegate= self;
    
    self.tableview_month.hidden = NO;
    [self.view insertSubview:self.tableview_month aboveSubview:self.pieChart];
    self.tableview_week.hidden = YES;
    [self.tableview_month reloadData];
}

- (IBAction)btnWeekDropDown:(id)sender {
//    self.tableview_week.dataSource = self;
//    self.tableview_week.delegate = self;
    self.tableview_month.hidden = YES;
    self.tableview_week.hidden = NO;
    [self.view insertSubview:self.tableview_week aboveSubview:self.pieChart];
    [self.tableview_week reloadData];
}

- (IBAction)btnDone:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getWeeklyDataWithMonth:month andWeeks:week];
}
#pragma mark
#pragma TABLEVIEW DELEGATES
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableview_month) {
        return array_month.count;
    }
    else{
        return array_weeks.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview_month) {
        Dropdowncell *cell = [self.tableview_month dequeueReusableCellWithIdentifier:@"month" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        cell.lbl_month.text  = [array_month objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        Dropdowncell *cell = [self.tableview_week dequeueReusableCellWithIdentifier:@"week" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        cell.lbl_week.text  = [array_weeks objectAtIndex:indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (tableView == self.tableview_month) {
        self.lbl_month.text = [array_month objectAtIndex:indexPath.row];
        month = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
    else{
        self.lbl_week.text = [array_weeks objectAtIndex:indexPath.row];
        week = [array_weeks objectAtIndex:indexPath.row];
    }
    
    self.tableview_month.hidden = YES;
    self.tableview_week.hidden = YES;
    [self.view setNeedsDisplay];
}

#pragma mark
#pragma PRIVATE METHODS
-(void)loadChartView{
    self.lbl_footer.text = [NSString stringWithFormat:@"%@-%@",[self.lbl_month.text capitalizedString],[self.lbl_week.text capitalizedString]];
    self.tableview_month.hidden = YES;
    self.tableview_week.hidden = YES;
    NSArray *array_weekly_consumption = [[self.dictionary_user_data objectForKey:@"weekly_consumption"] componentsSeparatedByString:@","];
    NSArray *array_color = @[PNRed,PNGreen,PNBlue,PNBrown,PNLightGreen,PNLightBlue,PNLightGrey];
    NSArray *array_week = @[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i=0; i < array_weekly_consumption.count; i++) {
        [items addObject:[PNPieChartDataItem dataItemWithValue:[[array_weekly_consumption objectAtIndex:i] floatValue] color:[array_color objectAtIndex:i] description:[array_week objectAtIndex:i]]];
    }
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 140, 165  , 250, 250) items:items];
    }
    else{
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2.0 - 140, (CGRectGetHeight(self.view.frame)-70)*0.5-50  , 250, 250) items:items];
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
    [legend setFrame:CGRectMake(self.view.frame.size.width-50, (CGRectGetHeight(self.view.frame)-CGRectGetHeight(legend.frame)-50), 30, legend.frame.size.height)];
    [self.view addSubview:legend];
    
    [self.view addSubview:self.pieChart];
    
}
-(void)getWeeklyDataWithMonth:(NSString *)months andWeeks :(NSString *)weeks{
    
    NSString *params = [NSString stringWithFormat:@"action=getWeeklyData&user_id=%@&month=%@&week_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],month,week];
    [WebserviceModel getDataWithParams:params urlServer:baseurl withCompletionHandler:^(id response) {
        if ([[response objectForKey:@"status"] isEqualToString:@"success" ]) {
            self.dictionary_user_data =(NSDictionary *)response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self loadChartView];
            });
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"No data available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    } andFailure:^(NSString *errormessage) {
        
    }];
    
}
#pragma mark
#pragma mark METHOD FOR HIDE GRADIENT VIEW
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableview_week.hidden = YES;
        self.tableview_month.hidden = YES;
    });
}
@end
