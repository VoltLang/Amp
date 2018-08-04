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
module amp.sdl2.gamecontroller;
extern (C):

/*
 *  \file SDL_gamecontroller.h
 *
 *  Include file for SDL game controller event handling
 */

import amp.sdl2.stdinc;
import amp.sdl2.error;
import amp.sdl2.joystick;

/**
 *  \file SDL_gamecontroller.h
 *
 *  In order to use these functions, SDL_Init() must have been called
 *  with the ::SDL_INIT_JOYSTICK flag.  This causes SDL to scan the system
 *  for game controllers, and load appropriate drivers.
 *
 *  If you would like to receive controller updates while the application
 *  is in the background, you should set the following hint before calling
 *  SDL_Init(): SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS
 */

/* The gamecontroller structure used to identify an SDL game controller */
struct SDL_GameController {}

alias SDL_GameControllerBindType = int;
enum : SDL_GameControllerBindType
{
    SDL_CONTROLLER_BINDTYPE_NONE = 0,
    SDL_CONTROLLER_BINDTYPE_BUTTON,
    SDL_CONTROLLER_BINDTYPE_AXIS,
    SDL_CONTROLLER_BINDTYPE_HAT
}

/**
 *  Get the SDL joystick layer binding for this controller button/axis mapping
 */
struct SDL_GameControllerButtonBind
{
    SDL_GameControllerBindType bindType;
    union _value
    {
        int button;
        int axis;
        struct _hat {
            int hat;
            int hat_mask;
        } 
        _hat hat;
    }
    _value value;
}


/**
 *  To count the number of game controllers in the system for the following:
 *  int nJoysticks = SDL_NumJoysticks();
 *  int nGameControllers = 0;
 *  for ( int i = 0; i < nJoysticks; i++ ) {
 *      if ( SDL_IsGameController(i) ) {
 *          nGameControllers++;
 *      }
 *  }
 *
 *  Using the SDL_HINT_GAMECONTROLLERCONFIG hint or the SDL_GameControllerAddMapping you can add support for controllers SDL is unaware of or cause an existing controller to have a different binding. The format is:
 *  guid,name,mappings
 *
 *  Where GUID is the string value from SDL_JoystickGetGUIDString(), name is the human readable string for the device and mappings are controller mappings to joystick ones.
 *  Under Windows there is a reserved GUID of "xinput" that covers any XInput devices.
 *  The mapping format for joystick is:
 *      bX - a joystick button, index X
 *      hX.Y - hat X with value Y
 *      aX - axis X of the joystick
 *  Buttons can be used as a controller axis and vice versa.
 *
 *  This string shows an example of a valid mapping for a controller
 *  "341a3608000000000000504944564944,Afterglow PS3 Controller,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftshoulder:b4,rightshoulder:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
 *
 */

/**
 *  Add or update an existing mapping configuration
 *
 * \return 1 if mapping is added, 0 if updated, -1 on error
 */
int  SDL_GameControllerAddMapping( const char* mappingString );


fn SDL_GameControllerNumMappings() i32;

/**
 *  Get the mapping at a particular index.
 *
 *  \return the mapping string.  Must be freed with SDL_free().  Returns NULL if the index is out of range.
 */
fn SDL_GameControllerMappingForIndex(mapping_index: i32) char*;

/**
 *  Get a mapping string for a GUID
 *
 *  \return the mapping string.  Must be freed with SDL_free.  Returns NULL if no mapping is available
 */
fn SDL_GameControllerMappingForGUID( guid: SDL_JoystickGUID ) char*;

/**
 *  Get a mapping string for an open GameController
 *
 *  \return the mapping string.  Must be freed with SDL_free.  Returns NULL if no mapping is available
 */
fn SDL_GameControllerMapping( gamecontroller: SDL_GameController * ) char*;

/**
 *  Is the joystick on this index supported by the game controller interface?
 */
fn SDL_IsGameController(joystick_index: i32) SDL_bool;


/**
 *  Get the implementation dependent name of a game controller.
 *  This can be called before any controllers are opened.
 *  If no name can be found, this function returns NULL.
 */
const char * SDL_GameControllerNameForIndex(int joystick_index);

/**
 *  Open a game controller for use.
 *  The index passed as an argument refers to the N'th game controller on the system.
 *  This index is the value which will identify this controller in future controller
 *  events.
 *
 *  \return A controller identifier, or NULL if an error occurred.
 */
SDL_GameController * SDL_GameControllerOpen(int joystick_index);

/**
 *  Return the name for this currently opened controller
 */
const char * SDL_GameControllerName(SDL_GameController *gamecontroller);

/**
 *  Returns SDL_TRUE if the controller has been opened and currently connected,
 *  or SDL_FALSE if it has not.
 */
