//
//  CandyDetailsViewController.m
//  CandyStore
//
//  Created by Jordan on 9/19/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyDetailsViewController.h"
#import "CandyPictureViewController.h"

@interface CandyDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *candyImage;
@property (weak, nonatomic) IBOutlet UILabel *candyName;

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

- (void) viewWillAppear:(BOOL)animated {
//    Candy *nextCandy = self.candyObjects[indexPath.row];
    [self.candyName setText:self.candy.name];
    
    UIImage *picture = [UIImage imageNamed:self.candy.picturePath];
    [self.candyImage setImage:picture];
}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 
     if ([segue.identifier isEqualToString:@"viewPic"]) {
         CandyPictureViewController *candyPictureViewController = [segue destinationViewController];
         candyPictureViewController.candy = self.candy;
     } else if ([segue.identifier isEqualToString:@"viewMap"]) {

     }
 }

@end
