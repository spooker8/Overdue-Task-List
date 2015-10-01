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
    
    self.textView.delegate = self;
    self.textField.delegate = self;
    
    
    
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


#pragma mark UITEXTfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.textField resignFirstResponder];
    return YES;
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]){
        
        [self.textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
}


@end
