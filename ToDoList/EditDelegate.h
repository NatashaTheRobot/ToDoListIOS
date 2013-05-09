//
//  EditDelegate.h
//  ToDoList
//
//  Created by Natasha Murashev on 5/8/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EditDelegate <NSObject>

- (void)updateText:(NSString *)newText atIndexPath:(NSIndexPath *)indexPath;

@end
