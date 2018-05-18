module amp.tilengine.tilengine;

import core.exception;
import watt.conv;
import amp.tilengine.c.tilengine;

/*!
 * Generic Tilengine exception.
 */
class TilengineException : Exception
{
public:
	this(msg: string)
	{
		super(msg);
	}
}

enum WindowFlags
{
	Fullscreen = CWF_FULLSCREEN,
	Vsync = CWF_VSYNC,
	S1 = CWF_S1,
	S2 = CWF_S2,
	S3 = CWF_S3,
	S4 = CWF_S4,
	S5 = CWF_S5,
	Nearest = CWF_NEAREST
}

enum Player
{
	One   = PLAYER1,
	Two   = PLAYER2,
	Three = PLAYER3,
	Four  = PLAYER4
}

enum Input
{
	None            = INPUT_NONE,
	Up              = INPUT_UP,
	Down            = INPUT_DOWN,
	Left            = INPUT_LEFT,
	Right           = INPUT_RIGHT,
	Button1         = INPUT_BUTTON1,
	Button2         = INPUT_BUTTON2,
	Button3         = INPUT_BUTTON3,
	Button4         = INPUT_BUTTON4,
	Button5         = INPUT_BUTTON5,
	Button6         = INPUT_BUTTON6,
	Start           = INPUT_START,

	One             = INPUT_P1,
	Two             = INPUT_P2,
	Three           = INPUT_P3,
	Four            = INPUT_P4,

	A               = INPUT_BUTTON1,
	B               = INPUT_BUTTON2,
	C               = INPUT_BUTTON3,
	D               = INPUT_BUTTON4,
	E               = INPUT_BUTTON5,
	F               = INPUT_BUTTON6
}

enum TileFlags
{
	None     = FLAG_NONE,
	FlipX    = FLAG_FLIPX,
	FlipY    = FLAG_FLIPY,
	Rotate   = FLAG_ROTATE,
	Priority = FLAG_PRIORITY
}

enum Overlay
{
	None       = TLN_OVERLAY_NONE,
	Shadowmask = TLN_OVERLAY_SHADOWMASK,
	Aperture   = TLN_OVERLAY_APERTURE,
	Scanlines  = TLN_OVERLAY_SCANLINES,
	Custom     = TLN_OVERLAY_CUSTOM,
	MaxOverlay = TLN_MAX_OVERLAY
}

enum BlendMode
{
	None   = BLEND_NONE,
	Mix25  = BLEND_MIX25,
	Mix50  = BLEND_MIX50,
	Mix75  = BLEND_MIX75,
	Add    = BLEND_ADD,
	Sub    = BLEND_SUB,
	Mod    = BLEND_MOD,
	Custom = BLEND_CUSTOM,
	Max    = MAX_BLEND,
	Mix    = BLEND_MIX50
}

alias Affine = TLN_Affine;
alias SequenceFrame = TLN_SequenceFrame;
alias ColourStrip = TLN_ColorStrip;  // to the tune of 'rule brittania'
alias SequenceInfo = TLN_SequenceInfo;
alias SpriteData = TLN_SpriteData;
alias SpriteInfo = TLN_SpriteInfo;
alias TileInfo = TLN_TileInfo;
alias TileAttributes = TLN_TileAttributes;
alias PixelMap = TLN_PixelMap;

struct Colour
{
public:
	r, g, b: ubyte;

public:
	global fn create(r: u8, g: u8, b: u8) Colour
	{
		c: Colour;
		c.r = r;
		c.g = g;
		c.b = b;
		return c;
	}

public:
	fn asInteger() u32
	{
		i: u32;
		i = 0xFF000000U + (r << 16U) + (g << 8U) + b;
		return i;
	}
}

struct Engine
{
public:
	layers: Layer[];
	sprites: Sprite[];
	animations: Animation[];

	width: i32;    //!< Width of the framebuffer in pixels.
	height: i32;   //!< Height of the framebuffer in pixels.
	ver: u32;      //!< Tilengine DLL version, in a 32 bit integer.

private:
	global gInstance: Engine;  // Singleton.
	global gInit: bool;

public:
	global fn get() Engine*
	{
		if (!gInit) {
			throw new TilengineException("Engine.get call preceeding Engine.init.");
		}
		return &gInstance;
	}

