#include <bits/types/struct_timeval.h>
#include <sys/select.h>
#include <cstdint>
#include  <stdio.h>

#include <time.h>
#include <sys/time.h>
  uint64_t NowMicros() {
    timeval tv;
    gettimeofday(&tv, nullptr);
    printf("seconds: %lu\n", static_cast<uint64_t>(tv.tv_sec));
    return static_cast<uint64_t>(tv.tv_sec) * 1000000 + tv.tv_usec;
  }

  uint64_t NowNanos()  {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    printf("seconds: %lu\n", static_cast<uint64_t>(ts.tv_sec));
    return (static_cast<uint64_t>(ts.tv_sec) * 1000000000) + ts.tv_nsec;

  }



int main() {
  uint64_t micros = NowMicros();
  uint64_t nanos = NowNanos();
  uint64_t micro_nanos =  micros * 1000;

  printf("%lu\n%lu\n%lu\n", micros, nanos, micro_nanos);

  return 0;
}



