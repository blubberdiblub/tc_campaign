
;/*******************************
;* src/consts/arch.asm
;*******************************/

pub const arch.instruction_size = 4
pub const arch.instruction_increment_shift = 2

;/*******************************
;* src/consts/game.asm
;*******************************/

pub const game.direction_up = 0
pub const game.direction_right = 1
pub const game.direction_down = 2
pub const game.direction_left = 3
pub const game.direction_still = 4

; 1_000_000_000 nano second = 0x0000_0000_3B9A_CA00
; pub const game.tick_duration_0 = 0xCA00
; pub const game.tick_duration_1 = 0x3B9A
; pub const game.tick_duration_2 = 0x0000
; pub const game.tick_duration_3 = 0x0000

; 0.5 second = 500_000_000 nano second = 0x0000_0000_1DCD_6500
pub const game.tick_duration_0 = 0x6500
pub const game.tick_duration_1 = 0x1DCD
pub const game.tick_duration_2 = 0x0000
pub const game.tick_duration_3 = 0x0000

;/*******************************
;* src/consts/keyboard.asm
;*******************************/

pub const keyboard.mask_key = 0x00FF
pub const keyboard.mask_event = 0x0100

pub const keyboard.event_released = 0x0000
pub const keyboard.event_pressed = 0x0100

pub const keyboard.key_min = 1
pub const keyboard.key_up = 1
pub const keyboard.key_right = 2
pub const keyboard.key_down = 3
pub const keyboard.key_left = 4
pub const keyboard.key_max = 4

;/*******************************
;* src/consts/map.asm
;*******************************/

pub const map.width = 15
pub const map.height = 11
pub const map.size = 165 ; 11*15
pub const map.max_x = 14
pub const map.max_y = 10

pub const map.tiles.empty = 0
pub const map.tiles.wall = 1
pub const map.tiles.coin = 2

;/*******************************
;* src/consts/scene.asm
;*******************************/

; given:
; -> 256x192 pixels screen
; -> 15x11   tiles map
; => 17x17   pixels tile

pub const scene.margin_top = 0
pub const scene.margin_bottom = 0
pub const scene.margin_left = 0
pub const scene.margin_right = 0

;/*******************************
;* src/consts/screen.asm
;*******************************/

