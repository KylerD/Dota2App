//
//  NSManagedObject+CRUD.h
//  EvolveMobile
//
//  Created by Karol Buczel on 19/03/2012.
//  Copyright (c) 2012 Kainos Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSManagedObject(CRUD)

+ (NSString *)entityName;
+ (NSManagedObjectContext *)database;
+ (id)createObject;
+ (id)readOrCreateObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue;
+ (id)readObjectWithParamterName:(NSString *)parameterName andValue:(id)parameterValue;
+ (NSArray*)readObjectsWithPredicate:(NSPredicate*)pred andSortKey:(NSString*)sortKey;
+ (NSArray *)readAllObjects;
+ (void)removeAllObjects;
+ (void)deleteObject:(NSObject *)object;
+ (BOOL)saveDatabase;

@end