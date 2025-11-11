# Setwall

<p align="center">
    <img
      src="https://github.com/user-attachments/assets/29eb2060-3b3b-4bd1-b871-034a5493cec5"
      alt="Preview of Setwall"
      width="500"
    >
 <p align="center">A wallpaper picker for MacOS, built with Raylib.</p>
</p>

## "Features"

*   **Multiple Layouts**: Switch between four different animated layouts (Grid, Horizontal River, Vertical River, Wave).
*   **Live Search**: Filter wallpapers instantly by typing.
*   **Full-Screen Preview**: Isolate and preview a single wallpaper.
*   **GPU-Accelerated Effects**: Add optional, configurable visual effects for startup, key presses, and exit.
*   **Total Customization**: Every color, animation speed, and behavior can be configured in an external text **.conf** file.

## Dependencies

*   **raylib**

## Building

Just run: 

```bash
make
```
This creates `setwall` executable. If you run `make install`, it will be installed in `/usr/local/bin`

On macOS (Homebrew):

```bash
brew install raylib pkg-config
make           # or: make UNIVERSAL=1
```

## Usage

The basic command runs the picker, pointing it to a directory of images. Upon selection, it prints the full path of the chosen wallpaper to standard output.

```bash
./setwall [OPTIONS] [PATH_TO_WALLPAPERS]
```

If no path is provided, it defaults to `~/Pictures/Wallpaper` (scans subfolders, ignores hidden files/folders).

### Options

| Flag                | Argument | Description                                                                     |
| ------------------- | -------- | ------------------------------------------------------------------------------- |
| `--help`              |          | Show the help message and exit.                                               |
| `--filename`          |          | Print only the filename to `stdout` instead of the full path.                 |
| `--width `          | `<pixels>`  | Set the initial window width.                                                |
| `--height`          | `<pixels>`  | Set the initial window height.                                               |
| `--min_width`       | `<pixels>`  | Minimum image width to index (default 1024).                                 |
| `--min_height`      | `<pixels>`  | Minimum image height to index (default 768).                                 |
| `--startup-effect`  | `<name>` | Override the configured startup animation.                                      |
| `--keypress-effect` | `<name>` | Override the configured key press animation.                                    |
| `--exit-effect`     | `<name>` | Override the configured exit animation.                                         |

### Keybindings

| Key(s)                           | Action                                                                  |
| -------------------------------- | ----------------------------------------------------------------------- |
| **Mouse**                        | Hover over thumbnails to highlight them.                                |
| **Mouse Wheel**                  | Scroll through the wallpaper list.                                      |
| **Ctrl + Mouse Wheel**           | Zoom in/out, scaling the thumbnails.                                    |
| **LMB (Left Click)**             | Apply the highlighted wallpaper (does not exit).                        |
| **RMB (Right Click)**            | Show a full-screen preview of the highlighted wallpaper.                |
| **ESC**                          | Exit the program (or close the preview/search).                         |
| `h` / `l` / **Left/Right Arrows**  | Highlight the previous/next wallpaper.                                  |
| `k` / `j` / **Up/Down Arrows**     | Highlight the wallpaper above/below (Grid) or previous/next (other modes). |
| `1`, `2`, `3`, `4`               | Switch between layout modes (Grid, H-River, V-River, Wave).             |
| `/`                              | Enter search mode. Press Enter or ESC to exit search.                   |
| **Enter**                        | Apply the keyboard-highlighted wallpaper (does not exit).              |
| **Left Shift**                   | Show a full-screen preview of the keyboard-highlighted wallpaper.       |
| `P`                              | Toggle apply mode: All Desktops vs Current Space (macOS).              |
| **ESC**                          | Exit the program (or close the preview/search).                         |

## Configuration

Setwall is configurable via a plain text file located at:
`~/.config/setwall/setwall.conf`

The application will create the directory on first run if it doesn't exist. If the config file is not found, default values will be used.

Here is a minimal template `setwall.conf`:

```ini
# Setwall Configuration File
# Lines starting with # or ; are comments.

[Theme]
# Colors are defined as R, G, B, A (0-255)
bg = 10, 10, 15, 255
idle = 30, 30, 46, 255
hover = 49, 50, 68, 255
border = 203, 166, 247, 255
ripple = 245, 194, 231, 255
overlay = 10, 10, 15, 200
text = 202, 212, 241, 255

[Settings]
# Width
width = 1280
# Height
height = 720
# Max images
max_wallpapers = 5000
# The base size of the square thumbnail images.
base_thumb_size = 150
# The base padding between thumbnails.
base_padding = 15
# The thickness of the glowing border on hover.
border_thickness_bloom = 3.0
# The number of threads to use for loading thumbnail images.
max_threads = 8
# The speed of all layout and hover animations. Higher is faster.
anim_speed = 20.0
# The number of particles to emit on selection.
particle_count = 50
# The duration of the Ken Burns (pan/zoom) effect in preview mode.
ken_burns_duration = 15.0
# The maximum frames per second.
max_fps = 200

[Effects]
# Available effects: none, glitch, blur, pixelate, shake, collapse, reveal
startup_effect = blur
keypress_effect = none
exit_effect = glitch
```

