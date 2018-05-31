module amp.tcod.txtfield;
extern(C):

import amp.tcod.console;
import amp.tcod.console_types;
import amp.tcod.color;

alias TCOD_text_t = void*;

TCOD_text_t TCOD_text_init (int x, int y, int w, int h, int max_chars);
void TCOD_text_set_properties (TCOD_text_t txt, int cursor_char, int blink_interval, char * prompt, int tab_size);
void TCOD_text_set_colors (TCOD_text_t txt, TCOD_color_t fore, TCOD_color_t back, float back_transparency);
bool TCOD_text_update (TCOD_text_t txt, TCOD_key_t key);
void TCOD_text_render (TCOD_text_t txt, TCOD_console_t con);
const (char)* TCOD_text_get (TCOD_text_t txt);
void TCOD_text_reset (TCOD_text_t txt);
void TCOD_text_delete (TCOD_text_t txt);

