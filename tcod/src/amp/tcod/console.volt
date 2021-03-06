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
module amp.tcod.console;
extern (C):

import amp.tcod.console_types;
import amp.tcod.color;
import amp.tcod.tcod;

alias TCOD_console_t = void*;

void TCOD_console_init_root(int w, int h, const char * title, bool fullscreen, TCOD_renderer_t renderer);
void TCOD_console_set_window_title(const char *title);
void TCOD_console_set_fullscreen(bool fullscreen);
bool TCOD_console_is_fullscreen();
bool TCOD_console_is_window_closed();

void TCOD_console_set_custom_font(const char *fontFile, int flags,int nb_char_horiz, int nb_char_vertic);
void TCOD_console_map_ascii_code_to_font(int asciiCode, int fontCharX, int fontCharY);
void TCOD_console_map_ascii_codes_to_font(int asciiCode, int nbCodes, int fontCharX, int fontCharY);
void TCOD_console_map_string_to_font(const char *s, int fontCharX, int fontCharY);

void TCOD_console_set_dirty(int x, int y, int w, int h);
void TCOD_console_set_default_background(TCOD_console_t con,TCOD_color_t col);
void TCOD_console_set_default_foreground(TCOD_console_t con,TCOD_color_t col);
void TCOD_console_clear(TCOD_console_t con);
void TCOD_console_set_char_background(TCOD_console_t con,int x, int y, TCOD_color_t col, TCOD_bkgnd_flag_t flag);
void TCOD_console_set_char_foreground(TCOD_console_t con,int x, int y, TCOD_color_t col);
void TCOD_console_set_char(TCOD_console_t con,int x, int y, int c);
void TCOD_console_put_char(TCOD_console_t con,int x, int y, int c, TCOD_bkgnd_flag_t flag);
void TCOD_console_put_char_ex(TCOD_console_t con,int x, int y, int c, TCOD_color_t fore, TCOD_color_t back);

void TCOD_console_set_background_flag(TCOD_console_t con,TCOD_bkgnd_flag_t flag);
TCOD_bkgnd_flag_t TCOD_console_get_background_flag(TCOD_console_t con);
void TCOD_console_set_alignment(TCOD_console_t con,TCOD_alignment_t alignment);
TCOD_alignment_t TCOD_console_get_alignment(TCOD_console_t con);
void TCOD_console_print(TCOD_console_t con,int x, int y, const char *fmt, ...);
void TCOD_console_print_ex(TCOD_console_t con,int x, int y, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const char *fmt, ...);
int TCOD_console_print_rect(TCOD_console_t con,int x, int y, int w, int h, const char *fmt, ...);
int TCOD_console_print_rect_ex(TCOD_console_t con,int x, int y, int w, int h, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const char *fmt, ...);
int TCOD_console_get_height_rect(TCOD_console_t con,int x, int y, int w, int h, const char *fmt, ...);

void TCOD_console_rect(TCOD_console_t con,int x, int y, int w, int h, bool clear, TCOD_bkgnd_flag_t flag);
void TCOD_console_hline(TCOD_console_t con,int x,int y, int l, TCOD_bkgnd_flag_t flag);
void TCOD_console_vline(TCOD_console_t con,int x,int y, int l, TCOD_bkgnd_flag_t flag);
void TCOD_console_print_frame(TCOD_console_t con,int x,int y,int w,int h, bool empty, TCOD_bkgnd_flag_t flag, const char *fmt, ...);

void TCOD_console_map_string_to_font_utf(const wchar *s, int fontCharX, int fontCharY);
void TCOD_console_print_utf(TCOD_console_t con,int x, int y, const wchar *fmt, ...);
void TCOD_console_print_ex_utf(TCOD_console_t con,int x, int y, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const wchar *fmt, ...);
int TCOD_console_print_rect_utf(TCOD_console_t con,int x, int y, int w, int h, const wchar *fmt, ...);
int TCOD_console_print_rect_ex_utf(TCOD_console_t con,int x, int y, int w, int h, TCOD_bkgnd_flag_t flag, TCOD_alignment_t alignment, const wchar *fmt, ...);
int TCOD_console_get_height_rect_utf(TCOD_console_t con,int x, int y, int w, int h, const wchar *fmt, ...);

TCOD_color_t TCOD_console_get_default_background(TCOD_console_t con);
TCOD_color_t TCOD_console_get_default_foreground(TCOD_console_t con);
TCOD_color_t TCOD_console_get_char_background(TCOD_console_t con,int x, int y);
TCOD_color_t TCOD_console_get_char_foreground(TCOD_console_t con,int x, int y);
int TCOD_console_get_char(TCOD_console_t con,int x, int y);

void TCOD_console_set_fade(uint8 val, TCOD_color_t fade);
uint8 TCOD_console_get_fade();
TCOD_color_t TCOD_console_get_fading_color();

void TCOD_console_flush();

void TCOD_console_set_color_control(TCOD_colctrl_t con, TCOD_color_t fore, TCOD_color_t back);

TCOD_key_t TCOD_console_check_for_keypress(int flags);
TCOD_key_t TCOD_console_wait_for_keypress(bool flush);
void TCOD_console_set_keyboard_repeat(int initial_delay, int interval);
void TCOD_console_disable_keyboard_repeat();
bool TCOD_console_is_key_pressed(TCOD_keycode_t key);

/* ASCII paint file support */
TCOD_console_t TCOD_console_from_file(const char *filename);
bool TCOD_console_load_asc(TCOD_console_t con, const char *filename);
bool TCOD_console_load_apf(TCOD_console_t con, const char *filename);
bool TCOD_console_save_asc(TCOD_console_t con, const char *filename);
bool TCOD_console_save_apf(TCOD_console_t con, const char *filename);

TCOD_console_t TCOD_console_new(int w, int h);
int TCOD_console_get_width(TCOD_console_t con);
int TCOD_console_get_height(TCOD_console_t con);
void TCOD_console_set_key_color(TCOD_console_t con,TCOD_color_t col);
void TCOD_console_blit(TCOD_console_t src,int xSrc, int ySrc, int wSrc, int hSrc, TCOD_console_t dst, int xDst, int yDst, float foreground_alpha, float background_alpha);
void TCOD_console_delete(TCOD_console_t console);

void TCOD_console_credits();
void TCOD_console_credits_reset();
bool TCOD_console_credits_render(int x, int y, bool alpha);