	global fn create(hres: i32, vres: i32, numLayers: i32, numSprites: i32, numAnimations: i32) Engine*
	{
		if (!gInit) {
			retval := TLN_Init(hres, vres, numLayers, numSprites, numAnimations);
			Engine.tlnAssert(retval);
			gInit = true;
			gInstance.setup(hres, vres, numLayers, numSprites, numAnimations);
		}
		return &gInstance;
	}

	global fn tlnAssert(retval: bool)
	{
		if (!retval) {
			error := TLN_GetLastError();
			msg := TLN_GetErrorString(error);
			throw new TilengineException(.toString(msg));
		}
	}

public:
	fn cleanup()
	{
		TLN_Deinit();
	}

	@property fn numObjects() u32
	{
		return TLN_GetNumObjects();
	}

	@property fn usedMemory() u32
	{
		return TLN_GetUsedMemory();
	}

	fn setBackgroundColour(c: Colour)
	{
		TLN_SetBGColor(c.r, c.g, c.b);
	}

	fn setBackgroundColour(tilemap: Tilemap)
	{
		TLN_SetBGColorFromTilemap(tilemap.mPtr);
	}

	fn disableBackgroundColour()
	{
		TLN_DisableBGColor();
	}

	@property fn backgroundBitmap(val: Bitmap)
	{
		ok := TLN_SetBGBitmap(val.mPtr);
		Engine.tlnAssert(ok);
	}

	@property fn backgroundPalette(val: Palette)
	{
		ok := TLN_SetBGPalette(val.mPtr);
		Engine.tlnAssert(ok);
	}

	fn setRenderTarget(data: u8[], pitch: i32)
	{
		TLN_SetRenderTarget(data.ptr, pitch);
	}

	fn setRasterCallback(callback: fn!C(i32))
	{
		TLN_SetRasterCallback(callback);
	}

	fn setFrameCallback(callback: fn!C(i32))
	{
		TLN_SetFrameCallback(callback);
	}

	@property fn loadPath(val: string)
	{
		TLN_SetLoadPath(toStringz(val));
	}
	
	fn setCustomBlendFunction(func: fn!C(u8, u8) u8)
	{
		TLN_SetCustomBlendFunction(func);
	}

	fn beginFrame(frame: i32)
	{
		TLN_BeginFrame(frame);
	}

	fn drawNextScanline() bool
	{
		return TLN_DrawNextScanline();
	}

	fn getAvailableSprite() Sprite
	{
		index := TLN_GetAvailableSprite();
		Engine.tlnAssert(index != -1);
		return sprites[index];
	}

private:
	fn setup(hres: i32, vres: i32, numLayers: i32, numSprites: i32, numAnimations: i32)
	{
		layers = new Layer[](numLayers);
		foreach (i; 0 .. layers.length) {
			layers[i].mIndex = cast(i32)i;
		}

		sprites = new Sprite[](numSprites);
		foreach (i; 0 .. sprites.length) {
			sprites[i].mIndex = cast(i32)i;
		}
		
		animations = new Animation[](numAnimations);
		foreach (i; 0 .. animations.length) {
			animations[i].mIndex = cast(i32)i;
		}

		width = hres;
		height = vres;
		ver = TLN_GetVersion();
	}
}

struct Window
{
private:
	global gInstance: Window;
	global gInit: bool;

public:
	fn cleanup()
	{
		TLN_DeleteWindow();
	}

	fn get() Window*
	{
		if (!gInit) {
			throw new TilengineException("Window.get call preceeding Window.create");
		}
		return &gInstance;
	}

	global fn create(overlay: string, flags: WindowFlags) Window*
	{
		if (!gInit) {
			retval := TLN_CreateWindow(toStringz(overlay), flags);
			Engine.tlnAssert(retval);
			gInit = true;
		}
		return &gInstance;
	}

	global fn createThreaded(overlay: string, flags: WindowFlags) Window*
	{
		if (gInit) {
			retval := TLN_CreateWindowThread(toStringz(overlay), flags);
			Engine.tlnAssert(retval);
			gInit = true;
		}
		return &gInstance;
	}

	//! Set the title of the window.
	@property fn title(val: string)
	{
		TLN_SetWindowTitle(toStringz(val));
	}

	/*!
	 * Does basic window housekeeping in a single-threaded window.
	 *
	 * Must be called for each frame in the game loop. This method must
	 * only be called for single-threaded windows created with the
	 * `create` method.
	 *
	 * @Returns `true` if the window is active, or `false` if the user has
	 * requested the application's end.
	 */ 
	fn process() bool
	{
		return TLN_ProcessWindow();
	}

