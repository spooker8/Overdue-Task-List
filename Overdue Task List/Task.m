//
//  Task.m
//  Overdue Task List
//
//  Created by Anand Kumar on 19/09/2015.
//  Copyright © 2015 anand. All rights reserved.
//

#import "Task.h"

@implementation Task

-(id)initWithData: (NSDictionary*)data
{
    
    self = [super init];
    
    
    if (self) {
        
        self.title = data[TASK_TITLE];
        self.description1 = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
                
        
    }
    
    
    return self;
    
    
}

-(id)init
{
    
    self = [self initWithData:nil];
    
    return self;
}

@end
