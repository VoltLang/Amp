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
module amp.tcod.color;
extern (C):

struct TCOD_color_t {
	ushort r,g,b;
}
	
TCOD_color_t TCOD_color_RGB(ubyte r, ubyte g, ubyte b);
TCOD_color_t TCOD_color_HSV(float h, float s, float v);
bool TCOD_color_equals (TCOD_color_t c1, TCOD_color_t c2);
TCOD_color_t TCOD_color_add (TCOD_color_t c1, TCOD_color_t c2);
TCOD_color_t TCOD_color_subtract (TCOD_color_t c1, TCOD_color_t c2);
TCOD_color_t TCOD_color_multiply (TCOD_color_t c1, TCOD_color_t c2);
TCOD_color_t TCOD_color_multiply_scalar (TCOD_color_t c1, float value);
TCOD_color_t TCOD_color_lerp(TCOD_color_t c1, TCOD_color_t c2, float coef);
void TCOD_color_set_HSV(TCOD_color_t *c,float h, float s, float v);
void TCOD_color_get_HSV(TCOD_color_t c,float * h, float * s, float * v);
 float TCOD_color_get_hue (TCOD_color_t c);
 void TCOD_color_set_hue (TCOD_color_t *c, float h);
 float TCOD_color_get_saturation (TCOD_color_t c);
 void TCOD_color_set_saturation (TCOD_color_t *c, float s);
 float TCOD_color_get_value (TCOD_color_t c);
 void TCOD_color_set_value (TCOD_color_t *c, float v);
 void TCOD_color_shift_hue (TCOD_color_t *c, float hshift);
 void TCOD_color_scale_HSV (TCOD_color_t *c, float scoef, float vcoef);
void TCOD_color_gen_map(TCOD_color_t *map, int nb_key, TCOD_color_t *key_color, int *key_index);

// color names
enum {
	TCOD_COLOR_RED,
	TCOD_COLOR_FLAME,
	TCOD_COLOR_ORANGE,
	TCOD_COLOR_AMBER,
	TCOD_COLOR_YELLOW,
	TCOD_COLOR_LIME,
	TCOD_COLOR_CHARTREUSE,
	TCOD_COLOR_GREEN,
	TCOD_COLOR_SEA,
	TCOD_COLOR_TURQUOISE,
	TCOD_COLOR_CYAN,
	TCOD_COLOR_SKY,
	TCOD_COLOR_AZURE,
	TCOD_COLOR_BLUE,
	TCOD_COLOR_HAN,
	TCOD_COLOR_VIOLET,
	TCOD_COLOR_PURPLE,
	TCOD_COLOR_FUCHSIA,
	TCOD_COLOR_MAGENTA,
	TCOD_COLOR_PINK,
	TCOD_COLOR_CRIMSON,
	TCOD_COLOR_NB,
}

// color levels
enum {
	TCOD_COLOR_DESATURATED,
	TCOD_COLOR_LIGHTEST,
	TCOD_COLOR_LIGHTER,
	TCOD_COLOR_LIGHT,
	TCOD_COLOR_NORMAL,
	TCOD_COLOR_DARK,
	TCOD_COLOR_DARKER,
	TCOD_COLOR_DARKEST,
	TCOD_COLOR_LEVELS,
}

// color array
//extern global TCOD_color_t[TCOD_COLOR_NB][TCOD_COLOR_LEVELS]  TCOD_colors;

/* grey levels */
extern global TCOD_color_t TCOD_black;
extern global TCOD_color_t TCOD_darkest_grey;
extern global TCOD_color_t TCOD_darker_grey;
extern global TCOD_color_t TCOD_dark_grey;
extern global TCOD_color_t TCOD_grey;
extern global TCOD_color_t TCOD_light_grey;
extern global TCOD_color_t TCOD_lighter_grey;
extern global TCOD_color_t TCOD_lightest_grey;
extern global TCOD_color_t TCOD_darkest_gray;
extern global TCOD_color_t TCOD_darker_gray;
extern global TCOD_color_t TCOD_dark_gray;
extern global TCOD_color_t TCOD_gray;
extern global TCOD_color_t TCOD_light_gray;
extern global TCOD_color_t TCOD_lighter_gray;
extern global TCOD_color_t TCOD_lightest_gray;
extern global TCOD_color_t TCOD_white;

/* sepia */
extern global TCOD_color_t TCOD_darkest_sepia;
extern global TCOD_color_t TCOD_darker_sepia;
extern global TCOD_color_t TCOD_dark_sepia;
extern global TCOD_color_t TCOD_sepia;
extern global TCOD_color_t TCOD_light_sepia;
extern global TCOD_color_t TCOD_lighter_sepia;
extern global TCOD_color_t TCOD_lightest_sepia;