	//! @Returns `true` if the window hasn't requested the application's end.
	@property fn active() bool
	{
		return TLN_IsWindowActive();
	}

	/*!
	 * Returns the state of a given input.
	 * @Param id Input identifier to check state of.
	 * @Returns `true` if that input is pressed, `false` otherwise.
	 */
	fn getInput(id: Input) bool
	{
		return TLN_GetInput(id);
	}

	fn enableInput(player: Player, enable: bool)
	{
		TLN_EnableInput(player, enable);
	}

	fn assignInputJoystick(player: Player, index: i32)
	{
		TLN_AssignInputJoystick(player, index);
	}

	fn defineInputKey(player: Player, input: Input, keycode: u32)
	{
		TLN_DefineInputKey(player, input, keycode);
	}

	fn defineInputButton(player: Player, input: Input, joybutton: u8)
	{
		TLN_DefineInputButton(player, input, joybutton);
	}

	// Use this instead of Engine.beginFrame when using built-in windowing.
	fn beginFrame(frame: i32)
	{
		TLN_BeginWindowFrame(frame);
	}

	//! Draw a frame to the window.
	fn drawFrame(time: i32)
	{
		TLN_DrawFrame(time);
	}

	fn endFrame()
	{
		TLN_EndWindowFrame();
	}

	fn waitRedraw()
	{
		TLN_WaitRedraw();
	}

	fn enableCRTEffect(overlay: Overlay, overlayFactor: u8, threshold: u8,
		v0: u8, v1: u8, v2: u8, v3: u8, blur: bool, glowFactor: u8)
	{
		TLN_EnableCRTEffect(overlay, overlayFactor, threshold,
			v0, v1, v2, v3, blur, glowFactor);
	}

	fn disableCRTEffect()
	{
		TLN_DisableCRTEffect();
	}

	fn delay(msecs: u32)
	{
		TLN_Delay(msecs);
	}

	@property fn ticks() u32
	{
		return TLN_GetTicks();
	}
}

struct Layer
{
private:
	mIndex: i32;

public:
	fn setup(tileset: Tileset, tilemap: Tilemap)
	{
		ok := TLN_SetLayer(mIndex, tileset.mPtr, tilemap.mPtr);
		Engine.tlnAssert(ok);
	}

	fn disable()
	{
		ok := TLN_DisableLayer(mIndex);
		Engine.tlnAssert(ok);
	}

	fn setMap(tilemap: Tilemap)
	{
		ok := TLN_SetLayer(mIndex, null, tilemap.mPtr);
		Engine.tlnAssert(ok);
	}

	fn setPosition(x: i32, y: i32)
	{
		ok := TLN_SetLayerPosition(mIndex, x, y);
		Engine.tlnAssert(ok);
	}

	fn setScaling(sx: f32, sy: f32)
	{
		ok := TLN_SetLayerScaling(mIndex, sx, sy);
		Engine.tlnAssert(ok);
	}

	fn setTransform(angle: f32, dx: f32, dy: f32, sx: f32, sy: f32)
	{
		ok := TLN_SetLayerTransform(mIndex, angle, dx, dy, sx, sy);
		Engine.tlnAssert(ok);
	}

	fn setPixelMapping(map: PixelMap[])
	{
		ok := TLN_SetLayerPixelMapping(mIndex, map.ptr);
		Engine.tlnAssert(ok);
	}

	fn reset()
	{
		ok := TLN_ResetLayerMode(mIndex);
		Engine.tlnAssert(ok);
	}

	@property fn blend(val: BlendMode)
	{
		ok := TLN_SetLayerBlendMode(mIndex, val, 0);
		Engine.tlnAssert(ok);
	}

	fn setColumnOffset(offsets: i32[])
	{
		ok := TLN_SetLayerColumnOffset(mIndex, offsets.ptr);
		Engine.tlnAssert(ok);
	}

	fn setClip(x1: i32, y1: i32, x2: i32, y2: i32)
	{
		ok := TLN_SetLayerClip(mIndex, x1, y1, x2, y2);
		Engine.tlnAssert(ok);
	}

	fn disableClip()
	{
		ok := TLN_DisableLayerClip(mIndex);
		Engine.tlnAssert(ok);
	}

