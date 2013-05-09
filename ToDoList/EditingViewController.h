//
//  EditingViewController.h
//  ToDoList
//
//  Created by Natasha Murashev on 5/8/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditDelegate.h"

@interface EditingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) id<EditDelegate> delegate;

@end