/* standard colors */
extern global TCOD_color_t TCOD_red;
extern global TCOD_color_t TCOD_flame;
extern global TCOD_color_t TCOD_orange;
extern global TCOD_color_t TCOD_amber;
extern global TCOD_color_t TCOD_yellow;
extern global TCOD_color_t TCOD_lime;
extern global TCOD_color_t TCOD_chartreuse;
extern global TCOD_color_t TCOD_green;
extern global TCOD_color_t TCOD_sea;
extern global TCOD_color_t TCOD_turquoise;
extern global TCOD_color_t TCOD_cyan;
extern global TCOD_color_t TCOD_sky;
extern global TCOD_color_t TCOD_azure;
extern global TCOD_color_t TCOD_blue;
extern global TCOD_color_t TCOD_han;
extern global TCOD_color_t TCOD_violet;
extern global TCOD_color_t TCOD_purple;
extern global TCOD_color_t TCOD_fuchsia;
extern global TCOD_color_t TCOD_magenta;
extern global TCOD_color_t TCOD_pink;
extern global TCOD_color_t TCOD_crimson;

/* dark colors */
extern global TCOD_color_t TCOD_dark_red;
extern global TCOD_color_t TCOD_dark_flame;
extern global TCOD_color_t TCOD_dark_orange;
extern global TCOD_color_t TCOD_dark_amber;
extern global TCOD_color_t TCOD_dark_yellow;
extern global TCOD_color_t TCOD_dark_lime;
extern global TCOD_color_t TCOD_dark_chartreuse;
extern global TCOD_color_t TCOD_dark_green;
extern global TCOD_color_t TCOD_dark_sea;
extern global TCOD_color_t TCOD_dark_turquoise;
extern global TCOD_color_t TCOD_dark_cyan;
extern global TCOD_color_t TCOD_dark_sky;
extern global TCOD_color_t TCOD_dark_azure;
extern global TCOD_color_t TCOD_dark_blue;
extern global TCOD_color_t TCOD_dark_han;
extern global TCOD_color_t TCOD_dark_violet;
extern global TCOD_color_t TCOD_dark_purple;
extern global TCOD_color_t TCOD_dark_fuchsia;
extern global TCOD_color_t TCOD_dark_magenta;
extern global TCOD_color_t TCOD_dark_pink;
extern global TCOD_color_t TCOD_dark_crimson;

/* darker colors */
extern global TCOD_color_t TCOD_darker_red;
extern global TCOD_color_t TCOD_darker_flame;
extern global TCOD_color_t TCOD_darker_orange;
extern global TCOD_color_t TCOD_darker_amber;
extern global TCOD_color_t TCOD_darker_yellow;
extern global TCOD_color_t TCOD_darker_lime;
extern global TCOD_color_t TCOD_darker_chartreuse;
extern global TCOD_color_t TCOD_darker_green;
extern global TCOD_color_t TCOD_darker_sea;
extern global TCOD_color_t TCOD_darker_turquoise;
extern global TCOD_color_t TCOD_darker_cyan;
extern global TCOD_color_t TCOD_darker_sky;
extern global TCOD_color_t TCOD_darker_azure;
extern global TCOD_color_t TCOD_darker_blue;
extern global TCOD_color_t TCOD_darker_han;
extern global TCOD_color_t TCOD_darker_violet;
extern global TCOD_color_t TCOD_darker_purple;
extern global TCOD_color_t TCOD_darker_fuchsia;
extern global TCOD_color_t TCOD_darker_magenta;
extern global TCOD_color_t TCOD_darker_pink;
extern global TCOD_color_t TCOD_darker_crimson;

/* darkest colors */
extern global TCOD_color_t TCOD_darkest_red;
extern global TCOD_color_t TCOD_darkest_flame;
extern global TCOD_color_t TCOD_darkest_orange;
extern global TCOD_color_t TCOD_darkest_amber;
extern global TCOD_color_t TCOD_darkest_yellow;
extern global TCOD_color_t TCOD_darkest_lime;
extern global TCOD_color_t TCOD_darkest_chartreuse;
extern global TCOD_color_t TCOD_darkest_green;
extern global TCOD_color_t TCOD_darkest_sea;
extern global TCOD_color_t TCOD_darkest_turquoise;
extern global TCOD_color_t TCOD_darkest_cyan;
extern global TCOD_color_t TCOD_darkest_sky;
extern global TCOD_color_t TCOD_darkest_azure;
extern global TCOD_color_t TCOD_darkest_blue;
extern global TCOD_color_t TCOD_darkest_han;
extern global TCOD_color_t TCOD_darkest_violet;
extern global TCOD_color_t TCOD_darkest_purple;
extern global TCOD_color_t TCOD_darkest_fuchsia;
extern global TCOD_color_t TCOD_darkest_magenta;
extern global TCOD_color_t TCOD_darkest_pink;
extern global TCOD_color_t TCOD_darkest_crimson;

