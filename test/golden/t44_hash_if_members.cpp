// t44_hash_if_members.cpp
//

#include "t44_hash_if_members.h"
#define LZZ_INLINE inline
#ifdef __aarch64__
int Repro::armFn () const
                       { return onlyArm; }
int Repro::armStatic = 3;
#endif
int Repro::fn () const
    {
#ifdef __aarch64__
        return onlyArm;
#else
        return always;
#endif
    }
#ifndef _WIN32
int posixOnly ()
                 { return 1; }
#endif /* _WIN32 */
#undef LZZ_INLINE
