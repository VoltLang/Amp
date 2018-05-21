module amp.tilengine.c.tilengine;
extern (C):

enum TILENGINE_VER_MAJ = 1;
enum TILENGINE_VER_MIN = 21;
enum TILENGINE_VER_REV = 1;
enum TILENGINE_VER_HEADER_VERSION =
	((TILENGINE_VER_MAJ << 16) | (TILENGINE_VER_MIN << 8) | TILENGINE_VER_REV);

alias TLN_TileFlags = i32;
enum : TLN_TileFlags
{
	FLAG_NONE = 0,
	FLAG_FLIPX = 1 << 15,
	FLAG_FLIPY = 1 << 14,
	FLAG_ROTATE = 1 << 13,
	FLAG_PRIORITY = 1 << 12,
}

alias fix_t = i32;
enum FIXED_BITS = 16;
fn float2fix(f: f32) fix_t
{
	return cast(fix_t)(f * (1 << FIXED_BITS));
}
fn int2fix(i: i32) fix_t
{
	return i << FIXED_BITS;
}
fn fix2int(f: fix_t) i32
{
	return f >> FIXED_BITS;
}
fn fix2float(f: fix_t) f32
{
	return cast(f32)f / (1 << FIXED_BITS);
}

alias TLN_Blend = i32;
enum : TLN_Blend
{
	BLEND_NONE,		/*!< blending disabled */
	BLEND_MIX25,	/*!< color averaging 1 */
	BLEND_MIX50,	/*!< color averaging 2 */
	BLEND_MIX75,	/*!< color averaging 3 */
	BLEND_ADD,		/*!< color is always brighter (simulate light effects) */
	BLEND_SUB,		/*!< color is always darker (simulate shadow effects) */
	BLEND_MOD,		/*!< color is always darker (simulate shadow effects) */
	BLEND_CUSTOM,	/*!< user provided blend function */
	MAX_BLEND,
	BLEND_MIX = BLEND_MIX50
}

struct TLN_Affine
{
	angle, dx, dy, sx, sy: f32;
}

struct Tile
{
	index, flags: u16;
}

struct TLN_SequenceFrame
{
	index, delay: i32;
}

struct TLN_ColorStrip
{
	delay: i32;
	first, count, dir: u8;
}

struct TLN_SequenceInfo
{
	name: char[32];
	num_frames: i32;
}

struct TLN_SpriteData
{
	name: char[64];
	x, y, w, h: i32;
}

struct TLN_SpriteInfo
{
	w, h: i32;
}

struct TLN_TileInfo
{
	index, flags: u16;
	row, col, xoffset, yoffset: i32;
	color, type: u8;
	empty: bool;
}

struct TLN_TileAttributes
{
	type: u8;
	priority: bool;
}

alias TLN_Overlay = i32;
enum : TLN_Overlay
{
	TLN_OVERLAY_NONE,		/*!< no overlay */
	TLN_OVERLAY_SHADOWMASK,	/*!< Shadow mask pattern */
	TLN_OVERLAY_APERTURE,	/*!< Aperture grille pattern */
	TLN_OVERLAY_SCANLINES,	/*!< Scanlines pattern */
	TLN_OVERLAY_CUSTOM,		/*!< User- when calling TLN_CreateWindow() */
	TLN_MAX_OVERLAY
}

struct TLN_PixelMap
{
	dx, dy: i16;
}

alias TLN_Tile = Tile*;
alias TLN_Tileset = void*;
alias TLN_Tilemap = void*;
alias TLN_Palette = void*;
alias TLN_Spriteset = void*;
alias TLN_Sequence = void*;
alias TLN_SequencePack = void*;
alias TLN_Bitmap = void*;

alias TLN_Player = i32;
enum : TLN_Player
{
	PLAYER1,	/*!< Player 1 */
	PLAYER2,	/*!< Player 2 */
	PLAYER3,	/*!< Player 3 */
	PLAYER4,	/*!< Player 4 */
}

struct SDL_Event {}
alias TLN_VideoCallback = fn!C(scanline: i32);
alias TLN_SDLCallback = fn!C(event: SDL_Event*);

alias TLN_Input = i32;
enum : TLN_Input
{
	INPUT_NONE,		/*!< no input */
	INPUT_UP,		/*!< up direction */
	INPUT_DOWN,		/*!< down direction */
	INPUT_LEFT,		/*!< left direction */
	INPUT_RIGHT,	/*!< right direction */
	INPUT_BUTTON1,	/*!< 1st action button */
	INPUT_BUTTON2,	/*!< 2nd action button */
	INPUT_BUTTON3,	/*!< 3th action button */
	INPUT_BUTTON4,	/*!< 4th action button */
	INPUT_BUTTON5,	/*!< 5th action button */
	INPUT_BUTTON6,	/*!< 6th action button */
	INPUT_START,	/*!< Start button */

	INPUT_P1 = (PLAYER1 << 4), 	/*!< request player 1 input (default) */
	INPUT_P2 = (PLAYER2 << 4),	/*!< request player 2 input */
	INPUT_P3 = (PLAYER3 << 4),	/*!< request player 3 input */
	INPUT_P4 = (PLAYER4 << 4),	/*!< request player 4 input */
	
	/* compatibility symbols for pre-1.18 input model */ 
	INPUT_A = INPUT_BUTTON1,
	INPUT_B = INPUT_BUTTON2,
	INPUT_C = INPUT_BUTTON3,
	INPUT_D = INPUT_BUTTON4,
	INPUT_E = INPUT_BUTTON5,
	INPUT_F = INPUT_BUTTON6,	
}

alias TLN_WindowFlags = i32;
enum : i32
{
	CWF_FULLSCREEN	=	(1<<0),	/*!< create a  window */
	CWF_VSYNC		=	(1<<1),	/*!< sync frame  with vertical retrace */
	CWF_S1			=	(1<<2),	/*!< create a  the  size as the framebuffer */
	CWF_S2			=	(2<<2),	/*!< create a  2x the size the framebuffer */
	CWF_S3			=	(3<<2),	/*!< create a  3x the size the framebuffer */
	CWF_S4			=	(4<<2),	/*!< create a  4x the size the framebuffer */
	CWF_S5			=	(5<<2),	/*!< create a  5x the size the framebuffer */
	CWF_NEAREST		=   (1<<6),	/*<! unfiltered upscaling */
}

alias TLN_Error = i32;
enum : TLN_Error
{
	TLN_ERR_OK,				/*!< No error */
	TLN_ERR_OUT_OF_MEMORY,	/*!< Not enough memory */
	TLN_ERR_IDX_LAYER,		/*!< Layer index out of range */
	TLN_ERR_IDX_SPRITE,		/*!< Sprite index out of range */
	TLN_ERR_IDX_ANIMATION,	/*!< Animation index out of range */
	TLN_ERR_IDX_PICTURE,	/*!< Picture or tile index out of range */
	TLN_ERR_REF_TILESET,	/*!< Invalid TLN_Tileset reference */
	TLN_ERR_REF_TILEMAP,	/*!< Invalid TLN_Tilemap reference */
	TLN_ERR_REF_SPRITESET,	/*!< Invalid TLN_Spriteset reference */
	TLN_ERR_REF_PALETTE,	/*!< Invalid TLN_Palette reference */
	TLN_ERR_REF_SEQUENCE,	/*!< Invalid TLN_Sequence reference */
	TLN_ERR_REF_SEQPACK,	/*!< Invalid TLN_SequencePack reference */
	TLN_ERR_REF_BITMAP,		/*!< Invalid TLN_Bitmap reference */
	TLN_ERR_NULL_POINTER,	/*!< Null pointer as argument */ 
	TLN_ERR_FILE_NOT_FOUND,	/*!< Resource file not found */
	TLN_ERR_WRONG_FORMAT,	/*!< Resource file has invalid format */
	TLN_ERR_WRONG_SIZE,		/*!< A width or height parameter is invalid */
	TLN_ERR_UNSUPPORTED,	/*!< Unsupported function */
	TLN_MAX_ERR,
}


/** 
 * \anchor group_setup
 * \name Setup
 * Basic setup and management */
/**@{*/
fn TLN_Init (hres: i32, vres: i32, numlayers: i32, numsprites: i32, numanimations: i32) bool;
fn TLN_InitBPP (hres: i32, vres: i32, bpp: i32, numlayers: i32, numsprites: i32, numanimations: i32) bool;
fn TLN_Deinit ();
fn TLN_GetWidth () i32;
fn TLN_GetHeight () i32;
fn TLN_GetBPP () i32;
fn TLN_GetNumObjects () u32;
fn TLN_GetUsedMemory () u32;
fn TLN_GetVersion () u32;
fn TLN_GetNumLayers () i32;
fn TLN_GetNumSprites () i32;
fn TLN_SetBGColor (r: u8, g: u8, b: u8);
fn TLN_SetBGColorFromTilemap (tilemap: TLN_Tilemap) bool;
fn TLN_DisableBGColor ();
fn TLN_SetBGBitmap (bitmap: TLN_Bitmap) bool;
fn TLN_SetBGPalette (palette: TLN_Palette) bool;
fn TLN_SetRasterCallback (callback: TLN_VideoCallback);
fn TLN_SetFrameCallback (callback: TLN_VideoCallback);
fn TLN_SetRenderTarget (data: u8*, pitch: i32);
fn TLN_UpdateFrame (time: i32);
fn TLN_BeginFrame (time: i32);
fn TLN_DrawNextScanline () bool;
fn TLN_SetLoadPath (path: const(char)*);
fn TLN_SetCustomBlendFunction (blend_function: fn!C(u8, u8) u8);

/**@}*/

/** 
 * \anchor group_errors
 * \name Errors
 * Error handling */
/**@{*/
fn TLN_SetLastError (error: TLN_Error);
fn TLN_GetLastError () TLN_Error;
fn TLN_GetErrorString (error: TLN_Error) const(char)*;
/**@}*/

/** 
 * \anchor group_windowing
 * \name Windowing
 * Built-in window and input management */
/**@{*/
fn TLN_CreateWindow (overlay: const(char)*, flags: TLN_WindowFlags) bool;
fn TLN_CreateWindowThread (overlay: const(char)*, flags: TLN_WindowFlags) bool;
fn TLN_SetWindowTitle (title: const(char)*);
fn TLN_ProcessWindow () bool;
fn TLN_IsWindowActive () bool;
fn TLN_GetInput (id: TLN_Input) bool;
fn TLN_EnableInput (player: TLN_Player, enable: bool);
fn TLN_AssignInputJoystick (player: TLN_Player, index: i32);
fn TLN_DefineInputKey (player: TLN_Player, input: TLN_Input, keycode: u32);
fn TLN_DefineInputButton (player: TLN_Player, input: TLN_Input, joybutton: u8);
fn TLN_DrawFrame (time: i32);
fn TLN_WaitRedraw ();
fn TLN_DeleteWindow ();
fn TLN_EnableBlur (mode: bool);
fn TLN_EnableCRTEffect (overlay: TLN_Overlay, overlay_factor: u8, threshold: u8, v0: u8, v1: u8, v2: u8, v3: u8, blur: bool, glow_factor: u8);
fn TLN_DisableCRTEffect ();
fn TLN_SetSDLCallback (TLN_SDLCallback);
fn TLN_Delay (msecs: u32);
fn TLN_GetTicks () u32;
fn TLN_BeginWindowFrame (time: i32);
fn TLN_EndWindowFrame ();

/**@}*/

/** 
 * \anchor group_spriteset
 * \name Spritesets
 * Spriteset resources management for sprites */
