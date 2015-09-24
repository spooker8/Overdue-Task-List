//
//  AddTaskViewController.m
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(Task *)returnNewTaskObject
{
    
    Task *taskObject = [[Task alloc] init];
    taskObject.title = self.textField.text;
    taskObject.description1= self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.isCompleted = NO;
    
    return taskObject;
    
}


- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    
    
    [self.delegate didAddTask: [self returnNewTaskObject]];
    
    
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate didCancel];
    
    
    
}
@end
