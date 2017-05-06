//
//  Contact.m
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@dynamic name, phone, address, site, image, lat, log;

    -(NSString *) description {
        return [NSString stringWithFormat:
            @" Name: %@ \n Phone: %@ \n Address: %@ \n Site: %@ \n Lat: %@\n Long: %@ ", self.name, self.phone, self.address, self.site, self.lat, self.log];
    }

    - (CLLocationCoordinate2D)coordinate {
        return CLLocationCoordinate2DMake([self.lat doubleValue],
                                          [self.log doubleValue]);
    }
    
    -(NSString *) title{
        return self.name;
    }

    -(NSString *) subtitle{
        return self.site;
    }

    
@end