/**@{*/
fn TLN_CreateSpriteset (bitmap: TLN_Bitmap, data: TLN_SpriteData*, num_entries: i32) TLN_Spriteset;
fn TLN_LoadSpriteset (name: const(char)*) TLN_Spriteset;
fn TLN_CloneSpriteset (src: TLN_Spriteset) TLN_Spriteset;
fn TLN_GetSpriteInfo (spriteset: TLN_Spriteset, entry: i32, info: TLN_SpriteInfo*) bool;
fn TLN_GetSpritesetPalette (spriteset: TLN_Spriteset) TLN_Palette;
fn TLN_FindSpritesetSprite (spriteset: TLN_Spriteset, name: const(char)*) i32;
fn TLN_SetSpritesetData (spriteset: TLN_Spriteset, entry: i32, data: TLN_SpriteData*, pixels: void*, pitch: i32) bool;
fn TLN_DeleteSpriteset (spriteset: TLN_Spriteset) bool;
/**@}*/

/** 
 * \anchor group_tileset
 * \name Tilesets
 * Tileset resources management for background layers */
/**@{*/
fn TLN_CreateTileset (numtiles: i32, width: i32, height: i32, palette: TLN_Palette, sp: TLN_SequencePack, attributes: TLN_TileAttributes*) TLN_Tileset;
fn TLN_LoadTileset (filename: const(char)*) TLN_Tileset;
fn TLN_CloneTileset (src: TLN_Tileset) TLN_Tileset;
fn TLN_SetTilesetPixels (tileset: TLN_Tileset, entry: i32, srcdata: u8*, srcpitch: i32) bool;
fn TLN_CopyTile (tileset: TLN_Tileset, src: i32, dst: i32) bool;
fn TLN_GetTileWidth (tileset: TLN_Tileset) i32;
fn TLN_GetTileHeight (tileset: TLN_Tileset) i32;
fn TLN_GetTilesetPalette (tileset: TLN_Tileset) TLN_Palette;
fn TLN_GetTilesetSequencePack (tileset: TLN_Tileset) TLN_SequencePack;
fn TLN_DeleteTileset (tileset: TLN_Tileset) bool;
/**@}*/

/** 
 * \anchor group_tilemap
 * \name Tilemaps 
 * Tilemap resources management for background layers */
/**@{*/
fn TLN_CreateTilemap (rows: i32, cols: i32, tiles: TLN_Tile, bgcolor: u32, tileset: TLN_Tileset) TLN_Tilemap;
fn TLN_LoadTilemap (filename: const(char)*, layername: const(char)*) TLN_Tilemap;
fn TLN_CloneTilemap (src: TLN_Tilemap) TLN_Tilemap;
fn TLN_GetTilemapRows (tilemap: TLN_Tilemap) i32;
fn TLN_GetTilemapCols (tilemap: TLN_Tilemap) i32;
fn TLN_GetTilemapTileset (tilemap: TLN_Tilemap) TLN_Tileset;
fn TLN_GetTilemapTile (tilemap: TLN_Tilemap, row: i32, col: i32, tile: TLN_Tile) bool;
fn TLN_SetTilemapTile (tilemap: TLN_Tilemap, row: i32, col: i32, tile: TLN_Tile) bool;
fn TLN_CopyTiles (src: TLN_Tilemap, srcrow: i32, srccol: i32, rows: i32, cols: i32, dst: TLN_Tilemap, dstrow: i32, dstcol: i32) bool;
fn TLN_DeleteTilemap (tilemap: TLN_Tilemap) bool;
/**@}*/

/** 
 * \anchor group_palette
 * \name Palettes
 * Color palette resources management for sprites and background layers */