	fn setMosaic(width: i32, height: i32)
	{
		ok := TLN_SetLayerMosaic(mIndex, width, height);
		Engine.tlnAssert(ok);
	}

	fn disableMosaic()
	{
		ok := TLN_DisableLayerMosaic(mIndex);
		Engine.tlnAssert(ok);
	}

	fn getTileInfo(x: i32, y: i32, out info: TileInfo)
	{
		ok := TLN_GetLayerTile(mIndex, x, y, &info);
		Engine.tlnAssert(ok);
	}

	@property fn palette() Palette
	{
		value := TLN_GetLayerPalette(mIndex);
		Engine.tlnAssert(value !is null);

		p: Palette;
		p.initialise(value);
		return p;
	}

	@property fn palette(val: Palette)
	{
		ok := TLN_SetLayerPalette(mIndex, val.mPtr);
		Engine.tlnAssert(ok);
	}

	@property fn width() i32
	{
		return TLN_GetLayerWidth(mIndex);
	}

	@property fn height() i32
	{
		return TLN_GetLayerHeight(mIndex);
	}
}

struct Sprite
{
private:
	mIndex: i32;

public:
	fn setup(spriteset: Spriteset, flags: TileFlags)
	{
		ok := TLN_ConfigSprite(mIndex, spriteset.mPtr, flags);
		Engine.tlnAssert(ok);
	}

	@property fn spriteset(val: Spriteset)
	{
		ok := TLN_SetSpriteSet(mIndex, val.mPtr);
		Engine.tlnAssert(ok);
	}

	@property fn flags(val: TileFlags)
	{
		ok := TLN_SetSpriteFlags(mIndex, val);
		Engine.tlnAssert(ok);
	}

	@property fn picture(val: i32)
	{
		ok := TLN_SetSpritePicture(mIndex, val);
		Engine.tlnAssert(ok);
	}

	@property fn picture() i32
	{
		val := TLN_GetSpritePicture(mIndex);
		Engine.tlnAssert(val != -1);
		return val;
	}

	@property fn palette(val: Palette)
	{
		ok := TLN_SetSpritePalette(mIndex, val.mPtr);
		Engine.tlnAssert(ok);
	}

	@property fn palette() Palette
	{
		val := TLN_GetSpritePalette(mIndex);
		Engine.tlnAssert(val !is null);

		p: Palette;
		p.initialise(val);
		return p;
	}

	fn setPosition(x: i32, y: i32)
	{
		ok := TLN_SetSpritePosition(mIndex, x, y);
		Engine.tlnAssert(ok);
	}

	fn setScaling(sx: f32, sy: f32)
	{
		ok := TLN_SetSpriteScaling(mIndex, sx, sy);
		Engine.tlnAssert(ok);
	}

	fn reset()
	{
		ok := TLN_ResetSpriteScaling(mIndex);
		Engine.tlnAssert(false);
	}

	@property fn blend(val: BlendMode)
	{
		ok := TLN_SetSpriteBlendMode(mIndex, val, 0);
		Engine.tlnAssert(ok);
	}

	fn enableCollision(mode: bool)
	{
		ok := TLN_EnableSpriteCollision(mIndex, mode);
		Engine.tlnAssert(ok);
	}

	@property fn collision() bool
	{
		return TLN_GetSpriteCollision(mIndex);
	}

	fn disable()
	{
		ok := TLN_DisableSprite(mIndex);
		Engine.tlnAssert(ok);
	}
}

struct Animation
{
private:
	mIndex: i32;
public:
	fn setPaletteAnimation(palette: Palette, sequence: Sequence, blend: bool)
	{
		ok := TLN_SetPaletteAnimation(mIndex, palette.mPtr, sequence.mPtr, blend);
		Engine.tlnAssert(ok);
	}

	fn setPaletteAnimationSource(palette: Palette)
	{
		ok := TLN_SetPaletteAnimationSource(mIndex, palette.mPtr);
		Engine.tlnAssert(ok);
	}

	fn setTilesetAnimation(layerIndex: i32, sequence: Sequence)
	{
		ok := TLN_SetTilesetAnimation(mIndex, layerIndex, sequence.mPtr);
		Engine.tlnAssert(ok);
	}

	fn setTilemapAnimation(layerIndex: i32, sequence: Sequence)
	{
		ok := TLN_SetTilemapAnimation(mIndex, layerIndex, sequence.mPtr);
		Engine.tlnAssert(ok);
	}

