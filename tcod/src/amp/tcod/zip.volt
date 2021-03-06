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
module amp.tcod.zip;
extern(C):

import amp.tcod.console;
import amp.tcod.color;
import amp.tcod.image;

alias TCOD_zip_t = void*;

 TCOD_zip_t TCOD_zip_new();
 void TCOD_zip_delete(TCOD_zip_t zip);

// output interface
 void TCOD_zip_put_char(TCOD_zip_t zip, char val);
 void TCOD_zip_put_int(TCOD_zip_t zip, int val);
 void TCOD_zip_put_float(TCOD_zip_t zip, float val);
 void TCOD_zip_put_string(TCOD_zip_t zip, const char *val);
 void TCOD_zip_put_color(TCOD_zip_t zip, const TCOD_color_t val);
 void TCOD_zip_put_image(TCOD_zip_t zip, const TCOD_image_t val);
 void TCOD_zip_put_console(TCOD_zip_t zip, const TCOD_console_t val);
 void TCOD_zip_put_data(TCOD_zip_t zip, int nbBytes, const void *data);
 int TCOD_zip_save_to_file(TCOD_zip_t zip, const char *filename);
uint TCOD_zip_get_current_bytes(TCOD_zip_t zip);

// input interface
 int TCOD_zip_load_from_file(TCOD_zip_t zip, const char *filename);
 char TCOD_zip_get_char(TCOD_zip_t zip);
 int TCOD_zip_get_int(TCOD_zip_t zip);
 float TCOD_zip_get_float(TCOD_zip_t zip);
 const char *TCOD_zip_get_string(TCOD_zip_t zip);
 TCOD_color_t TCOD_zip_get_color(TCOD_zip_t zip);
 TCOD_image_t TCOD_zip_get_image(TCOD_zip_t zip);
 TCOD_console_t TCOD_zip_get_console(TCOD_zip_t zip);
 int TCOD_zip_get_data(TCOD_zip_t zip, int nbBytes, void *data);
uint TCOD_zip_get_remaining_bytes(TCOD_zip_t zip);
void TCOD_zip_skip_bytes(TCOD_zip_t zip, uint nbBytes);

