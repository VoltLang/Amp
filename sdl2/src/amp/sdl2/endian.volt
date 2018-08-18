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
 *  Functions for reading and writing endian-specific values
 */
module amp.sdl2.endian;
extern (C):

import amp.sdl2.stdinc;

/*!
 * The two types of endianness
 * @{
 */
enum SDL_LIL_ENDIAN  = 1234;
enum SDL_BIG_ENDIAN  = 4321;
/*! @} */

enum SDL_BYTEORDER = SDL_LIL_ENDIAN;


fn SDL_Swap16(x: Uint16) Uint16
{
	return cast(Uint16)((x << 8) | (x >> 8));
}

fn SDL_Swap32(x: Uint32) Uint32
{
	return cast(Uint32)((x << 24) | ((x << 8) & 0x00FF0000) | ((x >> 8) & 0x0000FF00) | (x >> 24));
}


fn SDL_Swap64(x: Uint64) Uint64
{
	hi, lo: Uint32;

	/* Separate into high and low 32-bit values and swap them */
	lo = cast(Uint32)(x & 0xFFFFFFFF);
	x >>= 32;
	hi = cast(Uint32)(x & 0xFFFFFFFF);
	x = SDL_Swap32(lo);
	x <<= 32;
	x |= SDL_Swap32(hi);
	return x;
}

private union Swapper
{
	f: f32;
	ui32: Uint32;
}

fn SDL_SwapFloat(x: f32) f32
{
	swapper: Swapper;
	swapper.f = x;
	swapper.ui32 = SDL_Swap32(swapper.ui32);
	return swapper.f;
}

/*
 *  Swap to native  
 *  Byteswap item from the specified endianness to the native endianness.
 */
fn SDL_SwapLE16(x: u16) u16 { return x; }
fn SDL_SwapLE32(x: u32) u32 { return x; }
fn SDL_SwapLE64(x: u64) u64 { return x; }
fn SDL_SwapFloatLE(x: f32) f32 { return x; }
fn SDL_SwapBE16(x: u16) u16 { return SDL_Swap16(x); }
fn SDL_SwapBE32(x: u32) u32 { return SDL_Swap32(x); }
fn SDL_SwapBE64(x: u64) u64 { return SDL_Swap64(x); }
fn SDL_SwapFloatBE(x: f32) f32 { return SDL_SwapFloat(x); }
