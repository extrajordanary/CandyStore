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

@interface CandyListTableViewController ()

@end

@implementation CandyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add each of the candy objects to self.candyObjects array
    [self updateCandyObjectsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // get number of Candy Objects
    [self updateCandyObjectsArray];
    
    int numRows = (int)[self.candyObjects count];
    NSLog(@"%i",numRows);
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UICandyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandyCell" forIndexPath:indexPath];
    
    Candy *nextCandy = self.candyObjects[indexPath.row];
    [cell.candyName setText:nextCandy.name];
    
    UIImage *picture = [UIImage imageNamed:nextCandy.picturePath];
    [cell.candyThumbnail setImage:picture];
    
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
 
    // which row was selected
    // which Candy object needs to be passed to next view
}

#pragma mark - Candy Objects

- (void) updateCandyObjectsArray {

    // get access to the managed object context
    NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    // get entity description for entity we are selecting
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Candy" inManagedObjectContext:context];
    // create a new fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
//    // OPTIONAL: apply a filter by creating a predicate and adding it to the request
//    NSNumber *minimumAge = @(20);
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"age > %@)", minimumAge];
//    [request setPredicate:predicate];
    
//    // OPTIONAL: create a sort rule and add it to the request
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
//                                        initWithKey:@"age" ascending:YES];
//    [request setSortDescriptors:@[sortDescriptor]];
    
    // create an error variable to pass to the execute method
    NSError *error;
    
    // retrieve results
    NSArray *array = [context executeFetchRequest:request error:&error]; 
    if (array == nil) { 
        //error handling, e.g. display err
    }
//    if (array.count == 0) {
//        [self createOneCandy:context];
//        array = [context executeFetchRequest:request error:&error];
//    }

    if (array.count == 0) {
        [self createOneCandy:context]; // actually makes 5
        array = [context executeFetchRequest:request error:&error];
    }
    
    self.candyObjects = array;
}

- (void) createOneCandy:(NSManagedObjectContext*)context {
    // actually, create 5 test candies
    for (int i = 0 ; i < 5; i++) {
        Candy *newCandy = [NSEntityDescription insertNewObjectForEntityForName:@"Candy" inManagedObjectContext:context];
        
        NSString *newName = [NSString stringWithFormat:@"Tasty tasty test candy %i",i];
        NSString *newPic = [NSString stringWithFormat:@"testCandy%i.jpg",i];

        newCandy.name = newName;
        newCandy.picturePath = newPic;
        newCandy.locationLat = [NSNumber numberWithInt:1];
        newCandy.locationLon = [NSNumber numberWithInt:2];
    }


//    NSManagedObject *newCandy = [NSEntityDescription insertNewObjectForEntityForName:@"Candy" inManagedObjectContext:context];
//    
//    [newCandy setValue:@"Tasty tasty test candy" forKey:@"name"];
//    [newCandy setValue:@"hedgehogChocolate.jpg" forKey:@"picturePath"];
//    [newCandy setValue:[NSNumber numberWithInt:1] forKey:@"locationLat"];
//    [newCandy setValue:[NSNumber numberWithInt:2] forKey:@"locationLon"];
    
    // create error to pass to the save method
    NSError *error = nil;
    
    // attempt to save the context to persist changes
    [context save:&error];
    
    if (error) {
        // error handling
    }
}

@end
