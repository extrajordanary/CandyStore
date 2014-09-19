//
//  CandyDetailsViewController.m
//  CandyStore
//
//  Created by Jordan on 9/19/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyDetailsViewController.h"

@interface CandyDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *candyImage;

@end

@implementation CandyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.candyImage setClipsToBounds:YES]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
