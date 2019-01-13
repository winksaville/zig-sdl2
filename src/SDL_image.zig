//  https://www.libsdl.org/projects/SDL_image/
//
// Based on `zig translate-c` of http://hg.libsdl.org/SDL_image/raw-file/b4519566edd3/SDL_image.h
// from SDL_image release 2.0.4.

use @import("SDL_stdinc.zig");

const SDL_version = @import("SDL_version.zig").SDL_version;
const SDL_RWops = @import("SDL_rwops.zig").SDL_RWops;
const SDL_Texture = @import("SDL_render.zig").SDL_Texture;
const SDL_Surface = @import("SDL_surface.zig").SDL_Surface;
const SDL_Renderer = @import("SDL_renderer.zig").SDL_Renderer;
const SDL_ErrorNs = @import("SDL_error.zig");
const SDL_SetError = SDL_ErrorNs.SDL_SetError;
const SDL_GetError = SDL_ErrorNs.SDL_GetError;

pub extern fn IMG_Linked_Version() ?[*]const SDL_version;
pub const IMG_INIT_JPG = 1;
pub const IMG_INIT_PNG = 2;
pub const IMG_INIT_TIF = 4;
pub const IMG_INIT_WEBP = 8;
pub const IMG_InitFlags = extern enum {
    IMG_INIT_JPG = 1,
    IMG_INIT_PNG = 2,
    IMG_INIT_TIF = 4,
    IMG_INIT_WEBP = 8,
};

pub extern fn IMG_Init(flags: u32) c_int;
pub extern fn IMG_Quit() void;
pub extern fn IMG_LoadTyped_RW(src: ?[*]SDL_RWops, freesrc: c_int, type_0: ?[*]const u8) ?[*]SDL_Surface;
pub extern fn IMG_Load(file: ?[*]const u8) ?[*]SDL_Surface;
pub extern fn IMG_Load_RW(src: ?[*]SDL_RWops, freesrc: c_int) ?[*]SDL_Surface;
pub extern fn IMG_LoadTexture(renderer: ?*SDL_Renderer, file: ?[*]const u8) ?*SDL_Texture;
pub extern fn IMG_LoadTexture_RW(renderer: ?*SDL_Renderer, src: ?[*]SDL_RWops, freesrc: c_int) ?*SDL_Texture;
pub extern fn IMG_LoadTextureTyped_RW(renderer: ?*SDL_Renderer, src: ?[*]SDL_RWops, freesrc: c_int, type_0: ?[*]const u8) ?*SDL_Texture;
pub extern fn IMG_isICO(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isCUR(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isBMP(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isGIF(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isJPG(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isLBM(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isPCX(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isPNG(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isPNM(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isSVG(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isTIF(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isXCF(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isXPM(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isXV(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_isWEBP(src: ?[*]SDL_RWops) c_int;
pub extern fn IMG_LoadICO_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadCUR_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadBMP_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadGIF_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadJPG_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadLBM_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadPCX_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadPNG_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadPNM_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadSVG_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadTGA_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadTIF_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadXCF_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadXPM_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadXV_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_LoadWEBP_RW(src: ?[*]SDL_RWops) ?[*]SDL_Surface;
pub extern fn IMG_ReadXPMFromArray(xpm: ?[*](?[*]u8)) ?[*]SDL_Surface;
pub extern fn IMG_SavePNG(surface: ?[*]SDL_Surface, file: ?[*]const u8) c_int;
pub extern fn IMG_SavePNG_RW(surface: ?[*]SDL_Surface, dst: ?[*]SDL_RWops, freedst: c_int) c_int;
pub extern fn IMG_SaveJPG(surface: ?[*]SDL_Surface, file: ?[*]const u8, quality: c_int) c_int;
pub extern fn IMG_SaveJPG_RW(surface: ?[*]SDL_Surface, dst: ?[*]SDL_RWops, freedst: c_int, quality: c_int) c_int;
pub const IMG_SetError = SDL_SetError;
pub const IMG_GetError = SDL_GetError;