; Screen pixel mode (settings #0)
; 0: ASCII  8
; 1: ASCII 24
; 2: Pixel  8
; 3: Pixel 24

; While in mode #2 (Pixel 8)
  ; Screen memory offset (settings #1)
  ; Screen resolutions (settings #2)
    ; 0. 80x60
    ; 1. 160x120
    ; 2. 256x192
    ; 3. 320x240
    ; 4. 640x480
    ; 5. 800x600
    ; 6. 920x720
    ; 7. 1024x768

pub const screen.mode_index = 0
pub const screen.mode_value = 2
pub const screen.offset_index = 1
pub const screen.resolution_index = 2
pub const screen.resolution_value = 2

pub const screen.width = 256
pub const screen.height = 192

;/*******************************
;* src/consts/sprites.asm
;*******************************/

pub const sprites.width = 17
pub const sprites.height = 17 ; unused as sprite are all square
pub const sprites.size = 289 ; height x width

pub const sprites.rotation_0 = 0
pub const sprites.rotation_90 = 1
pub const sprites.rotation_180 = 2
pub const sprites.rotation_270 = 3

pub const sprites.empty = 0
pub const sprites.unimplemented = 1
pub const sprites.wall_end = 2
pub const sprites.wall_straight = 3
pub const sprites.wall_corner = 4
pub const sprites.robot = 5
pub const sprites.ghost = 6
pub const sprites.coin = 7
pub const sprites.max = 7 ; for lookup table

;/*******************************
;* src/init.asm
;*******************************/

;
;   Jump table initialisation
;
; r1: sprite id
; r2: pointer address
; r3: pointer value

; sprite_empty
add r1, zr, sprites.empty
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_empty
store_32 [r2], r3
; sprite_unimplemented
add r1, zr, sprites.unimplemented
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_unimplemented
store_32 [r2], r3
; sprite_wall_end
add r1, zr, sprites.wall_end
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_wall_end
store_32 [r2], r3
; sprite_wall_straight
add r1, zr, sprites.wall_straight
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_wall_straight
store_32 [r2], r3
; sprite_wall_corner
add r1, zr, sprites.wall_corner
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_wall_corner
store_32 [r2], r3
; sprite_robot
add r1, zr, sprites.robot
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_robot
store_32 [r2], r3
; sprite_ghost
add r1, zr, sprites.ghost
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_ghost
store_32 [r2], r3
; sprite_coin
add r1, zr, sprites.coin
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_coin
store_32 [r2], r3

;
;   Screen initialization
;

; r1 = screen parameter value
mov r1, screen.mode_index
screen r1, screen.mode_value

mov r1, screen.offset_index
add r2, zr, ptr.screen
screen r1, r2

mov r1, screen.resolution_index
screen r1, screen.resolution_value

;/*******************************
;* src/main.asm
;*******************************/



call drawing.draw_whole_map

;
;   State initialization
;
; Robot
const robot_initial_x = 1
const robot_initial_y = 1
const robot_initial_direction = game.direction_down

mov r1, robot_initial_x
mov r2, robot_initial_y
mov r5, robot_initial_direction
add r6, zr, ptr.state_robot
store_8 [r6], r1
add r6, r6, 1
store_8 [r6], r2
add r6, r6, 1
store_8 [r6], r5

mov r3, sprites.rotation_0
mov r4, sprites.robot
call drawing.draw_sprite_at_map_coord

; Ghost
const ghost_initial_x = 13
const ghost_initial_y = 1
const ghost_initial_direction = game.direction_down

mov r1, ghost_initial_x
mov r2, ghost_initial_y
mov r5, ghost_initial_direction
add r6, zr, ptr.state_ghost
store_8 [r6], r1
add r6, r6, 1
store_8 [r6], r2
add r6, r6, 1
store_8 [r6], r5

mov r3, sprites.rotation_0
mov r4, sprites.ghost
call drawing.draw_sprite_at_map_coord

;
;   Time initialization
;
add r1, zr, ptr.tick_duration_low
load_32 r2, [r1]
add r1, zr, ptr.tick_duration_high
load_32 r3, [r1]

time_0 r4
time_1 r5
add r4, r4, r2
add r5, r5, r3
cmp r4, r2
jae init_store_next_tick
add r5, r5, 1 ; overflow

init_store_next_tick:
add r1, zr, ptr.next_tick_low
store_32 [r1], r4
add r1, zr, ptr.next_tick_high
store_32 [r1], r5

game_loop:
    ;
    ;   Event handling
    ;
    ; r1 = keyboard event+key / direction
    ; r2 = keyboard key / direction address
    ; r3 = keyboard event
    ; r4 = jump address
    keyboard r1
    and r2, r1, keyboard.mask_key
    and r3, r1, keyboard.mask_event
    
    cmp r3, keyboard.event_pressed
    jne game_loop_event_handling_end
    cmp r2, keyboard.key_min
    jb game_loop_event_handling_end
    cmp r2, keyboard.key_max
    ja game_loop_event_handling_end

    sub r4, r2, keyboard.key_min ; so the first value is 0
    lsl r4, r4, 3 ; 2 * instruction length = 8
    add r4, r4, game_loop_key_jump_table_start
    jmp r4

    game_loop_key_jump_table_start:
    ; key_up
    mov r1, game.direction_up
    jmp game_loop_event_handling_store_direction
    ; key_right
    mov r1, game.direction_right
    jmp game_loop_event_handling_store_direction
    ; key_down:
    mov r1, game.direction_down
    jmp game_loop_event_handling_store_direction
    ; key_left:
    mov r1, game.direction_left
;    jmp game_loop_event_handling_end

    game_loop_event_handling_store_direction:
    add r2, zr, ptr.state_robot
    add r2, r2, 2
    store_8 [r2], r1

    game_loop_event_handling_end:

    ;
    ;   Elapsed time check
    ;
    ; r1: address
    ; r2: now low / delay low
    ; r3: now high / delay high
    ; r4: next tick low
    ; r5: next tick high
    ;
    time_0 r2
    time_1 r3

    add r1, zr, ptr.next_tick_low
    load_32 r4, [r1]
    add r1, zr, ptr.next_tick_high
    load_32 r5, [r1]

    cmp r3, r5
    jb game_loop
    ja update_next_tick
    cmp r2, r4
    jb game_loop

    update_next_tick:
    add r1, zr, ptr.tick_duration_low
    load_32 r2, [r1]
    add r1, zr, ptr.tick_duration_high
    load_32 r3, [r1]
    add r4, r4, r2
    add r5, r5, r3
    cmp r4, r2
    jae store_next_tick
    add r5, r5, 1

    store_next_tick:
    add r1, zr, ptr.next_tick_low
    store_32 [r1], r4
    add r1, zr, ptr.next_tick_high
    store_32 [r1], r5


    ;
    ;   Robot movement
    ;
    ; r1 = robot's state address
    ; r2 = x
    ; r3 = y
    ; r4 = direction
    ; r5 = new x
    ; r6 = new y
    ; r7 = new position address
    ; r8 = new position content
    ; r9 = jump address
    add r1, zr, ptr.state_robot
    load_8 r2, [r1]
    add r1, r1, 1
    load_8 r3, [r1]
    add r1, r1, 1
    load_8 r4, [r1]

    mov r5, r2
    mov r6, r3

    lsl r9, r4, 3 ; 2 * instruction size = 8
    add r9, r9, game_loop_robot_movement_jump_table_start
    jmp r9

    game_loop_robot_movement_jump_table_start:
    ; direction_up
    sub r6, r6, 1
    jmp game_loop_robot_movement_try_move
    ; direction_right
    add r5, r5, 1
    jmp game_loop_robot_movement_try_move
    ; direction_down
    add r6, r6, 1
    jmp game_loop_robot_movement_try_move
    ; direction_left
    sub r5, r5, 1
    jmp game_loop_robot_movement_try_move
    ; direction_still
    jmp game_loop_robot_movement_none

    game_loop_robot_movement_try_move:
    push r2
    mov r1, r5
    mov r2, r6
    call game.get_tile_address_from_map_coord
    mov r7, r13
    pop r2

    ;
    ;   Collision handling
    ;
    load_8 r8, [r7]
    cmp r8, map.tiles.wall
    jne game_loop_robot_movement_some
    ; hit wall
    add r1, zr, ptr.state_robot
    add r1, r1, 2
    mov r4, game.direction_still
    store_8 [r1], r4
    jmp game_loop_robot_movement_none

    game_loop_robot_movement_some:
    ; TODO: handle coin and empty differently
    mov r8, map.tiles.empty
    store_8 [r7], r8

    add r1, zr, ptr.state_robot
    store_8 [r1], r5
    add r1, r1, 1
    store_8 [r1], r6

    ; clear old position
    mov r1, r2
    mov r2, r3
    mov r3, sprites.rotation_0
    mov r4, sprites.empty
    call drawing.draw_sprite_at_map_coord

    ; draw robot on new position
    mov r1, r5
    mov r2, r6
    mov r3, sprites.rotation_0
    mov r4, sprites.robot
    call drawing.draw_sprite_at_map_coord


    game_loop_robot_movement_none:

    ;
    ;   Ghost movement
    ;
    ; r1: ghost's state address
    ; r2: x
    ; r3: y
    ; r4: direction
    ; r5: x increment
    ; r6: y increment
    ; r7: new x
    ; r8: new y
    ; r9: new position address
    ; r10: new position content
    ; r11: jump address
    add r1, zr, ptr.state_ghost
    load_8 r2, [r1]
    add r1, r1, 1
    load_8 r3, [r1]
    add r1, r1, 1
    load_8 r4, [r1]

    mov r5, 0
    mov r6, 0

    lsl r11, r4, 3 ; 2 * instruction size = 8
    add r11, r11, game_loop_ghost_movement_jump_table_start
    jmp r11

    game_loop_ghost_movement_jump_table_start:
    ; direction_up
    sub r6, r6, 1
    jmp game_loop_ghost_movement_make_move
    ; direction_right
    add r5, r5, 1
    jmp game_loop_ghost_movement_make_move
    ; direction_down
    add r6, r6, 1
    jmp game_loop_ghost_movement_make_move
    ; direction_left
    sub r5, r5, 1
    ;jmp game_loop_ghost_movement_make_move
    ; direction_still (should never happen)

    game_loop_ghost_movement_make_move:
    add r7, r2, r5
    add r8, r3, r6
    add r1, zr, ptr.state_ghost
    store_8 [r1], r7
    add r1, r1, 1
    store_8 [r1], r8

    ; get tile at previous position
    push r2
    mov r1, r2
    mov r2, r3
    call game.get_tile_address_from_map_coord
    mov r9, r13
    pop r2

    ; draw tile at previous position
    load_8 r1, [r9]
    cmp r1, map.tiles.coin
    je game_loop_ghost_movement_old_tile_coin
    ; old tile empty
    mov r4, sprites.empty
    jmp game_loop_ghost_movement_draw_old_tile
    game_loop_ghost_movement_old_tile_coin:
    mov r4, sprites.coin

    game_loop_ghost_movement_draw_old_tile:
    mov r1, r2
    mov r2, r3
    mov r3, sprites.rotation_0
    call drawing.draw_sprite_at_map_coord

    ; draw ghost on new position
    mov r1, r7
    mov r2, r8
    mov r3, sprites.rotation_0
    mov r4, sprites.ghost
    call drawing.draw_sprite_at_map_coord

    ;
    ;   Check ahead for direction change
    ;
    add r1, r7, r5
    add r2, r8, r6
    call game.get_tile_address_from_map_coord

    load_8 r10, [r13]
    cmp r10, map.tiles.wall
    jne game_loop_ghost_movement_end
    ; increment direction
    add r1, zr, ptr.state_ghost
    add r1, r1, 2
    load_8 r4, [r1]
    add r4, r4, 1
    and r4, r4, 0b11 ; modulo 3
    store_8 [r1], r4

    game_loop_ghost_movement_end:

jmp game_loop


;/*******************************
;* src/lib/game.asm
;*******************************/


; /* Return the tile address from the given map coordinate

; Inputs:
;   r1: x map coordinate
;   r2: y map coordinate

; Outputs:
;   r13: tile address
; */
pub game.get_tile_address_from_map_coord:
    push r1
    push r2

    add r13, r1, map
    get_tile_address_from_map_coord_loop:
        cmp r2, 0
        je get_tile_address_from_map_coord_loop_end
        add r13, r13, map.width
        sub r2, r2, 1
        jmp get_tile_address_from_map_coord_loop
        get_tile_address_from_map_coord_loop_end:

    pop r2
    pop r1
    ret

;/*******************************
;* src/lib/drawing.asm
;*******************************/


; /* Draw the whole (fill the screen memory with the values of the sprites based on the map)

; Inputs:

; Outputs:

; Locals:
;   r1: x map coord
;   r2: y map coord
;   r3: sprite rotation
;   r4: sprite id
;   r12: rotation (returned by `sprite and rotation`)
;   r13: sprite (returned by `get_sprite_id_and_rotation`)
; */
pub drawing.draw_whole_map:
    push r1
    push r2
    push r3
    push r4
    push r12
    push r13

    mov r1, 0
    mov r2, 0

    draw_whole_map_loop:
        call sprite_rotation.get_sprite_id_and_rotation
        mov r3, r12
        mov r4, r13
        call drawing.draw_sprite_at_map_coord
        add r1, r1, 1
        cmp r1, map.width
        jne draw_whole_map_loop
        mov r1, 0
        add r2, r2, 1
        cmp r2, map.height
        jne draw_whole_map_loop

    pop r13
    pop r12
    pop r4
    pop r3
    pop r2
    pop r1

    ret

; /* Return the top-left pixel address of the tile at the given map coordinates

; Inputs:
;   r1: map x coord
;   r2: map y coord

; Locals:
;   r3: counter
;   r4: offset per tile row (screen width * tile height)

; Ouputs:
;   r13: the pixel address
; */
get_tile_address:
    push r3
    push r4

    mov r3, 0
    mov r4, 0
    get_tile_address_offset_per_row_loop:
        add r4, r4, screen.width
        add r3, r3, 1
        cmp r3, sprites.height
        jne get_tile_address_offset_per_row_loop

    add r13, zr, ptr.screen

    mov r3, 0
    get_tile_address_margin_top_loop:
        cmp r3, scene.margin_top
        je get_tile_address_margin_top_loop_end
        add r13, r13, screen.width
        add r3, r3, 1
        jmp get_tile_address_margin_top_loop
        get_tile_address_margin_top_loop_end:

    mov r3, 0
    get_tile_address_tile_row_loop:
        cmp r3, r2
        je get_tile_address_tile_row_loop_end
        add r13, r13, r4
        add r3, r3, 1
        jmp get_tile_address_tile_row_loop
        get_tile_address_tile_row_loop_end:

    add r13, r13, scene.margin_left
    mov r3, 0
    get_tile_address_tile_column_loop:
        cmp r3, r1
        je get_tile_address_tile_column_loop_end
        add r13, r13, sprites.width
        add r3, r3, 1
        jmp get_tile_address_tile_column_loop
        get_tile_address_tile_column_loop_end:

    pop r4
    pop r3
    ret

; /* Get address of given sprite id

; Inputs:
;   r1: sprite id

; Outputs:
;   r13: address

; Locals:
;       r2: pointer address
; */
get_sprite_address:
    push r1
    push r2

    cmp r1, sprites.max
    jbe get_sprite_address_ptr
    mov r1, sprites.unimplemented

    get_sprite_address_ptr:
    lsl r2, r1, arch.instruction_increment_shift
    add r2, r2, ptr.textures_addresses
    load_32 r13, [r2]

    pop r2
    pop r1
    ret

; /* Draw given sprite on the screen at given map coordinates

; Inputs:
;   r1: map x coord
;   r2: map y coord
;   r3: sprite rotation
;   r4: sprite id

; Outputs:

; Locals:
;   r1: screen address
;   r2: sprite address
;   r13: value returned by call to `get_tile_address` and `get_sprite_address`
; */
pub drawing.draw_sprite_at_map_coord:
    push r1
    push r2
    push r3
    push r4
    push r13

    call get_tile_address
    mov r1, r13
    push r1
    
    mov r1, r4
    call get_sprite_address
    mov r2, r13
    pop r1

    call draw_sprite

    pop r13
    pop r4
    pop r3
    pop r2
    pop r1
    ret

; /* Draw given sprite (by address) at given screen position (by address) with given rotation

; Inputs:
;   r1: screen address
;   r2: sprite address
;   r3: rotation

; Outputs:

; Locals:
;   r1: current screen pixel address
;   r4: x
;   r5: y
;   r6: current sprite pixel address
;   r7: color
;   r8: x increment
;   r9: y increment
; */
draw_sprite:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9

    mov r6, r2

    ; rotation
    draw_sprite_cmp_rotation_0:
        cmp r3, sprites.rotation_0
        jne draw_sprite_cmp_rotation_90
        mov r8, 1
        mov r9, 0
        jmp draw_sprite_loop_init
    draw_sprite_cmp_rotation_90:
        cmp r3, sprites.rotation_90
        jne draw_sprite_cmp_rotation_180
        add r6, r6, sprites.size
        sub r6, r6, sprites.width
        sub r8, zr, sprites.width
        mov r9, sprites.size
        add r9, r9, 1
        jmp draw_sprite_loop_init
    draw_sprite_cmp_rotation_180:
        cmp r3, sprites.rotation_180
        jne draw_sprite_cmp_rotation_270
        add r6, r6, sprites.size
        sub r6, r6, 1
        sub r8, zr, 1
        mov r9, 0
        jmp draw_sprite_loop_init
    draw_sprite_cmp_rotation_270:
        add r6, r6, sprites.width
        sub r6, r6, 1
        mov r8, sprites.width
        sub r9, zr, sprites.size
        sub r9, r9, 1
    
    draw_sprite_loop_init:
    mov r4, 0
    mov r5, 0
    draw_sprite_loop:
        load_8 r7, [r6]
        store_8 [r1], r7
        add r4, r4, 1
        add r1, r1, 1
        add r6, r6, r8
        cmp r4, sprites.width
        jne draw_sprite_loop
        mov r4, 0
        add r6, r6, r9
        add r1, r1, screen.width
        sub r1, r1, sprites.width
        add r5, r5, 1
        cmp r5, sprites.width
        jne draw_sprite_loop
        
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    ret

;/*******************************
;* src/lib/sprite_rotation.asm
;*******************************/


; /* Return the sprite id and rotation for the given map coordinates

; Inputs:
;     r1: x map coord
;     r2: y map coord

; Outputs:
;     r12: sprite rotation
;     r13: sprite id

; Locals:
;     r3: tile id
;     r4: map offset
;     r5: counter
;     r6: left tile id
;     r7: up tile id
;     r8: right tile id
;     r9: down tile id
; */
pub sprite_rotation.get_sprite_id_and_rotation:
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9

    add r4, r1, map
    mov r5, 0
    get_sprite_id_and_rotation_map_row_loop:
        cmp r5, r2
        je get_sprite_id_and_rotation_map_row_loop_end
        add r4, r4, map.width
        add r5, r5, 1
        jmp get_sprite_id_and_rotation_map_row_loop
    get_sprite_id_and_rotation_map_row_loop_end:

    mov r12, sprites.rotation_0 ; default rotation

    load_8 r3, [r4]
    lsl r3, r3, 3 ; 2*instruction_size = *8 = <<3
    add r3, r3, get_sprite_id_and_rotation_jump_table
    jmp r3

    get_sprite_id_and_rotation_jump_table:
    ; tile_empty
    mov r13, sprites.empty
    jmp get_sprite_id_and_rotation_return
    ; tiles_wall
    jmp get_sprite_id_and_rotation_wall
    nop
    ; tile_coin
    mov r13, sprites.coin
    jmp get_sprite_id_and_rotation_return

    get_sprite_id_and_rotation_wall:
    mov r6, 0
    mov r7, 0
    mov r8, 0
    mov r9, 0
    
    get_sprite_id_and_rotation_cmp_left:
        cmp r1, 0
        je get_sprite_id_and_rotation_cmp_up
        sub r4, r4, 1
        load_8 r6, [r4]
        add r4, r4, 1
    get_sprite_id_and_rotation_cmp_up:
        cmp r2, 0
        je get_sprite_id_and_rotation_cmp_right
        sub r4, r4, map.width
        load_8 r7, [r4]
        add r4, r4, map.width
    get_sprite_id_and_rotation_cmp_right:
        cmp r1, map.max_x
        je get_sprite_id_and_rotation_cmp_down
        add r4, r4, 1
        load_8 r8, [r4]
        sub r4, r4, 1
    get_sprite_id_and_rotation_cmp_down:
        cmp r2, map.max_y
        je get_sprite_id_and_rotation_check_connections
        add r4, r4, map.width
        load_8 r9, [r4]
        sub r4, r4, map.width

    get_sprite_id_and_rotation_check_connections:
    get_sprite_id_and_rotation_straight_0:
        cmp r7, map.tiles.wall
        jne get_sprite_id_and_rotation_straight_90
        cmp r9, map.tiles.wall
        jne get_sprite_id_and_rotation_straight_90
        mov r12, sprites.rotation_0
        mov r13, sprites.wall_straight
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_straight_90:
        cmp r6, map.tiles.wall
        jne get_sprite_id_and_rotation_corner_0
        cmp r8, map.tiles.wall
        jne get_sprite_id_and_rotation_corner_0
        mov r12, sprites.rotation_90
        mov r13, sprites.wall_straight
        jmp get_sprite_id_and_rotation_return

    get_sprite_id_and_rotation_corner_0:
        cmp r6, map.tiles.wall
        jne get_sprite_id_and_rotation_corner_180
        cmp r9, map.tiles.wall
        jne get_sprite_id_and_rotation_corner_90
        mov r12,sprites.rotation_0
        mov r13, sprites.wall_corner
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_corner_90:
        cmp r7, map.tiles.wall
        jne get_sprite_id_and_rotation_end_90
        mov r12,sprites.rotation_90
        mov r13, sprites.wall_corner
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_corner_180:
        cmp r8, map.tiles.wall
        jne get_sprite_id_and_rotation_end_0
        cmp r7, map.tiles.wall
        jne get_sprite_id_and_rotation_corner_270
        mov r12,sprites.rotation_180
        mov r13, sprites.wall_corner
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_corner_270:
        cmp r9, map.tiles.wall
        jne get_sprite_id_and_rotation_end_270
        mov r12,sprites.rotation_270
        mov r13, sprites.wall_corner
        jmp get_sprite_id_and_rotation_return

    get_sprite_id_and_rotation_end_0:
        cmp r9, map.tiles.wall
        jne get_sprite_id_and_rotation_end_180
        mov r12,sprites.rotation_0
        mov r13, sprites.wall_end
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_end_90:
        mov r12,sprites.rotation_90
        mov r13, sprites.wall_end
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_end_180:
        mov r12,sprites.rotation_180
        mov r13, sprites.wall_end
        jmp get_sprite_id_and_rotation_return
    get_sprite_id_and_rotation_end_270:
        mov r12,sprites.rotation_270
        mov r13, sprites.wall_end
        ;jmp get_sprite_id_and_rotation_return

    get_sprite_id_and_rotation_return:
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    ret
map:
U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1
U8 1    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 1
U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1
U8 1    U8 2    U8 2    U8 2    U8 1    U8 2    U8 2    U8 2    U8 2    U8 2    U8 1    U8 2    U8 2    U8 2    U8 1
U8 1    U8 2    U8 1    U8 2    U8 1    U8 1    U8 2    U8 1    U8 2    U8 1    U8 1    U8 2    U8 1    U8 2    U8 1
U8 1    U8 2    U8 1    U8 2    U8 2    U8 2    U8 2    U8 1    U8 2    U8 2    U8 2    U8 2    U8 1    U8 2    U8 1
U8 1    U8 2    U8 1    U8 2    U8 1    U8 1    U8 2    U8 1    U8 2    U8 1    U8 1    U8 2    U8 1    U8 2    U8 1
U8 1    U8 2    U8 2    U8 2    U8 1    U8 2    U8 2    U8 2    U8 2    U8 2    U8 1    U8 2    U8 2    U8 2    U8 1
U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1    U8 1    U8 1    U8 2    U8 1
U8 1    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 2    U8 1
U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1    U8 1
map_end:

sprite_empty:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
sprite_empty_end:

sprite_unimplemented:
U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11
U8 0b000_000_00 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b111_000_11 U8 0b000_000_00
sprite_unimplemented_end:

sprite_wall_end:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
sprite_wall_end_end:

sprite_wall_straight:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
sprite_wall_straight_end:

sprite_wall_corner:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_00 U8 0b000_000_00
sprite_wall_corner_end:

sprite_robot:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_111_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_111_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b000_111_00 U8 0b000_111_00 U8 0b000_111_00 U8 0b010_011_10 U8 0b000_111_00 U8 0b000_111_00 U8 0b000_111_00 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b010_011_10 U8 0b010_011_10 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
sprite_robot_end:

sprite_ghost:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b000_000_11 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_11 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b111_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
sprite_ghost_end:

sprite_coin:
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_110_00 U8 0b111_110_00 U8 0b111_110_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_110_00 U8 0b111_100_00 U8 0b111_110_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b111_110_00 U8 0b111_110_00 U8 0b111_110_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00 U8 0b000_000_00
sprite_coin_end:

;
; RESERVED RAM SPACE
;

; Sprite addresses jump table
pub ptr.textures_addresses:
U32 0 ; empty
U32 0 ; placeholder
U32 0 ; wall_end
U32 0 ; wall_straight
U32 0 ; wall_corner
U32 0 ; robot
U32 0 ; ghost
U32 0 ; coin

; 0.5 second = 500_000_000 nano second = 0x0000_0000_1DCD_6500
pub ptr.tick_duration_high: U32 0x0000_0000
pub ptr.tick_duration_low:  U32 0x1DCD_6500

; 1 second = 1_000_000_000 nano second = 0x0000_0000_3B9A_CA00
; pub ptr.tick_duration_high: U32 0x0000_0000
; pub ptr.tick_duration_low:  U32 0x3B9A_CA00

pub ptr.next_tick_high: U32 0
pub ptr.next_tick_low: U32 0

pub ptr.state_robot:
U8 0 ; x coord
U8 0 ; y coord
U8 0 ; direction

pub ptr.state_ghost:
U8 0 ; x coord
U8 0 ; y coord
U8 0 ; direction

pub ptr.screen:
