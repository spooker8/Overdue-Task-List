//
//  ViewController.m
//  Overdue Task List
//
//  Created by Anand Kumar on 16/09/2015.
//  Copyright (c) 2015 anand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController 


-(NSMutableArray *)taskObjects
{
    
    if (!_taskObjects)
    {
        
        _taskObjects = [[NSMutableArray alloc] init];
        
        
    }
    return _taskObjects;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItempressed:(id)sender {
}



#pragma mark -AddTaskViewControllerDelegate

-(void)didAddTask:(Task *)task
{
    
    [self.taskObjects addObject:task];
    
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];

    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];


    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
    
}


-(void)didCancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsPropertyList:(Task *)taskObject
{
    
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.isCompleted) };
    
    return dictionary;
    
}



@end
