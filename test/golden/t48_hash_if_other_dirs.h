// t48_hash_if_other_dirs.h
//

#ifndef LZZ_t48_hash_if_other_dirs_h
#define LZZ_t48_hash_if_other_dirs_h
#define LZZ_INLINE inline
#ifdef _WIN32
#warning "building the windows flavor"
class W
{
#error "W is not ready"
  int w;
};
#else
int posix ();
#endif
#undef LZZ_INLINE
#endif