/* light colors */
extern global TCOD_color_t TCOD_light_red;
extern global TCOD_color_t TCOD_light_flame;
extern global TCOD_color_t TCOD_light_orange;
extern global TCOD_color_t TCOD_light_amber;
extern global TCOD_color_t TCOD_light_yellow;
extern global TCOD_color_t TCOD_light_lime;
extern global TCOD_color_t TCOD_light_chartreuse;
extern global TCOD_color_t TCOD_light_green;
extern global TCOD_color_t TCOD_light_sea;
extern global TCOD_color_t TCOD_light_turquoise;
extern global TCOD_color_t TCOD_light_cyan;
extern global TCOD_color_t TCOD_light_sky;
extern global TCOD_color_t TCOD_light_azure;
extern global TCOD_color_t TCOD_light_blue;
extern global TCOD_color_t TCOD_light_han;
extern global TCOD_color_t TCOD_light_violet;
extern global TCOD_color_t TCOD_light_purple;
extern global TCOD_color_t TCOD_light_fuchsia;
extern global TCOD_color_t TCOD_light_magenta;
extern global TCOD_color_t TCOD_light_pink;
extern global TCOD_color_t TCOD_light_crimson;

/* lighter colors */
extern global TCOD_color_t TCOD_lighter_red;
extern global TCOD_color_t TCOD_lighter_flame;
extern global TCOD_color_t TCOD_lighter_orange;
extern global TCOD_color_t TCOD_lighter_amber;
extern global TCOD_color_t TCOD_lighter_yellow;
extern global TCOD_color_t TCOD_lighter_lime;
extern global TCOD_color_t TCOD_lighter_chartreuse;
extern global TCOD_color_t TCOD_lighter_green;
extern global TCOD_color_t TCOD_lighter_sea;
extern global TCOD_color_t TCOD_lighter_turquoise;
extern global TCOD_color_t TCOD_lighter_cyan;
extern global TCOD_color_t TCOD_lighter_sky;
extern global TCOD_color_t TCOD_lighter_azure;
extern global TCOD_color_t TCOD_lighter_blue;
extern global TCOD_color_t TCOD_lighter_han;
extern global TCOD_color_t TCOD_lighter_violet;
extern global TCOD_color_t TCOD_lighter_purple;
extern global TCOD_color_t TCOD_lighter_fuchsia;
extern global TCOD_color_t TCOD_lighter_magenta;
extern global TCOD_color_t TCOD_lighter_pink;
extern global TCOD_color_t TCOD_lighter_crimson;

/* lightest colors */
extern global TCOD_color_t TCOD_lightest_red;
extern global TCOD_color_t TCOD_lightest_flame;
extern global TCOD_color_t TCOD_lightest_orange;
extern global TCOD_color_t TCOD_lightest_amber;
extern global TCOD_color_t TCOD_lightest_yellow;
extern global TCOD_color_t TCOD_lightest_lime;
extern global TCOD_color_t TCOD_lightest_chartreuse;
extern global TCOD_color_t TCOD_lightest_green;
extern global TCOD_color_t TCOD_lightest_sea;
extern global TCOD_color_t TCOD_lightest_turquoise;
extern global TCOD_color_t TCOD_lightest_cyan;
extern global TCOD_color_t TCOD_lightest_sky;
extern global TCOD_color_t TCOD_lightest_azure;
extern global TCOD_color_t TCOD_lightest_blue;
extern global TCOD_color_t TCOD_lightest_han;
extern global TCOD_color_t TCOD_lightest_violet;
extern global TCOD_color_t TCOD_lightest_purple;
extern global TCOD_color_t TCOD_lightest_fuchsia;
extern global TCOD_color_t TCOD_lightest_magenta;
extern global TCOD_color_t TCOD_lightest_pink;
extern global TCOD_color_t TCOD_lightest_crimson;

/* desaturated */
extern global TCOD_color_t TCOD_desaturated_red;
extern global TCOD_color_t TCOD_desaturated_flame;
extern global TCOD_color_t TCOD_desaturated_orange;
extern global TCOD_color_t TCOD_desaturated_amber;
extern global TCOD_color_t TCOD_desaturated_yellow;
extern global TCOD_color_t TCOD_desaturated_lime;
extern global TCOD_color_t TCOD_desaturated_chartreuse;
extern global TCOD_color_t TCOD_desaturated_green;
extern global TCOD_color_t TCOD_desaturated_sea;
extern global TCOD_color_t TCOD_desaturated_turquoise;
extern global TCOD_color_t TCOD_desaturated_cyan;
extern global TCOD_color_t TCOD_desaturated_sky;
extern global TCOD_color_t TCOD_desaturated_azure;
extern global TCOD_color_t TCOD_desaturated_blue;
extern global TCOD_color_t TCOD_desaturated_han;
extern global TCOD_color_t TCOD_desaturated_violet;
extern global TCOD_color_t TCOD_desaturated_purple;
extern global TCOD_color_t TCOD_desaturated_fuchsia;
extern global TCOD_color_t TCOD_desaturated_magenta;
extern global TCOD_color_t TCOD_desaturated_pink;
extern global TCOD_color_t TCOD_desaturated_crimson;

/* metallic */
extern global TCOD_color_t TCOD_brass;
extern global TCOD_color_t TCOD_copper;
extern global TCOD_color_t TCOD_gold;
extern global TCOD_color_t TCOD_silver;

/* miscellaneous */
extern global TCOD_color_t TCOD_celadon;
extern global TCOD_color_t TCOD_peach;

