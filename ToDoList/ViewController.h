//
//  ViewController.h
//  ToDoList
//
//  Created by Natasha Murashev on 5/8/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDelegate.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, EditDelegate>

@end
