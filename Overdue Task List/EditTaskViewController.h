//
//  EditTaskViewController.h
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItemPressed;
@end
