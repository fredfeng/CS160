#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdint.h>

void print_int (int64_t i) {
  printf ("%lld", i);
}

void print_bool (int64_t i) {
  if (i == 0) {
    printf ("false");
  } else {
    printf ("true");
  }
}

void print_ln () {
  printf ("\n");
}

void print_arr(int64_t* arr, int64_t len) {
  assert (len >= 0);
  for (int64_t i = 0; i < len; i++) {
    if (i > 0) {
      printf(" ");
    }
    printf("%lld", arr[i]);
  }
}

int64_t* alloc(int64_t len) {
  assert (len >= 0);
  return calloc((size_t) len, sizeof(int64_t));
}

extern int64_t patina_main();

int main(int argc, char* argv[]) {
  printf ("Output:\n");
  int64_t result = patina_main();
  return result;
}
