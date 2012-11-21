/*
 * Copyright 2012 StackMob
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SMDataStore.h"

@class SMIncrementalStore;

/**
 The `SMCoreDataStore` class provides an `NSPersistentStoreCoordinator` and `NSManagedObjectContext` instance to the developer, configured to StackMob using the `SMUserSession` credentials.
 
 ## Using SMCoreDataStore ##
 
 With your `SMCoreDataStore` object you can retrieve a managed object context configured with a `SMIncrementalStore` as it's persistent store to allow communication to StackMob from Core Data.  This instance of `NSManagedObjectContext` should be used throughout the duration of your application by being passed to each controller's separate `NSManagedObjectContext` instance.
 
 @note You should not have to initialize an instance of this class directly.  Instead, initialize an instance of <SMClient> and use the method <coreDataStoreWithManagedObjectModel:> to retrieve an instance completely configured and ready to communicate to StackMob.
 */
@interface SMCoreDataStore : SMDataStore

///-------------------------------
/// @name Properties
///-------------------------------

/**
 An instance of `NSPersistentStoreCoordinator` with the `SMIncrementalStore` class as it's persistent store type.
 
 Uses the `NSManagedObjectModel` passed to the `coreDataStoreWithManagedObjectModel:` method in <SMClient>.
 */
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, strong) NSPersistentStoreCoordinator *localPersistentStoreCoordinator;

/**
 An instance of `NSManagedObjectContext` set with this class's persistent store coordinator.
 
 This is the managed object context to use throughout your application.
 */
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObjectContext *localManagedObjectContext;


///-------------------------------
/// @name Initialize
///-------------------------------

/**
 Initializes an `SMCoreDataStore`.
 
 @param apiVersion The API version of your StackMob application.
 @param session The session containing the credentials to use for requests made to StackMob by Core Data.
 @param managedObjectModel The managed object model to set to the persistent store coordinator.
 */
- (id)initWithAPIVersion:(NSString *)apiVersion session:(SMUserSession *)session managedObjectModel:(NSManagedObjectModel *)managedObjectModel;

/*
// Tentative API for saving and fetching:

typedef enum {
    SMStackMobPersistentStore,
    SMLocalPersistentStore
} SMPersistentStore;

//Fetch

// Will fetch based on settings
- (NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error;


- (NSArray *)executeFetchRequest:(NSFetchRequest *)request onStore:(SMPersistentStore)store error:(NSError **)error;

- (void)setDefaultStoreToFetchFrom:(SMPersistentStore)store;
- (void)setShouldFetchFromStackMobIfReachable:(BOOL)value;

// Save

- (void)performBlock;
- (void)performBlockAndWait;

- (void)performBlockInBackground;
- (void)performBlockInBackgroundAndWait;

- (void)performBlock:(void(^)()) inContext:(NSManagedObjectContext *)context synchronous:(BOOL)value;

// whether or not data should be persisted locally.
- (void)shouldSaveDataLocally:(BOOL)value;

- (void)setShouldFillFaultsFromLocalCache:(BOOL)value;
*/


@end
