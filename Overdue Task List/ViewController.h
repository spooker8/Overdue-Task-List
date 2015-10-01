//
//  ViewController.h
//  Overdue Task List
//
//  Created by Anand Kumar on 16/09/2015.
//  Copyright (c) 2015 anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"


@interface ViewController : UIViewController  <AddTaskViewControllerDelegate, DetailTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>



@property (strong, nonatomic) NSMutableArray *taskObjects;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTaskBarItemPressed;

- (IBAction)reorderBarButtonItempressed:(id)sender;
//- (IBAction)addTaskBarButtonItempressed:(id)sender;


@end

