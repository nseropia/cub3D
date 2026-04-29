# cub3D

A low-level graphics project written in C that renders a first-person 3D maze from a 2D `.cub` map file using raycasting and MiniLibX.

![C](https://img.shields.io/badge/C-Language-00599C?style=plastic&logo=c&logoColor=white)
![Raycasting](https://img.shields.io/badge/Raycasting-3D_Rendering-1f6feb?style=plastic)
![MiniLibX](https://img.shields.io/badge/MiniLibX-Graphics-6E4C13?style=plastic)
![42 Berlin](https://img.shields.io/badge/Made_for-42_Berlin-black?style=plastic)

## Why this project matters

cub3D shows how a simple 2D map can be transformed into an interactive first-person 3D environment without relying on a game engine. The project combines real-time rendering, structured file parsing, texture loading, input handling, map validation, and manual memory management in C, translating raycasting concepts into a stable graphical application with clear error handling and predictable runtime behavior.

## Project in action

![cub3D demo](assets/cub3d-demo.gif)

## Quick start

This project uses MiniLibX as a Git submodule.

```bash
git clone --recurse-submodules https://github.com/nseropia/cub3D.git
cd cub3D
```

If you already cloned the repository without submodules:

```bash
git submodule sync --recursivegit submodule update --init --recursive
```

Install the required Linux dependencies:

```bash
sudo apt update
sudo apt install build-essential libx11-dev libxext-dev zlib1g-dev libbsd-dev
```

Build and run:

```bash
make
./cub3D maps/map.cub
```

## Usage

### Controls

| Key | Action |
| --- | --- |
| `W` | Move forward |
| `S` | Move backward |
| `A` | Move left |
| `D` | Move right |
| `←` | Rotate left |
| `→` | Rotate right |
| `ESC` | Exit |

## Map format

A `.cub` file defines texture paths, floor and ceiling colors, and the maze layout.

```text
NO ./textures/texture-01.xpm
SO ./textures/texture-02.xpm
WE ./textures/texture-03.xpm
EA ./textures/texture-04.xpm

C 91,166,252
F 224,184,144

111111
100001
1000E1
100001
111111
```

Map symbols:

| Symbol | Meaning |
| --- | --- |
| `1` | Wall |
| `0` | Empty space |
| `N` / `S` / `E` / `W` | Player start position and orientation |

A reusable template is available at `maps/map_template.cub`.

## Technical overview

At runtime, cub3D:

1. reads and validates a `.cub` scene file;
2. checks texture paths, RGB color definitions, map closure, and player spawn state;
3. initializes a MiniLibX window and image buffer;
4. casts one ray per vertical screen column;
5. uses grid traversal to detect wall collisions;
6. calculates projected wall height from ray distance;
7. applies the correct wall texture based on hit direction;
8. redraws the scene continuously based on keyboard input.
