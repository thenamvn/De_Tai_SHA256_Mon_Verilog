#include <stdio.h>
#include <stdint.h>
#include <string.h>

// Prototype
void sha256(uint32_t state[8], const uint32_t message[16]);

int main() {
	// Initial SHA-256 hash values
	uint32_t state[8] = {
		0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
		0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
	};

	// Message block: "abc" padded to 512-bit block = 16 * 32-bit words
	uint32_t message[16] = {
		0x61626380, 0x00000000, 0x00000000, 0x00000000, // "abc" + 1 padding bit
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000018  // 24 bits = 3 bytes
	};

	// Compute hash
	sha256(state, message);

	// Print result
	printf("SHA-256(\"abc\") = ");
	for (int i = 0; i < 8; i++) {
		printf("%08x ", state[i]);
	}
	printf("\n");

	return 0;
}
