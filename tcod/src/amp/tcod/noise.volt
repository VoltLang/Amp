/*
* libtcod 1.5.1
* Copyright (c) 2008,2009,2010,2012 Jice & Mingos
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * The name of Jice or Mingos may not be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY JICE AND MINGOS ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL JICE OR MINGOS BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
module amp.tcod.noise;
extern (C):

alias TCOD_noise_t = void*;

alias TCOD_noise_type_t = int;
enum {
	TCOD_NOISE_PERLIN = 1,
	TCOD_NOISE_SIMPLEX = 2,
	TCOD_NOISE_WAVELET = 4,
	TCOD_NOISE_DEFAULT = 0
}

import amp.tcod;

/* create a new noise object */
TCOD_noise_t TCOD_noise_new(int dimensions, float hurst, float lacunarity, TCOD_random_t random);

/* simplified API */
void TCOD_noise_set_type (TCOD_noise_t noise, TCOD_noise_type_t type);
float TCOD_noise_get_ex (TCOD_noise_t noise, float *f, TCOD_noise_type_t type);
float TCOD_noise_get_fbm_ex (TCOD_noise_t noise, float *f, float octaves, TCOD_noise_type_t type);
float TCOD_noise_get_turbulence_ex (TCOD_noise_t noise, float *f, float octaves, TCOD_noise_type_t type);
float TCOD_noise_get (TCOD_noise_t noise, float *f);
float TCOD_noise_get_fbm (TCOD_noise_t noise, float *f, float octaves);
float TCOD_noise_get_turbulence (TCOD_noise_t noise, float *f, float octaves);
/* delete the noise object */
void TCOD_noise_delete(TCOD_noise_t noise);

