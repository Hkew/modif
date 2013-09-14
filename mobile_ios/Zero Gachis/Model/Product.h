//
//  Product.h
//  Zero Gachis
//
//  Created by Tony Cois on 15/07/13.
//  Copyright (c) 2013 Zero Gachis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject


@property (nonatomic, retain) NSString * date_derniere_maj;
@property (nonatomic, retain) NSNumber * derniere_maj_h;
@property (nonatomic, retain) NSNumber * derniere_maj_j;
@property (nonatomic, retain) NSString * dlc;
@property (nonatomic, retain) NSNumber * jours_restants;
@property (nonatomic, retain) NSNumber * lot;
@property (nonatomic, retain) NSString * marque;
@property (nonatomic, retain) NSString * nom;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSNumber * poids;
@property (nonatomic, retain) NSString * prix_final;
@property (nonatomic, retain) NSString * prix_initial;
@property (nonatomic, retain) NSNumber * quantite_restante;
@property (nonatomic, retain) NSString * reduction;
@property (nonatomic, retain) NSString * unite;

@end
