const std = @import("std");
const warn = std.debug.warn;
const assert = std.debug.assert;

const DBG: bool = false;

const SDL = @import("../src/index.zig");

fn cstr_len(str: [*]const u8) usize {
    var i: usize = 0;
    while (str[0] != 0) : (i += 1) {}
    return i;
}

fn SdlGetError() []const u8 {
    if (SDL.SDL_GetError() != null) {
        var s = SDL.SDL_GetError().?;
        var l = cstr_len(s);
        return s[0..l];
    } else {
        return "Unknown error";
    }
}

fn ImgGetError() []const u8 {
    if (SDL.IMG_GetError() != null) {
        var s = SDL.IMG_GetError().?;
        var l = cstr_len(s);
        return s[0..l];
    } else {
        return "Unknown error";
    }
}

test "SDL_image.sizeof(c_int).<=.sizeof(isize)" {
    assert(@sizeOf(c_int) <= @sizeOf(isize));
}

test "SDL_image.IMG_Init" {
    if (DBG) warn("\n");
    var result = @intCast(isize, SDL.IMG_Init(SDL.IMG_INIT_JPG));
    assert((result & SDL.IMG_INIT_JPG) != 0);
    assert(SDL.IMG_GetError() != null);
    var s = SDL.IMG_GetError().?;
    var l = cstr_len(s);
    if (DBG) warn("Load error: len={} {}\n", l, s[0..l]);
    defer SDL.IMG_Quit();
}

test "SDL_image.IMG_Load.error" {
    if (DBG) warn("\n");

    var result = @intCast(isize, SDL.IMG_Init(SDL.IMG_INIT_JPG));
    assert((result & SDL.IMG_INIT_JPG) != 0);
    defer SDL.IMG_Quit();

    // Hangs as the file doesn't exist
    var surface = SDL.IMG_Load(c"no-such-file.jpg") orelse {
        if (DBG) warn("SDL_image.display: IMG_Load expected failure SUCCESS\n");
        // Bug: Calling ImgGetError() hangs?
        if (false) warn("SDL_image.display: IMG_Load expected failure SUCCESS, reported error: \"{s}\"\n", ImgGetError());
        return;
    };
    if (DBG) warn("SDL_image.IMG_Load.error: succeded, should have FAILED\n");
    return error.Failed;
}

test "SDL_image.IMG_Load.ok" {
    if (DBG) warn("\n");

    assert(SDL.IMG_Init(SDL.IMG_INIT_JPG) == @intCast(c_int, SDL.IMG_INIT_JPG));
    defer SDL.IMG_Quit();

    var surface = SDL.IMG_Load(c"res/bricks2.jpg");
    if (surface == null) {
        if (DBG) warn("SDL_image.IMG_Load.ok: Failed \"{s}\"\n", ImgGetError());
    }
    assert(surface != null);
    defer SDL.SDL_FreeSurface(surface.?);
}

test "SDL_image.display" {
    if (DBG) warn("\n");

    assert(SDL.IMG_Init(SDL.IMG_INIT_JPG) == @intCast(c_int, SDL.IMG_INIT_JPG));
    defer SDL.IMG_Quit();

    var surface = SDL.IMG_Load(c"res/bricks2.jpg") orelse {
        if (DBG) warn("SDL_image.display: IMG_Load failed error: \"{s}\"\n", SdlGetError());
        return error.Failed;
    };
    defer SDL.SDL_FreeSurface(surface);

    if (SDL.SDL_Init(SDL.SDL_INIT_VIDEO | SDL.SDL_INIT_AUDIO) != 0) {
        if (DBG) warn("SDL_image.display: SDL_Init failed error: \"{s}\"\n", SdlGetError());
        return error.Failed;
    }
    defer SDL.SDL_Quit();

    var renderer: *SDL.SDL_Renderer = undefined;
    var window: *SDL.SDL_Window = undefined;

    if (SDL.SDL_CreateWindowAndRenderer(surface.w, surface.h, SDL.SDL_WINDOW_SHOWN, &window, &renderer) != 0) {
        if (DBG) warn("SDL_image.display: SDL_CreateWindowAndRenderer failed error: \"{s}\"\n", SdlGetError());
        return error.Failed;
    }
    defer SDL.SDL_DestroyRenderer(renderer);
    defer SDL.SDL_DestroyWindow(window);

    SDL.SDL_SetWindowTitle(window, c"zig-sdl");

    var texture = SDL.SDL_CreateTextureFromSurface(renderer, surface) orelse {
        if (DBG) warn("SDL_image.display: SDL_CreateTextureFromSurface failed error: \"{s}\"\n", SdlGetError());
        return error.Failed;
    };
    defer SDL.SDL_DestroyTexture(texture);

    if (SDL.SDL_RenderCopy(renderer, texture, null, null) != 0) {
        if (DBG) warn("SDL_image.display: SDL_RenderCopy failed error: \"{s}\"\n", SdlGetError());
        return error.Failed;
    } 

    const r1 = SDL.SDL_Rect{ .x = 10, .y = 10, .w = 10, .h = 10 };
    const r2 = SDL.SDL_Rect{ .x = 40, .y = 10, .w = 10, .h = 10 };
    var rects = []SDL.SDL_Rect{ r1, r2 };

    _ = SDL.SDL_SetRenderDrawColor(renderer, 0, 128, 128, 255);
    _ = SDL.SDL_RenderFillRects(renderer, @ptrCast([*]SDL.SDL_Rect, &rects[0]), 2);

    _ = SDL.SDL_RenderPresent(renderer);

    SDL.SDL_Delay(3000);
}

