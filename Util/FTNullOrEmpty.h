static inline BOOL FTIsNull(id object)
{
	BOOL isNull = NO;
	if (object == nil || object == [NSNull null]) {
		isNull = YES;
	}
	return isNull;
}

static inline BOOL FTIsEmpty(id object)
{
	BOOL isEmpty = NO;
	
	if (FTIsNull(object) == YES
		|| ([object respondsToSelector: @selector(length)] 
			&& [object length] == 0) 
		|| ([object respondsToSelector: @selector(count)] 
			&& [object count] == 0)) {
		isEmpty = YES;
	}
	return isEmpty;
}