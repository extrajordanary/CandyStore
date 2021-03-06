//
//  CandyDetailsViewController.m
//  CandyStore
//
//  Created by Jordan on 9/19/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyDetailsViewController.h"
#import "CandyPictureViewController.h"
#import "CandyMapViewController.h"
#import "CandyListTableViewController.h"
#import "AppDelegate.h"

//@class CandyMapViewController;

@interface CandyDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *candyImage;
@property (weak, nonatomic) IBOutlet UITextView *candyNotes;
@property (weak, nonatomic) IBOutlet UITextField *candyName;

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
    [super viewWillAppear:animated];
    
    [self.candyName setText:self.candy.name];
    
    UIImage *picture = [UIImage imageWithData:self.candy.image];
    [self.candyImage setImage:picture];
    
    [self.candyNotes setText:self.candy.notes];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;

    self.candy = (Candy *)[context existingObjectWithID:self.candy.objectID error:nil];
    
    if (self.candy) {
        self.candy.notes = self.candyNotes.text;
        self.candy.name = self.candyName.text;
        
        if (self.candy.hasChanges){ // runs every time but doesnt need to TODO
            NSManagedObjectContext *context = self.candy.managedObjectContext;
            NSError *error = nil;
            [context save:&error];
            if (error) {
                // error handling
            }
        }
    }

}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 
     if ([segue.identifier isEqualToString:@"viewPic"]) {
         CandyPictureViewController *candyPictureViewController = [segue destinationViewController];
         candyPictureViewController.candy = self.candy;
     } else if ([segue.identifier isEqualToString:@"viewMap"]) {
         CandyMapViewController *candyMapViewController = [segue destinationViewController];
         candyMapViewController.candy = self.candy;
     } else if ([segue.identifier isEqualToString:@"deleteCandy"]) {
         NSManagedObjectContext *context = self.candy.managedObjectContext;
         [context deleteObject:self.candy];
         NSError *error = nil;
         [context save:&error];
         if (error) {
             // error handling
         }
     }
 }

@end