	fn setSpriteAnimation(spriteIndex: i32, sequence: Sequence, loop: i32)
	{
		ok := TLN_SetSpriteAnimation(mIndex, spriteIndex, sequence.mPtr, loop);
		Engine.tlnAssert(ok);
	}

	@property fn active() bool
	{
		return TLN_GetAnimationState(mIndex);
	}

	@property fn delay(val: i32)
	{
		ok := TLN_SetAnimationDelay(mIndex, val);
		Engine.tlnAssert(ok);
	}

	fn disable()
	{
		ok := TLN_DisableAnimation(mIndex);
		Engine.tlnAssert(ok);
	}
}

struct Spriteset
{
private:
	mPtr: void*;

public:
	global fn create(bitmap: Bitmap, data: SpriteData[]) Spriteset
	{
		retval := TLN_CreateSpriteset(bitmap.mPtr, data.ptr, cast(i32)data.length);
		Engine.tlnAssert(retval !is null);

		ss: Spriteset;
		ss.initialise(retval);
		return ss;
	}

	global fn fromFile(filename: string) Spriteset
	{
		retval := TLN_LoadSpriteset(toStringz(filename));
		Engine.tlnAssert(retval !is null);

		ss: Spriteset;
		ss.initialise(retval);
		return ss;
	}

