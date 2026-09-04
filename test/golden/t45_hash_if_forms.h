// t45_hash_if_forms.h
//

#ifndef LZZ_t45_hash_if_forms_h
#define LZZ_t45_hash_if_forms_h
#define LZZ_INLINE inline
int known ();
int known2 ();
template <typename T>
class Tmpl
{
public:
#ifdef ARCH_X
  T x ();
#endif
  T y ();
};
class Outer
{
public:
  class Inner
  {
#ifdef ARCH_X
    int a;
#endif
    int b;
  };
#ifdef ARCH_X
  Inner in;
#endif
};
#ifdef ARCH_X
extern "C"
{
  int cfn (int);
}
#endif
#if defined (ARCH_X)
int chain ();
#elif defined (ARCH_Y)
int chain ();
#else
int chain ();
#endif
#ifdef ARCH_X
template <typename T>
T Tmpl <T>::x ()
           { return T (); }
#endif
template <typename T>
T Tmpl <T>::y ()
           { return T (); }
#undef LZZ_INLINE
#endif
