/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2018 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/
/*!
 *  Functions for fiddling with bits and bitmasks.
 */
module amp.sdl2.bits;
extern (C):

import amp.sdl2.stdinc;

/**
 *  Get the index of the most significant bit.
 *
 * Result is undefined when called with 0. This operation can also be stated as "count leading zeroes" and
 *  "log base 2".
 *
 *  \return Index of the most significant bit, or -1 if the value is 0.
 */
fn SDL_MostSignificantBitIndex32(x: Uint32) i32
{
	/* Based off of Bit Twiddling Hacks by Sean Eron Anderson
	 * <seander@cs.stanford.edu>, released in the public domain.
	 * http://graphics.stanford.edu/~seander/bithacks.html#IntegerLog
	 */
	b: const u32[] = [0x2U, 0xCU, 0xF0U, 0xFF00U, 0xFFFF0000U];
	S: const i32[] = [1, 2, 4, 8, 16];

	if (x == 0) {
		return -1;
	}

	msbIndex := 0;
	for (i := 4; i >= 0; i--) {
		if (x & b[i]) {
			x >>= cast(u32)S[i];
			msbIndex |= S[i];
		}
	}

	return msbIndex;
}