/**@{*/
fn TLN_CreatePalette (entries: i32) TLN_Palette;
fn TLN_LoadPalette (filename: const(char)*) TLN_Palette;
fn TLN_ClonePalette (src: TLN_Palette) TLN_Palette;
fn TLN_SetPaletteColor (palette: TLN_Palette, color: i32, r: u8, g: u8, b: u8) bool;
fn TLN_MixPalettes (src1: TLN_Palette, src2: TLN_Palette, dst: TLN_Palette, factor: u8) bool;
fn TLN_AddPaletteColor (palette: TLN_Palette, r: u8, g: u8, b: u8, start: u8, num: u8) bool;
fn TLN_SubPaletteColor (palette: TLN_Palette, r: u8, g: u8, b: u8, start: u8, num: u8) bool;
fn TLN_ModPaletteColor (palette: TLN_Palette, r: u8, g: u8, b: u8, start: u8, num: u8) bool;
fn TLN_GetPaletteData (palette: TLN_Palette, index: i32) u8*;
fn TLN_DeletePalette (palette: TLN_Palette) bool;
/**@}*/

/** 
 * \anchor group_bitmap
 * \name Bitmaps 
 * Bitmap management */
/**@{*/
fn TLN_CreateBitmap (width: i32, height: i32, bpp: i32) TLN_Bitmap;
fn TLN_LoadBitmap (filename: const(char)*) TLN_Bitmap;
fn TLN_CloneBitmap (src: TLN_Bitmap) TLN_Bitmap;
fn TLN_GetBitmapPtr (bitmap: TLN_Bitmap, x: i32, y: i32) u8*;
fn TLN_GetBitmapWidth (bitmap: TLN_Bitmap) i32;
fn TLN_GetBitmapHeight (bitmap: TLN_Bitmap) i32;
fn TLN_GetBitmapDepth (bitmap: TLN_Bitmap) i32;
fn TLN_GetBitmapPitch (bitmap: TLN_Bitmap) i32;
fn TLN_GetBitmapPalette (bitmap: TLN_Bitmap) TLN_Palette;
fn TLN_SetBitmapPalette (bitmap: TLN_Bitmap, palette: TLN_Palette) bool;
fn TLN_DeleteBitmap (bitmap: TLN_Bitmap) bool;
/**@}*/

/** 
 * \anchor group_layer
 * \name Layers
 * Background layers management */
/**@{*/
fn TLN_SetLayer (nlayer: i32, tileset: TLN_Tileset, tilemap: TLN_Tilemap) bool;
fn TLN_SetLayerBitmap (nlayer: i32, bitmap: TLN_Bitmap) bool;
fn TLN_SetLayerPalette (nlayer: i32, palette: TLN_Palette) bool;
fn TLN_SetLayerPosition (nlayer: i32, hstart: i32, vstart: i32) bool;
fn TLN_SetLayerScaling (nlayer: i32, xfactor: f32, yfactor: f32) bool;
fn TLN_SetLayerAffineTransform (nlayer: i32, affine: TLN_Affine*) bool;
fn TLN_SetLayerTransform (layer: i32, angle: f32, dx: f32, dy: f32, sx: f32, sy: f32) bool;
fn TLN_SetLayerPixelMapping (nlayer: i32, table: TLN_PixelMap*) bool;
fn TLN_SetLayerBlendMode (nlayer: i32, mode: TLN_Blend, factor: u8) bool;
fn TLN_SetLayerColumnOffset (nlayer: i32, offset: i32*) bool;
fn TLN_SetLayerClip (nlayer: i32, x1: i32, y1: i32, x2: i32, y2: i32) bool;
fn TLN_DisableLayerClip (nlayer: i32) bool;
fn TLN_SetLayerMosaic (nlayer: i32, width: i32, height: i32) bool;
fn TLN_DisableLayerMosaic (nlayer: i32) bool;
fn TLN_ResetLayerMode (nlayer: i32) bool;
fn TLN_DisableLayer (nlayer: i32) bool;
fn TLN_GetLayerPalette (nlayer: i32) TLN_Palette;
fn TLN_GetLayerTile (nlayer: i32, x: i32, y: i32, info: TLN_TileInfo*) bool;
fn TLN_GetLayerWidth (nlayer: i32) i32;
fn TLN_GetLayerHeight (nlayer: i32) i32;

/**@}*/

/** 
 * \anchor group_sprite
 * \name Sprites 
 * Sprites management */
