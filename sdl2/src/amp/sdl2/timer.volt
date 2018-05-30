/*
  Simple DirectMedia Layer
  Copyright (C) 1997-2013 Sam Lantinga <slouken@libsdl.org>

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
module amp.sdl2.timer;
extern (C):

/*
 *  \file SDL_timer.h
 *
 *  Header for the SDL time management routines.
 */

import amp.sdl2.stdinc;
import amp.sdl2.error;

/**
 * \brief Get the number of milliseconds since the SDL library initialization.
 *
 * \note This value wraps if the program runs for more than ~49 days.
 */
Uint32  SDL_GetTicks();

/**
 * \brief Get the current value of the high resolution counter
 */
Uint64  SDL_GetPerformanceCounter();

/**
 * \brief Get the count per second of the high resolution counter
 */
Uint64  SDL_GetPerformanceFrequency();

/**
 * \brief Wait a specified number of milliseconds before returning.
 */
void  SDL_Delay(Uint32 ms);

/**
 *  Function prototype for the timer callback function.
 *
 *  The callback function is passed the current timer interval and returns
 *  the next timer interval.  If the returned value is the same as the one
 *  passed in, the periodic alarm continues, otherwise a new alarm is
 *  scheduled.  If the callback returns 0, the periodic alarm is cancelled.
 */
alias SDL_TimerCallback = Uint32 function(Uint32, void*);

/**
 * Definition of the timer ID type.
 */
alias SDL_TimerID = int;

/**
 * \brief Add a new timer to the pool of timers already running.
 *
 * \return A timer ID, or NULL when an error occurs.
 */
SDL_TimerID  SDL_AddTimer(Uint32 interval,
                                                 SDL_TimerCallback callback,
                                                 void *param);

/**
 * \brief Remove a timer knowing its ID.
 *
 * \return A boolean value indicating success or failure.
 *
 * \warning It is not safe to remove a timer multiple times.
 */
SDL_bool  SDL_RemoveTimer(SDL_TimerID id);

