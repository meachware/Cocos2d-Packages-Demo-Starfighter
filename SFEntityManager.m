#import "SFEntityManager.h"
#import "SFEntity.h"
#import "SFComponent.h"


@interface  SFEntityManager()

@property (nonatomic, strong) NSMutableDictionary *entities;
@property (nonatomic, strong) NSMutableDictionary *componentsByClass;


@end


@implementation SFEntityManager

- (id)init
{
    self = [super init];

    if (self)
    {
        self.entities = [NSMutableDictionary dictionary];
        self.componentsByClass = [NSMutableDictionary dictionary];
    }

    return self;
}

+ (SFEntityManager *)sharedManager
{
    static SFEntityManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (SFEntity *)createEntity
{
    NSString *uuid = [[NSUUID UUID] UUIDString];

    SFEntity *entity = [[SFEntity alloc] initWithUUID:uuid];

    _entities[uuid] = entity;

    return entity;
}

- (void)addComponent:(SFComponent *)component toEntity:(SFEntity *)entity
{
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass([component class])];
    if (!components)
    {
        components = [NSMutableDictionary dictionary];
        _componentsByClass[NSStringFromClass([component class])] = components;
    }
    components[entity.uuid] = component;
}

- (id)componentOfClass:(Class)class forEntity:(SFEntity *)entity
{
    return _componentsByClass[NSStringFromClass(class)][entity.uuid];
}

- (void)removeEntity:(SFEntity *)entity
{
    for (NSMutableDictionary *components in _componentsByClass.allValues)
    {
        if (components[entity.uuid])
        {
            [components removeObjectForKey:entity.uuid];
        }
    }
    [_entities removeObjectForKey:entity.uuid];
}

- (NSArray *)allEntitiesPosessingComponentOfClass:(Class)class
{
    NSMutableDictionary *components = _componentsByClass[NSStringFromClass(class)];
    if (components)
    {
        NSMutableArray *retval = [NSMutableArray arrayWithCapacity:components.allKeys.count];
        for (NSString *uuid in components.allKeys)
        {
            [retval addObject:_entities[uuid]];
        }
        return retval;
    }
    else
    {
        return [NSArray array];
    }
}

@end