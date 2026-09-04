// t45_hash_if_forms.cpp
//

#include "t45_hash_if_forms.h"
#define LZZ_INLINE inline
int known ()
             { return 1; }
#if defined (ARCH_X)
int chain ()
             { return 1; }
#elif defined (ARCH_Y)
int chain ()
             { return 2; }
#else
int chain ()
             { return 3; }
#endif
#undef LZZ_INLINE
