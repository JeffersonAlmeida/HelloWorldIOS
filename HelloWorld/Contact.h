//
//  Contact.h
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contact : NSManagedObject <MKAnnotation>
@property NSString * name;
@property NSString * phone;
@property NSString * address;
@property NSString * site;
@property (strong) UIImage *image;
@property NSNumber * lat;
@property NSNumber * log;
@end
