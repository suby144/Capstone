//
//  MonthlyController.m
//  PowerPlanController
//
//  Created by Appcircle on 4/22/16.
//  Copyright © 2016 Appcircle. All rights reserved.
//

#import "MonthlyController.h"

@interface MonthlyController ()


@end

@implementation MonthlyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lbl_goal.text = [NSString stringWithFormat:@"Your goal percentage : %@%%",self.goal];
    array_monthly_consumption = [[NSMutableArray alloc]init];
    array_max = [[NSMutableArray alloc]init];
    self.view_powerconsumed.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    self.view_powerplaned.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    [self loadBarChart];

}
- (void)loadBarChart {
    NSArray *labels;
    for (NSString *item in [[self.dictionary_user_data objectForKey:@"monthly_consumption"] componentsSeparatedByString:@","]) {
        NSNumber *number = [NSNumber numberWithInteger:[item integerValue]];
        [array_monthly_consumption addObject:number];
    }
    
    for (int i = 0; i<array_monthly_consumption.count; i++) {
        NSNumber *number = [NSNumber numberWithInteger:[[self.dictionary_user_data objectForKey:@"yearly_consumption"] integerValue]/12];
        [array_max addObject:number];
    }
    if (IS_IPHONE_4_OR_LESS | IS_IPHONE_5) {
        _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 280)];
        labels = @[@"Jan", @"", @"Mar", @"", @"May",@"", @"Jul", @"", @"Sep",@"", @"Nov",@""];
    }
    else{
        _chartView = [[TWRChartView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 300)];
        labels = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May",@"Jun", @"Jul", @"Aug", @"Sep",@"Oct", @"Nov",@"Dec"];
    }
    
    _chartView.backgroundColor = [UIColor clearColor];
    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    [_chartView setChartJsFilePath:jsFilePath];
    [self.view addSubview:_chartView];
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:array_max
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];
    
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:array_monthly_consumption
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];
    
  //  NSArray *labels = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May",@"Jun", @"Jul", @"Aug", @"Sep",@"Oct", @"Nov",@"Dec"];
    TWRBarChart *bar = [[TWRBarChart alloc] initWithLabels:labels
                                                  dataSets:@[dataSet1, dataSet2]
                                                  animated:YES];
    [_chartView loadBarChart:bar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBack:(id)sender{
      [self.navigationController popViewControllerAnimated:YES];
}
@end
