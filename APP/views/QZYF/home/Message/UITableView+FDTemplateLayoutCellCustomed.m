#import "UITableView+FDTemplateLayoutCellCustomed.h"
#import <objc/runtime.h>

#pragma mark - _FDTemplateLayoutCellHeightCache

@interface _FDTemplateLayoutCellHeightCacheCustomed : NSObject
// 2 dimensions array, sections-rows-height
@property (nonatomic, strong) NSMutableArray *sections;
@end

// Tag a absent height cache value which will be set to a real value.
static CGFloat const _FDTemplateLayoutCellHeightCacheAbsentValue = -1;
CGFloat const FDTemplateLayoutCellHeightCacheNone = 0;

@implementation _FDTemplateLayoutCellHeightCacheCustomed

- (void)buildHeightCachesAtIndexPathsIfNeeded:(NSArray *)indexPaths
{
    if (indexPaths.count == 0) {
        return;
    }
    
    if (!self.sections) {
        self.sections = @[].mutableCopy;
    }
    
    // Build every section array or row array which is smaller than given index path.
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        for (NSInteger section = 0; section <= indexPath.section; ++section) {
            if (section >= self.sections.count) {
                self.sections[section] = @[].mutableCopy;
            }
        }
        NSMutableArray *rows = self.sections[indexPath.section];
        for (NSInteger row = 0; row <= indexPath.row; ++row) {
            if (row >= rows.count) {
                rows[row] = @(_FDTemplateLayoutCellHeightCacheAbsentValue);
            }
        }
    }];
}

- (BOOL)hasCachedHeightAtIndexPath:(NSIndexPath *)indexPath
{
    [self buildHeightCachesAtIndexPathsIfNeeded:@[indexPath]];
    NSNumber *cachedNumber = self.sections[indexPath.section][indexPath.row];
    return ![cachedNumber isEqualToNumber:@(_FDTemplateLayoutCellHeightCacheAbsentValue)];
}

- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath
{
    [self buildHeightCachesAtIndexPathsIfNeeded:@[indexPath]];
    self.sections[indexPath.section][indexPath.row] = @(height);
}

- (CGFloat)cachedHeightAtIndexPath:(NSIndexPath *)indexPath
{
    [self buildHeightCachesAtIndexPathsIfNeeded:@[indexPath]];
#if CGFLOAT_IS_DOUBLE
    return [self.sections[indexPath.section][indexPath.row] doubleValue];
#else
    return [self.sections[indexPath.section][indexPath.row] floatValue];
#endif
}

@end


#pragma mark - UITableView + FDTemplateLayoutCellPrivate

/// These methods are private for internal use, maybe public some day.
@interface UITableView (FDTemplateLayoutCellPrivateCustomed)

/// A private height cache data structure.
@property (nonatomic, strong, readonly) _FDTemplateLayoutCellHeightCacheCustomed *fd_cellHeightCacheCustomed;

/// This is a private switch that I don't think caller should concern.
/// Auto turn on when you use "-fd_heightForCellWithIdentifier:cacheByIndexPath:configuration".
@property (nonatomic, assign) BOOL fd_autoCacheInvalidationEnabledCustomed;

/// Debug log controlled by "fd_debugLogEnabled".
- (void)fd_debugLogCustomed:(NSString *)message;

@end

@implementation UITableView (FDTemplateLayoutCellPrivateCustomed)

- (_FDTemplateLayoutCellHeightCacheCustomed *)fd_cellHeightCacheCustomed
{
    _FDTemplateLayoutCellHeightCacheCustomed *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [_FDTemplateLayoutCellHeightCacheCustomed new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
    }
    return cache;
}

- (BOOL)fd_autoCacheInvalidationEnabledCustomed
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_autoCacheInvalidationEnabledCustomed:(BOOL)enabled
{
    objc_setAssociatedObject(self, @selector(fd_autoCacheInvalidationEnabledCustomed), @(enabled), OBJC_ASSOCIATION_RETAIN);
}

- (void)fd_debugLogCustomed:(NSString *)message
{
    if (!self.fd_debugLogEnabledCustomed) {
        return;
    }
    DDLogVerbose(@"** FDTemplateLayoutCell ** %@", message);
}

@end

#pragma mark - UITableView + FDTemplateLayoutCellAutomaticallyCacheInvalidation

@implementation UITableView (FDTemplateLayoutCellAutomaticallyCacheInvalidationCustomed)

+ (void)load
{
    // All methods that trigger height cache's invalidation
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(moveSection:toSection:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
        @selector(moveRowAtIndexPath:toIndexPath:)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"cfd_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)cfd_reloadData
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [self.fd_cellHeightCacheCustomed.sections removeAllObjects];
    }
    [self cfd_reloadData]; // Primary call
}

-  (void)cfd_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self.fd_cellHeightCacheCustomed.sections insertObject:@[].mutableCopy atIndex:idx];
        }];
    }
    [self cfd_insertSections:sections withRowAnimation:animation]; // Primary call
}

