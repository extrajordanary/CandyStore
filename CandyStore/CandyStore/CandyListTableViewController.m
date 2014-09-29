//
//  CandyListTableViewController.m
//  CandyStore
//
//  Created by Jordan on 9/16/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyListTableViewController.h"
#import "AppDelegate.h"
#import "Candy.h"
#import "UICandyTableViewCell.h"
#import "CandyDetailsViewController.h"
#include <stdlib.h>

@interface CandyListTableViewController ()

@end

@implementation CandyListTableViewController {
    NSManagedObjectContext *theContext;
    BOOL reloadTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // if first time, doesn't need a reload call
    reloadTable = NO;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    theContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;

    // add each of the candy objects to self.candyObjects array
    [self updateCandyObjectsArray];
    
    if (reloadTable) {
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Not using sections
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // get number of Candy Objects
    NSInteger numRows = [self.candyObjects count];
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UICandyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandyCell" forIndexPath:indexPath];
    
    Candy *nextCandy = self.candyObjects[indexPath.row];
    [cell.candyName setText:nextCandy.name];
    
    UIImage *picture = [UIImage imageWithData:nextCandy.image];
    [cell.candyThumbnail setImage:picture];
    
    // reload every other time
    reloadTable = YES;
    
    return cell;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"viewCandy"]) {
        CandyDetailsViewController *candyDetailsViewController = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        candyDetailsViewController.candy = self.candyObjects[selectedIndexPath.row];
    } else if ([segue.identifier isEqualToString:@"addCandy"]) {
        CandyDetailsViewController *candyDetailsViewController = [segue destinationViewController];
        candyDetailsViewController.candy = [self createNewCandy:theContext];
    }
}

#pragma mark - Candy Objects

- (void) updateCandyObjectsArray {
    // get entity description for entity we are selecting
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Candy" inManagedObjectContext:theContext];
    // create a new fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    /*
    // OPTIONAL: apply a filter by creating a predicate and adding it to the request
    NSNumber *minimumAge = @(20);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"age > %@)", minimumAge];
    [request setPredicate:predicate];
    
    // OPTIONAL: create a sort rule and add it to the request
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"age" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    */
    
    // create an error variable to pass to the execute method
    NSError *error;
    
    // retrieve results
    NSArray *array = [theContext executeFetchRequest:request error:&error];
    if (array == nil) { 
        //error handling, e.g. display err
    }

    if (array.count == 0) {
        [self createOneCandy:theContext]; // actually makes 5
        array = [theContext executeFetchRequest:request error:&error];
    }
    
    self.candyObjects = array;
}

- (void) createOneCandy:(NSManagedObjectContext*)context {
    // actually, create 3 test candies
    for (int i = 0 ; i < 3; i++) {
        Candy *newCandy = [NSEntityDescription insertNewObjectForEntityForName:@"Candy" inManagedObjectContext:context];
        
        NSString *newName = [NSString stringWithFormat:@"Sample Candy %i",i+1];
        NSString *newPic = [NSString stringWithFormat:@"testCandy%i.jpg",i];

        newCandy.name = newName;
        newCandy.image = UIImagePNGRepresentation([UIImage imageNamed:newPic]);
        newCandy.notes = @"Candy Notes - Touch to edit. \n \nYou can also edit the name, picture and map location. Try it out! Then try deleting the sample candies.";
        
        // semi-random location jittered from office location
        double rand1 = ((double)arc4random_uniform(20)/1000)-.01;
        double rand2 = ((double)arc4random_uniform(20)/1000)-.01;
        newCandy.locationLat = [NSNumber numberWithDouble:37.777899+rand1];
        newCandy.locationLon = [NSNumber numberWithDouble:-122.399315+rand2];
    }
    
    // create error to pass to the save method
    NSError *error = nil;
    
    // attempt to save the context to persist changes
    [context save:&error];
    
    if (error) {
        // error handling
    }
}

- (Candy*) createNewCandy:(NSManagedObjectContext*)context {
    Candy *newCandy = [NSEntityDescription insertNewObjectForEntityForName:@"Candy" inManagedObjectContext:context];

    newCandy.name = @"Candy Name";
    newCandy.notes = @"Candy Notes - Touch to edit.";
    
    // add default picture
    newCandy.image = UIImagePNGRepresentation([UIImage imageNamed:@"defaultPhoto.png"]);


    // create error to pass to the save method
    NSError *error = nil;
    
    // attempt to save the context to persist changes
    [context save:&error];
    
    if (error) {
        // error handling
    }
    
    return newCandy;
}
@end