/**@{*/
fn TLN_ConfigSprite (nsprite: i32, spriteset: TLN_Spriteset, flags: TLN_TileFlags) bool;
fn TLN_SetSpriteSet (nsprite: i32, spriteset: TLN_Spriteset) bool;
fn TLN_SetSpriteFlags (nsprite: i32, flags: TLN_TileFlags) bool;
fn TLN_SetSpritePosition (nsprite: i32, x: i32, y: i32) bool;
fn TLN_SetSpritePicture (nsprite: i32, entry: i32) bool;
fn TLN_SetSpritePalette (nsprite: i32, palette: TLN_Palette) bool;
fn TLN_SetSpriteBlendMode (nsprite: i32, mode: TLN_Blend, factor: u8) bool;
fn TLN_SetSpriteScaling (nsprite: i32, sx: f32, sy: f32) bool;
fn TLN_ResetSpriteScaling (nsprite: i32) bool;
//fn TLN_SetSpriteRotation(nsprite: i32, angle: f32) bool;
//fn TLN_ResetSpriteRotation(nsprite: i32) bool;
fn TLN_GetSpritePicture (nsprite: i32) i32;
fn TLN_GetAvailableSprite () i32;
fn TLN_EnableSpriteCollision (nsprite: i32, enable: bool) bool;
fn TLN_GetSpriteCollision (nsprite: i32)  bool;
fn TLN_DisableSprite (nsprite: i32) bool;
fn TLN_GetSpritePalette (nsprite: i32) TLN_Palette;
/**@}*/

/** 
 * \anchor group_sequence
 * \name Sequences
 * Sequence resources management for layer, sprite and palette animations */
/**@{*/
fn TLN_CreateSequence (name: const(char)*, target: i32, num_frames: i32, frames: TLN_SequenceFrame*) TLN_Sequence;
fn TLN_CreateCycle (name: const(char)*, num_strips: i32, strips: TLN_ColorStrip*) TLN_Sequence;
fn TLN_CloneSequence (src: TLN_Sequence) TLN_Sequence;
fn TLN_GetSequenceInfo (sequence: TLN_Sequence, info: TLN_SequenceInfo*) bool;
fn TLN_DeleteSequence (sequence: TLN_Sequence) bool;
/**@}*/

/** 
 * \anchor group_sequencepack
 * \name Sequence packs
 * Sequence pack manager for grouping and finding sequences */
/**@{*/
fn TLN_CreateSequencePack () TLN_SequencePack;
fn TLN_LoadSequencePack (filename: const(char)*) TLN_SequencePack;
fn TLN_CloneSequencePack (src: TLN_SequencePack) TLN_SequencePack;
fn TLN_GetSequence (sp: TLN_SequencePack, index: i32) TLN_Sequence;
fn TLN_FindSequence (sp: TLN_SequencePack, name: const(char)*) TLN_Sequence;
fn TLN_GetSequencePackCount (sp: TLN_SequencePack) i32;
fn TLN_AddSequenceToPack (sp: TLN_SequencePack, sequence: TLN_Sequence) bool;
fn TLN_DeleteSequencePack (sp: TLN_SequencePack) bool;
/**@}*/

/** 
 * \anchor group_animation
 * \name Animations 
 * Animation engine manager */
/**@{*/
fn TLN_SetPaletteAnimation (index: i32, palette: TLN_Palette, sequence: TLN_Sequence, blend: bool) bool;
fn TLN_SetPaletteAnimationSource (index: i32, TLN_Palette) bool;
fn TLN_SetTilesetAnimation (index: i32, nlayer: i32, TLN_Sequence) bool;
fn TLN_SetTilemapAnimation (index: i32, nlayer: i32, TLN_Sequence) bool;
fn TLN_SetSpriteAnimation (index: i32, nsprite: i32, sequence: TLN_Sequence, loop: i32) bool;
fn TLN_GetAnimationState (index: i32) bool;
fn TLN_SetAnimationDelay (index: i32, delay: i32) bool;
fn TLN_GetAvailableAnimation () i32;
fn TLN_DisableAnimation (index: i32) bool;
/**@}*/