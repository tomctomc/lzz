// t44_hash_if_members.h
//

#ifndef LZZ_t44_hash_if_members_h
#define LZZ_t44_hash_if_members_h
#include <vector>
#ifdef __aarch64__
#include <arm_neon.h>
#endif
#define LZZ_INLINE inline
class Repro
{
  int always = 1;
#ifdef __aarch64__
  int onlyArm = 2;
  int armFn () const;
  static int armStatic;
  int armInline () const;
#else
  int notArm = 4;
#endif
  int fn () const;
#if defined (FOO_A) && ! defined (FOO_B)
public:
  void aNotB ();
#elif FOO_C > 1
  void c ();
#endif
};
#ifndef _WIN32
int posixOnly ();
namespace ns
{
  int alsoPosix ();
}
#ifdef __GLIBC__
namespace ns
{
  int glibcOnly ();
}
#endif
#endif /* _WIN32 */
#ifdef __aarch64__
LZZ_INLINE int Repro::armInline () const
                                  { return 0; }
#endif
#undef LZZ_INLINE
#endif
