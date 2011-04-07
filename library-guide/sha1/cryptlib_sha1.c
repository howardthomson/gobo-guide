#include <stdlib.h>
#include <string.h>
#include "cryptlib.h"








#ifdef SHA1_SUM
/*
 * Reads a single ASCII file and prints the HEX sha1 sum.
 */

#define BUF_SIZE (1024*1024)

char buf [BUF_SIZE];
#include <stdio.h>
int main(int argc, char *argv[])
{
	CRYPT_CONTEXT hash_context;
	int cryptUser = CRYPT_UNUSED;
	int cr;
	
	FILE *fd;
	char signature[ CRYPT_MAX_HASHSIZE ];
	int signature_length;
	int i;
	size_t n;
	char *s;

	printf ("CRYPT_MAX_HASHSIZE = %d\n", CRYPT_MAX_HASHSIZE);
	
	if (argc < 1) {
		printf("Must have filename\n");
		exit(1);
	}
	fd = fopen(argv[1], "rb");
	if (!fd) {
		printf("Could not open %s\n", argv[1]);
		exit(1);
	}
	cr = cryptInit();
	if (cr != 0) printf("Crypt return = %d\n", cr);
	cr = cryptCreateContext (&hash_context, cryptUser, CRYPT_ALGO_SHA1);
	if (cr != 0) printf("Crypt return = %d\n", cr);
#if 1	
	while((n = fread (buf, 1, BUF_SIZE, fd)) != 0) {	
		cr = cryptEncrypt (hash_context, buf, n);
		if (cr != 0) printf("Crypt return = %d\n", cr);
	}
#else
#if 0
	s = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq";
#else
	s = "abc";
#endif
	cr = cryptEncrypt (hash_context, s, strlen(s));
	if (cr != 0) printf("Crypt return = %d\n", cr);
#endif
	cr = cryptEncrypt (hash_context, buf, 0);
	if (cr != 0) printf("Crypt return = %d\n", cr);
	cr = cryptGetAttributeString (hash_context, CRYPT_CTXINFO_HASHVALUE, signature, &signature_length);
	if (cr != 0) printf("Crypt return = %d\n", cr);

	printf ("signature_length = %d\n", signature_length);
	
	for (i=0; i < signature_length; i++) {
		printf("%02x", signature[i]& 0xFF);
	}
	printf("  %s\n", argv[1]);
	fclose(fd);
	cryptEnd();
}
#endif
