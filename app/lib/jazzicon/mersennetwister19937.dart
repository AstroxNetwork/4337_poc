class MersenneTwister19937
{
  /* Period parameters */
  //c//#define N 624
  //c//#define M 397
  //c//#define MATRIX_A 0x9908b0dfUL   /* constant vector a */
  //c//#define UPPER_MASK 0x80000000UL /* most significant w-r bits */
  //c//#define LOWER_MASK 0x7fffffffUL /* least significant r bits */
  static final int  N = 624;
  static final int M = 397;
  static final int MATRIX_A = 0x9908b0df;   /* constant vector a */
  static final int UPPER_MASK = 0x80000000; /* most significant w-r bits */
  static final int LOWER_MASK = 0x7fffffff; /* least significant r bits */
  //c//static unsigned long mt[N]; /* the array for the state vector  */
  //c//static int mti=N+1; /* mti==N+1 means mt[N] is not initialized */
  late List<int> mt; // = new List<num>(N);   /* the array for the state vector  */
  var mti; // = N+1;           /* mti==N+1 means mt[N] is not initialized */

  MersenneTwister19937() {
    mt = List.filled(N, 0);
    mti = N+1;
  }

  static unsigned32 (int n1) // returns a 32-bits unsiged integer from an operand to which applied a bit operator.
  {
    return n1 < 0 ? (n1 ^ UPPER_MASK) + UPPER_MASK : n1;
  }

  subtraction32 (int n1, int n2) // emulates lowerflow of a c 32-bits unsiged integer variable, instead of the operator -. these both arguments must be non-negative integers expressible using unsigned 32 bits.
  {
    return n1 < n2 ? unsigned32((0x100000000 - (n2 - n1)) & 0xffffffff) : n1 - n2;
  }

  addition32 (int n1, int n2) // emulates overflow of a c 32-bits unsiged integer variable, instead of the operator +. these both arguments must be non-negative integers expressible using unsigned 32 bits.
  {
    return unsigned32((n1 + n2) & 0xffffffff);
  }

  multiplication32 (int n1, int n2) // emulates overflow of a c 32-bits unsiged integer variable, instead of the operator *. these both arguments must be non-negative integers expressible using unsigned 32 bits.
  {
    var sum = 0;
    for (var i = 0; i < 32; ++i){
      if (((n1 >> i) & 0x1) > 0){
        sum = addition32(sum, unsigned32(n2 << i));
      }
    }
    return sum;
  }

  /* initializes mt[N] with a seed */
  //c//void init_genrand(unsigned long s)
  init_genrand(int? s)
  {
    s = s ?? DateTime
        .now()
        .millisecond;

    //c//mt[0]= s & 0xffffffff;
    mt[0]= unsigned32(s & 0xffffffff);
    for (mti=1; mti<N; mti++) {
      mt[mti] =
      //c//(1812433253 * (mt[mti-1] ^ (mt[mti-1] >> 30)) + mti);
      addition32(multiplication32(1812433253, unsigned32(mt[mti-1] ^ (mt[mti-1] >> 30))), mti);
      /* See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier. */
      /* In the previous versions, MSBs of the seed affect   */
      /* only MSBs of the array mt[].                        */
      /* 2002/01/09 modified by Makoto Matsumoto             */
      //c//mt[mti] &= 0xffffffff;
      mt[mti] = unsigned32(mt[mti] & 0xffffffff);
      // print("init_seed  index=$mti  ${mt[mti]}");
      /* for >32 bit machines */
    }
  }

  /* initialize by an array with array-length */
  /* init_key is the array for initializing keys */
  /* key_length is its length */
  /* slight change for C++, 2004/2/26 */
  //c//void init_by_array(unsigned long init_key[], int key_length)
  init_by_array(var init_key, var key_length)
  {
    //c//int i, j, k;
    var i, j, k;
    //c//init_genrand(19650218);
    this.init_genrand(19650218);
    i=1; j=0;
    k = (N>key_length ? N : key_length);
    for (; k; k--) {
      //c//mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >> 30)) * 1664525))
      //c// + init_key[j] + j; /* non linear */
      mt[i] = addition32(addition32(unsigned32(mt[i] ^ multiplication32(unsigned32(mt[i-1] ^ (mt[i-1] >> 30)), 1664525)), init_key[j]), j);
      mt[i] =
      //c//mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
      unsigned32(mt[i] & 0xffffffff);
      i++; j++;
      if (i>=N) { mt[0] = mt[N-1]; i=1; }
      if (j>=key_length) j=0;
    }
    for (k=N-1; k; k--) {
      //c//mt[i] = (mt[i] ^ ((mt[i-1] ^ (mt[i-1] >> 30)) * 1566083941))
      //c//- i; /* non linear */
      var dbg = mt[i];
      mt[i] = subtraction32(unsigned32(mt[i] ^ multiplication32(unsigned32(mt[i-1] ^ (mt[i-1] >> 30)), 1566083941)), i);
      //c//mt[i] &= 0xffffffff; /* for WORDSIZE > 32 machines */
      mt[i] = unsigned32(mt[i] & 0xffffffff);
      i++;
      if (i>=N) { mt[0] = mt[N-1]; i=1; }
    }
    mt[0] = 0x80000000; /* MSB is 1; assuring non-zero initial array */
  }

  /* generates a random number on [0,0xffffffff]-interval */
  //c//unsigned long genrand_int32(void)
  genrand_int32()
  {
    //c//unsigned long y;
    //c//static unsigned long mag01[2]={0x0UL, MATRIX_A};
    var y;
    List<int> mag01 = [];  //= new Array(0x0, MATRIX_A);
    mag01.add(0x0);
    mag01.add(MATRIX_A);
    /* mag01[x] = x * MATRIX_A  for x=0,1 */

    if (mti >= N) { /* generate N words at one time */
      //c//int kk;
      var kk;

      if (mti == N+1)   /* if init_genrand() has not been called, */
        //c//init_genrand(5489); /* a default initial seed is used */
        this.init_genrand(5489); /* a default initial seed is used */

      for (kk=0;kk<N-M;kk++) {
        //c//y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
        //c//mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
        y = unsigned32((mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK));
        mt[kk] = unsigned32(mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1]);
      }
      for (;kk<N-1;kk++) {
        //c//y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
        //c//mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
        y = unsigned32((mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK));
        mt[kk] = unsigned32(mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1]);
      }
      //c//y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK);
      //c//mt[N-1] = mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1];
      y = unsigned32((mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK));
      mt[N-1] = unsigned32(mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1]);
      mti = 0;
    }

    y = mt[mti++];

    /* Tempering */
    //c//y ^= (y >> 11);
    //c//y ^= (y << 7) & 0x9d2c5680;
    //c//y ^= (y << 15) & 0xefc60000;
    //c//y ^= (y >> 18);
    y = unsigned32(y ^ (y >> 11));
    y = unsigned32(y ^ ((y << 7) & 0x9d2c5680));
    y = unsigned32(y ^ ((y << 15) & 0xefc60000));
    y = unsigned32(y ^ (y >> 18));

    return y;
  }

  /* generates a random number on [0,0x7fffffff]-interval */
  //c//long genrand_int31(void)
  genrand_int31()
  {
    //c//return (genrand_int32()>>1);
    return (this.genrand_int32()>>1);
  }

  /* generates a random number on [0,1]-real-interval */
  //c//double genrand_real1(void)
  genrand_real1()
  {
    //c//return genrand_int32()*(1.0/4294967295.0);
    return this.genrand_int32()*(1.0/4294967295.0);
    /* divided by 2^32-1 */
  }

  /* generates a random number on [0,1)-real-interval */
  //c//double genrand_real2(void)
  genrand_real2()
  {
    //c//return genrand_int32()*(1.0/4294967296.0);
    return this.genrand_int32()*(1.0/4294967296.0);
    /* divided by 2^32 */
  }

  /* generates a random number on (0,1)-real-interval */
  //c//double genrand_real3(void)
  genrand_real3()
  {
    //c//return ((genrand_int32()) + 0.5)*(1.0/4294967296.0);
    return ((this.genrand_int32()) + 0.5)*(1.0/4294967296.0);
    /* divided by 2^32 */
  }

  /* generates a random number on [0,1) with 53-bit resolution*/
  //c//double genrand_res53(void)
  genrand_res53()
  {
    //c//unsigned long a=genrand_int32()>>5, b=genrand_int32()>>6;
    var a=this.genrand_int32()>>5, b=this.genrand_int32()>>6;
    return(a*67108864.0+b)*(1.0/9007199254740992.0);
  }
/* These real versions are due to Isaku Wada, 2002/01/09 added */

  double random() {
    return this.genrand_int32()*(1.0/4294967296.0);
    /* divided by 2^32 */
  }
}
