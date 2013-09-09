/*
* libtcod 1.5.0
* Copyright (c) 2008,2009,2010 Jice
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * The name of Jice may not be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY Jice ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL Jice BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
module amp.tcod.wrappers;
extern(C):

import amp.tcod.tcod;
import amp.tcod.console;
import amp.tcod.image;
import amp.tcod.mouse;
import amp.tcod.parser;

// wrappers to ease other languages integration
alias colornum_t = uint;

// color module
bool TCOD_color_equals_wrapper (colornum_t c1, colornum_t c2);
colornum_t TCOD_color_add_wrapper (colornum_t c1,
						 colornum_t c2);
colornum_t TCOD_color_subtract_wrapper (colornum_t c1,
						 colornum_t c2);
colornum_t TCOD_color_multiply_wrapper (colornum_t c1,
						      colornum_t c2);
colornum_t TCOD_color_multiply_scalar_wrapper (colornum_t c1,
							     float value);
colornum_t TCOD_color_lerp_wrapper(colornum_t c1,
						 colornum_t c2, float coef);
void TCOD_color_get_HSV_wrapper(colornum_t c,float * h,
					    float * s, float * v);

// console module
/* void TCOD_console_set_custom_font_wrapper(const char *fontFile, 
                        int char_width, int char_height, int nb_char_horiz, 
                        int nb_char_vertic, bool chars_by_row, 
                        colornum_t key_color); */

void TCOD_console_set_background_color_wrapper(TCOD_console_t con,
						   colornum_t col);
void TCOD_console_set_foreground_color_wrapper(TCOD_console_t con,
						   colornum_t col);
colornum_t TCOD_console_get_background_color_wrapper(TCOD_console_t con);
colornum_t TCOD_console_get_foreground_color_wrapper(TCOD_console_t con);
colornum_t TCOD_console_get_back_wrapper(TCOD_console_t con,
						       int x, int y);
void TCOD_console_set_back_wrapper(TCOD_console_t con,int x, int y,
                                      colornum_t col,
                                      TCOD_bkgnd_flag_t flag);
colornum_t TCOD_console_get_fore_wrapper (TCOD_console_t con,
                                              int x, int y);
void TCOD_console_set_fore_wrapper(TCOD_console_t con,int x, int y,
                                      colornum_t col);
void TCOD_console_put_char_ex_wrapper(TCOD_console_t con, int x, 
	int y, int c, colornum_t fore, colornum_t back);
void TCOD_console_set_fade_wrapper(uint8 val, colornum_t fade);
colornum_t TCOD_console_get_fading_color_wrapper();
void TCOD_console_set_color_control_wrapper(TCOD_colctrl_t con,
						colornum_t fore,
						colornum_t back);
bool TCOD_console_check_for_keypress_wrapper(TCOD_key_t *holder,
							 int flags);
void TCOD_console_wait_for_keypress_wrapper(TCOD_key_t *holder,
							bool flush);
void TCOD_console_fill_background(TCOD_console_t con, int *r, int *g, int *b);
void TCOD_console_fill_foreground(TCOD_console_t con, int *r, int *g, int *b);

void TCOD_console_double_hline(TCOD_console_t con,int x,int y, int l,
					   TCOD_bkgnd_flag_t flag);
void TCOD_console_double_vline(TCOD_console_t con,int x,int y,
					   int l, TCOD_bkgnd_flag_t flag);
void TCOD_console_print_double_frame(TCOD_console_t con,int x,int y,
						 int w,int h, bool empty,
						 TCOD_bkgnd_flag_t flag,
						 const char *fmt, ...);

char *TCOD_console_print_return_string(TCOD_console_t con,int x,
						   int y, int rw, int rh,
						   TCOD_bkgnd_flag_t flag,
						   uint _align, char *msg,
						   bool can_split,
						   bool count_only);


// image module

void TCOD_image_clear_wrapper(TCOD_image_t image,
					  colornum_t color);
colornum_t TCOD_image_get_pixel_wrapper(TCOD_image_t image,
						      int x, int y);
colornum_t TCOD_image_get_mipmap_pixel_wrapper(TCOD_image_t image,
				 float x0,float y0, float x1, float y1);
void TCOD_image_put_pixel_wrapper(TCOD_image_t image,int x, int y,
				      colornum_t col);
void TCOD_image_set_key_color_wrapper(TCOD_image_t image,
					  colornum_t key_color);

// mouse module
void TCOD_mouse_get_status_wrapper(TCOD_mouse_t *holder);

// parser module
colornum_t TCOD_parser_get_color_property_wrapper(TCOD_parser_t parser, const char *name);

// namegen module
int TCOD_namegen_get_nb_sets_wrapper();
void TCOD_namegen_get_sets_wrapper(char **sets);


