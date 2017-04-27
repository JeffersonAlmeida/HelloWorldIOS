//
//  Contact.m
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(NSString *) description {
    return [NSString stringWithFormat: @" Name: %@ \n Phone: %@ \n Address: %@ \n Site: %@ ", self.name, self.phone, self.address, self.site];
}


@end
