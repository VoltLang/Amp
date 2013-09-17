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
module amp.tcod.sys;
extern (C):

import amp.tcod;

uint TCOD_sys_elapsed_milli();
float TCOD_sys_elapsed_seconds();
void TCOD_sys_sleep_milli(uint val);
void TCOD_sys_save_screenshot(const char *filename);
void TCOD_sys_force_fullscreen_resolution(int width, int height);
void TCOD_sys_set_renderer(TCOD_renderer_t renderer);
TCOD_renderer_t TCOD_sys_get_renderer();
void TCOD_sys_set_fps(int val);
int TCOD_sys_get_fps();
float TCOD_sys_get_last_frame_length();
void TCOD_sys_get_current_resolution(int *w, int *h);
void TCOD_sys_get_fullscreen_offsets(int *offx, int *offy);
void TCOD_sys_update_char(int asciiCode, int fontx, int fonty, TCOD_image_t img, int x, int y);
void TCOD_sys_get_char_size(int *w, int *h);
void *TCOD_sys_get_sdl_window();

alias TCOD_event_t = int;
enum {
  TCOD_EVENT_KEY_PRESS=1,
  TCOD_EVENT_KEY_RELEASE=2,
  TCOD_EVENT_KEY=TCOD_EVENT_KEY_PRESS|TCOD_EVENT_KEY_RELEASE,
  TCOD_EVENT_MOUSE_MOVE=4,
  TCOD_EVENT_MOUSE_PRESS=8,
  TCOD_EVENT_MOUSE_RELEASE=16,
  TCOD_EVENT_MOUSE=TCOD_EVENT_MOUSE_MOVE|TCOD_EVENT_MOUSE_PRESS|TCOD_EVENT_MOUSE_RELEASE,
  TCOD_EVENT_ANY=TCOD_EVENT_KEY|TCOD_EVENT_MOUSE,
}
TCOD_event_t TCOD_sys_wait_for_event(int eventMask, TCOD_key_t *key, TCOD_mouse_t *mouse, bool flush);
TCOD_event_t TCOD_sys_check_for_event(int eventMask, TCOD_key_t *key, TCOD_mouse_t *mouse);

/* filesystem stuff */
bool TCOD_sys_create_directory(const char *path);
bool TCOD_sys_delete_file(const char *path);
bool TCOD_sys_delete_directory(const char *path);
bool TCOD_sys_is_directory(const char *path);
TCOD_list_t TCOD_sys_get_directory_content(const char *path, const char *pattern);
bool TCOD_sys_file_exists(const char * filename, ...);
bool TCOD_sys_read_file(const char *filename,  char **buf, uint *size);
bool TCOD_sys_write_file(const char *filename,  char *buf, uint size);

/* clipboard */
void TCOD_sys_clipboard_set(const char *value);
char *TCOD_sys_clipboard_get();

/* thread stuff */
alias TCOD_thread_t = void*;
alias TCOD_semaphore_t = void*;
alias TCOD_mutex_t = void*;	
alias TCOD_cond_t = void*;
/* threads */
TCOD_thread_t TCOD_thread_new(int function(void*), void*);
void TCOD_thread_delete(TCOD_thread_t th);
int TCOD_sys_get_num_cores();
void TCOD_thread_wait(TCOD_thread_t th);
/* mutex */
TCOD_mutex_t TCOD_mutex_new();
void TCOD_mutex_in(TCOD_mutex_t mut);
void TCOD_mutex_out(TCOD_mutex_t mut);
void TCOD_mutex_delete(TCOD_mutex_t mut);
/* semaphore */
TCOD_semaphore_t TCOD_semaphore_new(int initVal);
void TCOD_semaphore_lock(TCOD_semaphore_t sem);
void TCOD_semaphore_unlock(TCOD_semaphore_t sem);
void TCOD_semaphore_delete( TCOD_semaphore_t sem);
/* condition */
TCOD_cond_t TCOD_condition_new();
void TCOD_condition_signal(TCOD_cond_t sem);
void TCOD_condition_broadcast(TCOD_cond_t sem);
void TCOD_condition_wait(TCOD_cond_t sem, TCOD_mutex_t mut);
void TCOD_condition_delete( TCOD_cond_t sem);
/* dynamic library */
alias TCOD_library_t = void*;
TCOD_library_t TCOD_load_library(const char *path);
void * TCOD_get_function_address(TCOD_library_t library, const char *function_name);
void TCOD_close_library(TCOD_library_t);
/* SDL renderer callback */
alias SDL_renderer_t = void function(void*);
void TCOD_sys_register_SDL_renderer(SDL_renderer_t renderer);

