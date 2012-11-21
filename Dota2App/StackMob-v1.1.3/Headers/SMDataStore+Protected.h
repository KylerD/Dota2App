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
#import "SMUserSession.h"
#import "SMResponseBlocks.h"

/**
 Supplemental methods for <SMDataStore>.  In essence they add an extra layer of logic to existing `SMDataStore` methods for special conditions. 
 
 @note You shouldn't need to import this file or use any of these methods directly. They are deliberately abstracted out for use by `SMDataStore` and `SMClient`.
 
 */
@interface SMDataStore (SpecialCondition)


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForSchema:(NSString *)schema withSuccessBlock:(SMDataStoreSuccessBlock)successBlock;


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForObjectId:(NSString *)theObjectId ofSchema:(NSString *)schema withSuccessBlock:(SMDataStoreObjectIdSuccessBlock)successBlock;


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForSuccessBlock:(SMSuccessBlock)successBlock ;


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForResultSuccessBlock:(SMResultSuccessBlock)successBlock;


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForResultsSuccessBlock:(SMResultsSuccessBlock)successBlock;


- (SMFullResponseSuccessBlock)SMFullResponseSuccessBlockForQuerySuccessBlock:(SMResultsSuccessBlock)successBlock;


- (SMFullResponseFailureBlock)SMFullResponseFailureBlockForObject:(NSDictionary *)theObject ofSchema:(NSString *)schema withFailureBlock:(SMDataStoreFailureBlock)failureBlock;


- (SMFullResponseFailureBlock)SMFullResponseFailureBlockForObjectId:(NSString *)theObjectId ofSchema:(NSString *)schema withFailureBlock:(SMDataStoreObjectIdFailureBlock)failureBlock;


- (SMFullResponseFailureBlock)SMFullResponseFailureBlockForFailureBlock:(SMFailureBlock)failureBlock;


- (int)countFromRangeHeader:(NSString *)rangeHeader results:(NSArray *)results;


- (void)readObjectWithId:(NSString *)theObjectId 
                inSchema:(NSString *)schema 
              parameters:(NSDictionary *)parameters 
             options:(SMRequestOptions *)options 
               onSuccess:(SMDataStoreSuccessBlock)successBlock 
               onFailure:(SMDataStoreObjectIdFailureBlock)failureBlock;

- (void)queueRequest:(NSURLRequest *)request options:(SMRequestOptions *)options onSuccess:(SMFullResponseSuccessBlock)onSuccess onFailure:(SMFullResponseFailureBlock)onFailure;

- (NSString *)URLEncodedStringFromValue:(NSString *)value;


@end
