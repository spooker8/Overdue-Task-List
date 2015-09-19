//
//  Task.h
//  Overdue Task List
//
//  Created by Anand Kumar on 19/09/2015.
//  Copyright © 2015 anand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject


@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description1;
@property(strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;


-(id)initWithData: (NSDictionary*)data;



@end