	fn cleanup()
	{
		ok := TLN_DeleteSpriteset(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn clone() Spriteset
	{
		retval := TLN_CloneSpriteset(mPtr);
		Engine.tlnAssert(retval !is null);

		ss: Spriteset;
		ss.initialise(retval);
		return ss;
	}

	fn getInfo(index: i32, out info: SpriteInfo)
	{
		ok := TLN_GetSpriteInfo(mPtr, index, &info);
		Engine.tlnAssert(ok);
	}

	@property fn palette() Palette
	{
		p: Palette;
		p.initialise(TLN_GetSpritesetPalette(mPtr));
		return p;
	}

	fn findSprite(name: string) i32
	{
		index := TLN_FindSpritesetSprite(mPtr, toStringz(name));
		Engine.tlnAssert(index != -1);
		return index;
	}

	fn setSpritesetData(entry: i32, data: SpriteData[], pixels: void*, pitch: i32)
	{
		ok := TLN_SetSpritesetData(mPtr, entry, data.ptr, pixels, pitch);
		Engine.tlnAssert(ok);
	}

private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct Tileset
{
private:
	mPtr: void*;

public:
	global fn create(numTiles: i32, width: i32, height: i32, palette: Palette, sp: SequencePack, attributes: TileAttributes[]) Tileset
	{
		retval := TLN_CreateTileset(numTiles, width, height, palette.mPtr, sp.mPtr, attributes.ptr);
		Engine.tlnAssert(retval !is null);
		
		ts: Tileset;
		ts.initialise(retval);
		return ts;
	}

	global fn fromFile(filename: string) Tileset
	{
		retval := TLN_LoadTileset(toStringz(filename));
		Engine.tlnAssert(retval !is null);

		ts: Tileset;
		ts.initialise(retval);
		return ts;
	}

	fn cleanup()
	{
		ok := TLN_DeleteTileset(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn clone() Tileset
	{
		retval := TLN_CloneTileset(mPtr);
		Engine.tlnAssert(retval !is null);
		
		ts: Tileset;
		ts.initialise(retval);
		return ts;
	}

	fn setPixels(entry: i32, pixels: u8[], pitch: i32)
	{
		ok := TLN_SetTilesetPixels(mPtr, entry, pixels.ptr, pitch);
		Engine.tlnAssert(ok);
	}

	fn copyTile(src: i32, dst: i32)
	{
		ok := TLN_CopyTile(mPtr, src, dst);
		Engine.tlnAssert(ok);
	}

	@property fn width() i32
	{
		return TLN_GetTileWidth(mPtr);
	}

	@property fn height() i32
	{
		return TLN_GetTileHeight(mPtr);
	}

	@property fn palette() Palette
	{
		p: Palette;
		p.initialise(TLN_GetTilesetPalette(mPtr));
		return p;
	}

	@property fn sequencePack() SequencePack
	{
		sp: SequencePack;
		sp.initialise(TLN_GetTilesetSequencePack(mPtr));
		return sp;
	}

private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct Tilemap
{
public:
	global fn create(rows: i32, cols: i32, tiles: Tile[], bg: Colour, tileset: Tileset) Tilemap
	{
		retval := TLN_CreateTilemap(rows, cols, tiles.ptr, bg.asInteger(), tileset.mPtr);
		Engine.tlnAssert(retval !is null);

		tm: Tilemap;
		tm.initialise(retval);
		return tm;
	}

	global fn fromFile(filename: string, layername: string) Tilemap
	{
		retval := TLN_LoadTilemap(toStringz(filename), toStringz(layername));
		Engine.tlnAssert(retval !is null);

		tm: Tilemap;
		tm.initialise(retval);
		return tm;
	}

public:
	fn cleanup()
	{
		ok := TLN_DeleteTilemap(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn clone() Tilemap
	{
		retval := TLN_CloneTilemap(mPtr);
		Engine.tlnAssert(retval !is null);
		
		tm: Tilemap;
		tm.initialise(retval);
		return tm;
	}

	@property fn cols() i32
	{
		return TLN_GetTilemapCols(mPtr);
	}

	@property fn rows() i32
	{
		return TLN_GetTilemapRows(mPtr);
	}

	@property fn tileset() Tileset
	{
		ptr := TLN_GetTilemapTileset(mPtr);

		ts: Tileset;
		ts.initialise(ptr);
		return ts;
	}

	fn setTile(row: i32, col: i32, tile: Tile*)
	{
		ok := TLN_SetTilemapTile(mPtr, row, col, tile);
		Engine.tlnAssert(ok);
	}

	fn getTile(row: i32, col: i32, out tile: Tile)
	{
		ok := TLN_GetTilemapTile(mPtr, row, col, &tile);
		Engine.tlnAssert(ok);
	}

	fn copyTiles(srcRow: i32, srcCol: i32, rows: i32, cols: i32,
		dst: Tilemap, dstRow: i32, dstCol: i32)
	{
		ok := TLN_CopyTiles(mPtr, srcRow, srcCol, rows, cols, dst.mPtr, dstRow, dstCol);
		Engine.tlnAssert(ok);
	}

private:
	mPtr: void*;

	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct Palette
{
public:
	global fn create(entries: i32) Palette
	{
		retval := TLN_CreatePalette(entries);
		Engine.tlnAssert(retval !is null);

		p: Palette;
		p.initialise(retval);
		return p;
	}

	global fn fromFile(filename: string) Palette
	{
		retval := TLN_LoadPalette(toStringz(filename));
		Engine.tlnAssert(retval !is null);

		p: Palette;
		p.initialise(retval);
		return p;
	}

public:
	fn cleanup()
	{
		ok := TLN_DeletePalette(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn clone() Palette
	{
		retval := TLN_ClonePalette(mPtr);
		Engine.tlnAssert(retval !is null);

		p: Palette;
		p.initialise(retval);
		return p;
	}

	fn setColour(index: i32, c: Colour)
	{
		ok := TLN_SetPaletteColor(mPtr, index, c.r, c.g, c.b);
		Engine.tlnAssert(ok);
	}

	fn mix(src1: Palette, src2: Palette, factor: u8)
	{
		ok := TLN_MixPalettes(src1.mPtr, src2.mPtr, mPtr, factor);
		Engine.tlnAssert(ok);
	}

	fn addColour(c: Colour, first: u8, count: u8)
	{
		ok := TLN_AddPaletteColor(mPtr, c.r, c.g, c.b, first, count);
		Engine.tlnAssert(ok);
	}

	fn subColour(c: Colour, first: u8, count: u8)
	{
		ok := TLN_SubPaletteColor(mPtr, c.r, c.g, c.b, first, count);
		Engine.tlnAssert(ok);
	}

	fn mulColour(c: Colour, first: u8, count: u8)
	{
		ok := TLN_ModPaletteColor(mPtr, c.r, c.g, c.b, first, count);
		Engine.tlnAssert(ok);
	}

private:
	mPtr: void*;

private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct Bitmap
{
public:
	global fn create(width: i32, height: i32, bpp: i32) Bitmap
	{
		retval := TLN_CreateBitmap(width, height, bpp);
		Engine.tlnAssert(retval !is null);
		
		b: Bitmap;
		b.initialise(retval);
		return b;
	}

	global fn fromFile(filename: string) Bitmap
	{
		retval := TLN_LoadBitmap(toStringz(filename));
		Engine.tlnAssert(retval !is null);

		b: Bitmap;
		b.initialise(retval);
		return b;
	}

public:
	fn cleanup()
	{
		ok := TLN_DeleteBitmap(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn clone() Bitmap
	{
		retval := TLN_CloneBitmap(mPtr);
		Engine.tlnAssert(retval !is null);
		
		b: Bitmap;
		b.initialise(retval);
		return b;
	}

	@property fn width() i32
	{
		return TLN_GetBitmapWidth(mPtr);
	}

	@property fn height() i32
	{
		return TLN_GetBitmapHeight(mPtr);
	}

	@property fn depth() i32
	{
		return TLN_GetBitmapDepth(mPtr);
	}

	@property fn pitch() i32
	{
		return TLN_GetBitmapPitch(mPtr);
	}

	@property fn pixelData() u8[]
	{
		pixelData := new u8[](pitch * height);
		ptrPixelData := TLN_GetBitmapPtr(mPtr, 0, 0);
		pixelData[0 .. $] = ptrPixelData[0 .. pixelData.length];
		return pixelData;
	}

	@property fn pixelData(val: u8[])
	{
		if (val.length != cast(u32)(pitch * height)) {
			msg := new "expected pixelData length ${pitch * height}, got ${val.length}";
			throw new TilengineException(msg);
		}
		ptrPixelData := TLN_GetBitmapPtr(mPtr, 0, 0);
		ptrPixelData[0 .. val.length] = val[0 .. $];
	}

	@property fn palette() Palette
	{
		ptr := TLN_GetBitmapPalette(mPtr);
		p: Palette;
		p.initialise(ptr);
		return p;
	}

	@property fn palette(val: Palette)
	{
		ok := TLN_SetBitmapPalette(mPtr, val.mPtr);
		Engine.tlnAssert(ok);
	}

private:
	mPtr: void*;

private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct Sequence
{
private:
	mPtr: void*;

public:
	global fn create(name: string, target: i32, frames: SequenceFrame[]) Sequence
	{
		retval := TLN_CreateSequence(toStringz(name), target, cast(i32)frames.length, frames.ptr);
		Engine.tlnAssert(retval !is null);
		
		seq: Sequence;
		seq.initialise(retval);
		return seq;
	}

	global fn create(name: string, strips: ColourStrip[]) Sequence
	{
		retval := TLN_CreateCycle(toStringz(name), cast(i32)strips.length, strips.ptr);
		Engine.tlnAssert(retval !is null);

		seq: Sequence;
		seq.initialise(retval);
		return seq;
	}

public:
	fn cleanup()
	{
		ok := TLN_DeleteSequence(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}
	
	fn clone() Sequence
	{
		retval := TLN_CloneSequence(mPtr);
		Engine.tlnAssert(retval !is null);

		seq: Sequence;
		seq.initialise(retval);
		return seq;
	}

	fn getInfo(ref info: SequenceInfo)
	{
		ok := TLN_GetSequenceInfo(mPtr, &info);
		Engine.tlnAssert(ok);
	}


private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

struct SequencePack
{
private:
	mPtr: void*;

public:
	global fn fromFile(filename: string) SequencePack
	{
		retval := TLN_LoadSequencePack(toStringz(filename));
		Engine.tlnAssert(retval !is null);

		sp: SequencePack;
		sp.initialise(retval);
		return sp;
	}

public:
	fn cleanup()
	{
		ok := TLN_DeleteSequencePack(mPtr);
		Engine.tlnAssert(ok);
		mPtr = null;
	}

	fn numSequences() i32
	{
		return TLN_GetSequencePackCount(mPtr);
	}

	fn find(name: string) Sequence
	{
		retval := TLN_FindSequence(mPtr, toStringz(name));
		Engine.tlnAssert(retval !is null);
		
		s: Sequence;
		s.initialise(retval);
		return s;
	}

	fn get(index: i32) Sequence
	{
		retval := TLN_GetSequence(mPtr, index);
		Engine.tlnAssert(retval !is null);
		
		s: Sequence;
		s.initialise(retval);
		return s;
	}

	fn add(sequence: Sequence)
	{
		ok := TLN_AddSequenceToPack(mPtr, sequence.mPtr);
		Engine.tlnAssert(ok);
	}

private:
	fn initialise(res: void*)
	{
		mPtr = res;
	}
}