-  (void)cfd_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self.fd_cellHeightCacheCustomed.sections removeObjectAtIndex:idx];
        }];
    }
    [self cfd_deleteSections:sections withRowAnimation:animation]; // Primary call
}

-  (void)cfd_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [sections enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
            if (idx < self.fd_cellHeightCacheCustomed.sections.count) {
                NSMutableArray *rows = self.fd_cellHeightCacheCustomed.sections[idx];
                for (NSInteger row = 0; row < rows.count; ++row) {
                    rows[row] = @(_FDTemplateLayoutCellHeightCacheAbsentValue);
                }
            }
        }];
    }
    [self cfd_reloadSections:sections withRowAnimation:animation]; // Primary call
}

-  (void)cfd_moveSection:(NSInteger)section toSection:(NSInteger)newSection
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        NSInteger sectionCount = self.fd_cellHeightCacheCustomed.sections.count;
        if (section < sectionCount && newSection < sectionCount) {
            [self.fd_cellHeightCacheCustomed.sections exchangeObjectAtIndex:section withObjectAtIndex:newSection];
        }
    }
    [self cfd_moveSection:section toSection:newSection]; // Primary call
}

-  (void)cfd_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [self.fd_cellHeightCacheCustomed buildHeightCachesAtIndexPathsIfNeeded:indexPaths];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableArray *rows = self.fd_cellHeightCacheCustomed.sections[indexPath.section];
            [rows insertObject:@(_FDTemplateLayoutCellHeightCacheAbsentValue) atIndex:indexPath.row];
        }];
    }
    [self cfd_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation]; // Primary call
}

-  (void)cfd_deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [self.fd_cellHeightCacheCustomed buildHeightCachesAtIndexPathsIfNeeded:indexPaths];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableArray *rows = self.fd_cellHeightCacheCustomed.sections[indexPath.section];
            [rows removeObjectAtIndex:indexPath.row];
        }];
    }
    [self cfd_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation]; // Primary call
}

-  (void)cfd_reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [self.fd_cellHeightCacheCustomed buildHeightCachesAtIndexPathsIfNeeded:indexPaths];
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableArray *rows = self.fd_cellHeightCacheCustomed.sections[indexPath.section];
            rows[indexPath.row] = @(_FDTemplateLayoutCellHeightCacheAbsentValue);
        }];
    }
    [self cfd_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation]; // Primary call
}

-  (void)cfd_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (self.fd_autoCacheInvalidationEnabledCustomed) {
        [self.fd_cellHeightCacheCustomed buildHeightCachesAtIndexPathsIfNeeded:@[sourceIndexPath, destinationIndexPath]];
        
        NSMutableArray *sourceRows = self.fd_cellHeightCacheCustomed.sections[sourceIndexPath.section];
        NSMutableArray *destinationRows = self.fd_cellHeightCacheCustomed.sections[destinationIndexPath.section];
        
        NSNumber *sourceValue = sourceRows[sourceIndexPath.row];
        NSNumber *destinationValue = destinationRows[destinationIndexPath.row];
        
        sourceRows[sourceIndexPath.row] = destinationValue;
        destinationRows[destinationIndexPath.row] = sourceValue;
    }
    [self cfd_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath]; // Primary call
}

@end

#pragma mark - [Public] UITableView + FDTemplateLayoutCell

@implementation UITableView (FDTemplateLayoutCellCustomed)

- (void)fd_cacheHeiht:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath
{
    [self fd_debugLogCustomed:[NSString stringWithFormat:
                       @"cached - [%@:%@] %@",
                       @(indexPath.section),
                       @(indexPath.row),
                       @(height)]];
    
    // Cache it
    [self.fd_cellHeightCacheCustomed cacheHeight:height byIndexPath:indexPath];
    
}

- (CGFloat)fd_heightForCellCacheByIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return FDTemplateLayoutCellHeightCacheNone;
    }
    
    // Enable auto cache invalidation if you use this "cacheByIndexPath" API.
    if (!self.fd_autoCacheInvalidationEnabledCustomed) {
        self.fd_autoCacheInvalidationEnabledCustomed = YES;
    }
    
    // Hit the cache
    if ([self.fd_cellHeightCacheCustomed hasCachedHeightAtIndexPath:indexPath]) {
        [self fd_debugLogCustomed:[NSString stringWithFormat:
                           @"hit cache - [%@:%@] %@",
                           @(indexPath.section),
                           @(indexPath.row),
                           @([self.fd_cellHeightCacheCustomed cachedHeightAtIndexPath:indexPath])]];
        return [self.fd_cellHeightCacheCustomed cachedHeightAtIndexPath:indexPath];
    } else {
        return FDTemplateLayoutCellHeightCacheNone;
    }
}

- (BOOL)fd_debugLogEnabledCustomed
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_debugLogEnabledCustomed:(BOOL)debugLogEnabled
{
    objc_setAssociatedObject(self, @selector(fd_debugLogEnabledCustomed), @(debugLogEnabled), OBJC_ASSOCIATION_RETAIN);
}

@end