SDL_bool  SDL_GameControllerGetAttached(SDL_GameController *gamecontroller);

/**
 *  Get the underlying joystick object used by a controller
 */
SDL_Joystick * SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller);

/**
 *  Enable/disable controller event polling.
 *
 *  If controller events are disabled, you must call SDL_GameControllerUpdate()
 *  yourself and check the state of the controller when you want controller
 *  information.
 *
 *  The state can be one of ::SDL_QUERY, ::SDL_ENABLE or ::SDL_IGNORE.
 */
int  SDL_GameControllerEventState(int state);

/**
 *  Update the current state of the open game controllers.
 *
 *  This is called automatically by the event loop if any game controller
 *  events are enabled.
 */
void  SDL_GameControllerUpdate();


/**
 *  The list of axes available from a controller
 */
alias SDL_GameControllerAxis = int;
enum : SDL_GameControllerAxis
{
    SDL_CONTROLLER_AXIS_INVALID = -1,
    SDL_CONTROLLER_AXIS_LEFTX,
    SDL_CONTROLLER_AXIS_LEFTY,
    SDL_CONTROLLER_AXIS_RIGHTX,
    SDL_CONTROLLER_AXIS_RIGHTY,
    SDL_CONTROLLER_AXIS_TRIGGERLEFT,
    SDL_CONTROLLER_AXIS_TRIGGERRIGHT,
    SDL_CONTROLLER_AXIS_MAX
}

/**
 *  turn this string into a axis mapping
 */
SDL_GameControllerAxis  SDL_GameControllerGetAxisFromString(const char *pchString);

/**
 *  turn this axis enum into a string mapping
 */
const char*  SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis);

/**
 *  Get the SDL joystick layer binding for this controller button mapping
 */
SDL_GameControllerButtonBind 
SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,
                                 SDL_GameControllerAxis axis);

/**
 *  Get the current state of an axis control on a game controller.
 *
 *  The state is a value ranging from -32768 to 32767.
 *
 *  The axis indices start at index 0.
 */
Sint16 
SDL_GameControllerGetAxis(SDL_GameController *gamecontroller,
                          SDL_GameControllerAxis axis);

/**
 *  The list of buttons available from a controller
 */
alias SDL_GameControllerButton = int;
enum : SDL_GameControllerButton
{
    SDL_CONTROLLER_BUTTON_INVALID = -1,
    SDL_CONTROLLER_BUTTON_A,
    SDL_CONTROLLER_BUTTON_B,
    SDL_CONTROLLER_BUTTON_X,
    SDL_CONTROLLER_BUTTON_Y,
    SDL_CONTROLLER_BUTTON_BACK,
    SDL_CONTROLLER_BUTTON_GUIDE,
    SDL_CONTROLLER_BUTTON_START,
    SDL_CONTROLLER_BUTTON_LEFTSTICK,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER,
    SDL_CONTROLLER_BUTTON_DPAD_UP,
    SDL_CONTROLLER_BUTTON_DPAD_DOWN,
    SDL_CONTROLLER_BUTTON_DPAD_LEFT,
    SDL_CONTROLLER_BUTTON_DPAD_RIGHT,
    SDL_CONTROLLER_BUTTON_MAX
}

/**
 *  turn this string into a button mapping
 */
SDL_GameControllerButton  SDL_GameControllerGetButtonFromString(const char *pchString);

/**
 *  turn this button enum into a string mapping
 */
const char*  SDL_GameControllerGetStringForButton(SDL_GameControllerButton button);

/**
 *  Get the SDL joystick layer binding for this controller button mapping
 */
SDL_GameControllerButtonBind 
SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,
                                   SDL_GameControllerButton button);


/**
 *  Get the current state of a button on a game controller.
 *
 *  The button indices start at index 0.
 */
Uint8  SDL_GameControllerGetButton(SDL_GameController *gamecontroller,
                                                          SDL_GameControllerButton button);

/**
 *  Close a controller previously opened with SDL_GameControllerOpen().
 */
void  SDL_GameControllerClose(SDL_GameController *gamecontroller);

/**
 *  Get the USB vendor ID of an opened controller, if available.
 *  If the vendor ID isn't available this function returns 0.
 */
fn SDL_GameControllerGetVendor(gamecontroller: SDL_GameController*) Uint16;

/**
 *  Get the USB product ID of an opened controller, if available.
 *  If the product ID isn't available this function returns 0.
 */
fn SDL_GameControllerGetProduct(gamecontroller: SDL_GameController*) Uint16;

/**
 *  Get the product version of an opened controller, if available.
 *  If the product version isn't available this function returns 0.
 */
fn SDL_GameControllerGetProductVersion(gamecontroller: SDL_GameController*) Uint16;
