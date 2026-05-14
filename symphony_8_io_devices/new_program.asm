pub const arch.instruction_size = 4
pub const arch.instruction_increment_shift = 2
pub const game.direction_up = 0
pub const game.direction_right = 1
pub const game.direction_down = 2
pub const game.direction_left = 3
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
; map size 16x12 (or 15x11 with margins)
pub const map.width = 15
pub const map.height = 11
pub const map.size = 165 ; 11*15
pub const map.max_x = 14
pub const map.max_y = 10

pub const map.tiles.empty = 0
pub const map.tiles.wall = 1
pub const map.tiles.coin = 2
; given:
; - 16x12 tiles map
; - 5x5   pixels tile

pub const scene.margin_top = 2
pub const scene.margin_bottom = 3
pub const scene.margin_left = 2
pub const scene.margin_right = 3
/* Screen pixel mode (settings #0)
    0: ASCII  8
    1: ASCII 24
    2: Pixel  8
    3: Pixel 24

    While in mode #2 (Pixel 8)
        Screen memory offset (settings #1)
        Screen resolutions (settings #2)
*/
pub const screen.mode_index = 0
pub const screen.mode_value = 2
pub const screen.offset_index = 1
pub const screen.resolution_index = 2
pub const screen.resolution_value = 19 ; 80x60

pub const screen.width = 80
pub const screen.height = 60
pub const sprites.width = 5
pub const sprites.height = 5 ; unused as sprite are all square
pub const sprites.size = 25 ; height x width

pub const sprites.rotation_0 = 0
pub const sprites.rotation_90 = 1
pub const sprites.rotation_180 = 2
pub const sprites.rotation_270 = 3

pub const sprites.empty = 0 ; must stay 0 (some code avoid addition when it knows the tile is empty)
pub const sprites.unimplemented = 1

pub const sprites.robot = 2
pub const sprites.robot_up = 2
pub const sprites.robot_right = 3
pub const sprites.robot_down = 4
pub const sprites.robot_left = 5

pub const sprites.ghost = 6
pub const sprites.ghost_up = 6
pub const sprites.ghost_right = 7
pub const sprites.ghost_down = 8
pub const sprites.ghost_left = 9

pub const sprites.coin = 10
pub const sprites.max = 10 ; for lookup table

/*  Jump table initialisation

    r1: sprite id
    r2: pointer address
    r3: pointer value
*/

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

; sprite_robot_up
add r1, zr, sprites.robot_up
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_robot_up
store_32 [r2], r3
; sprite_robot_right
add r1, zr, sprites.robot_right
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_robot_right
store_32 [r2], r3
; sprite_robot_down
add r1, zr, sprites.robot_down
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_robot_down
store_32 [r2], r3
; sprite_robot_left
add r1, zr, sprites.robot_left
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_robot_left
store_32 [r2], r3

; sprite_ghost_up
add r1, zr, sprites.ghost_up
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_ghost_up
store_32 [r2], r3
; sprite_ghost_right
add r1, zr, sprites.ghost_right
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_ghost_right
store_32 [r2], r3
; sprite_ghost_down
add r1, zr, sprites.ghost_down
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_ghost_down
store_32 [r2], r3
; sprite_ghost_left
add r1, zr, sprites.ghost_left
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_ghost_left
store_32 [r2], r3

; sprite_coin
add r1, zr, sprites.coin
lsl r2, r1, arch.instruction_increment_shift
add r2, r2, ptr.textures_addresses
add r3, zr, sprite_coin
store_32 [r2], r3
; r1 = screen parameter value
mov r1, screen.mode_index
screen r1, screen.mode_value

mov r1, screen.offset_index
add r2, zr, screen
screen r1, r2

mov r1, screen.resolution_index
screen r1, screen.resolution_value

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

mov r3, sprites.robot_down
call drawing.draw_sprite_at_map_coord
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

mov r3, sprites.ghost_down
call drawing.draw_sprite_at_map_coord
/*
    r1, r2: now high, low
    r3, r4: initial delay high, low
    r5, r6: next tick high, low
    r7: pointer
*/
time_0 r2
time_1 r1

; Robot
add r7, zr, ptr.timer_robot_next_tick_high
load_32 r3, [r7]
add r7, zr, ptr.timer_robot_next_tick_low
load_32 r4, [r7]

call u64.add

add r7, zr, ptr.timer_robot_next_tick_high
store_32 [r7], r5
add r7, zr, ptr.timer_robot_next_tick_low
store_32 [r7], r6

; Ghost
add r7, zr, ptr.timer_ghost_next_tick_high
load_32 r3, [r7]
add r7, zr, ptr.timer_ghost_next_tick_low
load_32 r4, [r7]

call u64.add

add r7, zr, ptr.timer_ghost_next_tick_high
store_32 [r7], r5
add r7, zr, ptr.timer_ghost_next_tick_low
store_32 [r7], r6

game_loop:
/*  Event handling
    
    r1 = keyboard event+key / direction
    r2 = keyboard key / direction address
    r3 = keyboard event
    r4 = jump address
*/
keyboard r1
and r2, r1, keyboard.mask_key
and r3, r1, keyboard.mask_event

cmp r3, keyboard.event_pressed
jne handle_event_end
cmp r2, keyboard.key_min
jb handle_event_end
cmp r2, keyboard.key_max
ja handle_event_end

sub r4, r2, keyboard.key_min ; so the first value is 0
lsl r4, r4, 3 ; 2 * instruction length = 8
add r4, r4, handle_event_jump_table_start
jmp r4

handle_event_jump_table_start:
; key_up
mov r1, game.direction_up
jmp handle_event_store_direction
; key_right
mov r1, game.direction_right
jmp handle_event_store_direction
; key_down:
mov r1, game.direction_down
jmp handle_event_store_direction
; key_left:
mov r1, game.direction_left
;jmp handle_event_end

handle_event_store_direction:
add r2, zr, ptr.state_robot
add r2, r2, 2
store_8 [r2], r1

handle_event_end:

    /*
    For all timers:
        r1, r2: tick duration high, low
        r7, r8: now high, low
    */
    add r9, zr, ptr.tick_duration_high
    load_32 r1, [r9]
    add r9, zr, ptr.tick_duration_low
    load_32 r2, [r9]
    time_0 r8
    time_1 r7

    push r1
    push r2
    push r7
    push r8
/*  Timer comparison / update
    r1, r2: tick duration high, low [IN]
    r3, r4: next tick high, low
    r5, r6: tick after this one high, low
    r7, r8: now high, low [IN]
    r9: pointer
*/
add r9, zr, ptr.timer_robot_next_tick_high
load_32 r3, [r9]
add r9, zr, ptr.timer_robot_next_tick_low
load_32 r4, [r9]

cmp r7, r3
jb timer_robot.end
ja timer_robot.trigger
cmp r8, r4
jb timer_robot.end

pub timer_robot.trigger:
; udate next_tick
call u64.add
add r9, zr, ptr.timer_robot_next_tick_high
store_32 [r9], r5
add r9, zr, ptr.timer_robot_next_tick_low
store_32 [r9], r6


/*  Movement
    r1, r2: x, y
    r3: sprite id
    r4: direction
    r5, r6: increments x, y
    r7, r8: [RESERVED]
    r9: pointer
    r10: tile content
    r13: tile address
*/
add r9, zr, ptr.state_robot
load_8 r1, [r9]
add r9, r9, 1
load_8 r2, [r9]
add r9, r9, 1
load_8 r4, [r9]

call drawing.clear_tile

mov r5, 0
mov r6, 0

lsl r9, r4, 3 ; 2 * instruction size = 8
add r9, r9, timer_robot.direction_jump_table
jmp r9

pub timer_robot.direction_jump_table:
; direction_up
sub r6, r6, 1
jmp timer_robot.try_move
; direction_right
add r5, r5, 1
jmp timer_robot.try_move
; direction_down
add r6, r6, 1
jmp timer_robot.try_move
; direction_left
sub r5, r5, 1
;jmp timer_robot.try_move

/*
    Collision handling
*/
pub timer_robot.try_move:
add r1, r1, r5
add r2, r2, r6
call game.get_tile_address_from_map_coord
load_8 r10, [r13]
cmp r10, map.tiles.wall
jne timer_robot.move
; hit wall -> cancel movement
sub r1, r1, r5
sub r2, r2, r6
jmp timer_robot.draw

pub timer_robot.move:
; TODO: handle coin and empty differently
mov r10, map.tiles.empty
store_8 [r13], r10

add r9, zr, ptr.state_robot
store_8 [r9], r1
add r9, r9, 1
store_8 [r9], r2

pub timer_robot.draw:
; draw robot on new position
add r3, r4, sprites.robot
call drawing.draw_sprite_at_map_coord

pub timer_robot.end:
    pop r8
    pop r7
    pop r2
    pop r1

/*  Timer comparison / update
    r1, r2: tick duration high, low [IN]
    r3, r4: next tick high, low
    r5, r6: tick after this one high, low
    r7, r8: now high, low [IN]
    r9: pointer
*/
add r9, zr, ptr.timer_ghost_next_tick_high
load_32 r3, [r9]
add r9, zr, ptr.timer_ghost_next_tick_low
load_32 r4, [r9]

cmp r7, r3
jb timer_ghost.end
ja timer_ghost.trigger
cmp r8, r4
jb timer_ghost.end

pub timer_ghost.trigger:
; udate next_tick
call u64.add
add r9, zr, ptr.timer_ghost_next_tick_high
store_32 [r9], r5
add r9, zr, ptr.timer_ghost_next_tick_low
store_32 [r9], r6


/*  Movement
    r1, r2: x, y
    r3: sprite id
    r4: direction
    r5, r6: increments x, y
    r7, r8: [RESERVED]
    r9: pointer
    r10: tile content
    r13: tile address
*/
add r9, zr, ptr.state_ghost
load_8 r1, [r9]
add r9, r9, 1
load_8 r2, [r9]
add r9, r9, 1
load_8 r4, [r9]

call drawing.clear_tile

mov r5, 0
mov r6, 0

lsl r9, r4, 3 ; 2 * instruction size = 8
add r9, r9, timer_ghost.direction_jump_table
jmp r9

pub timer_ghost.direction_jump_table:
; direction_up
sub r6, r6, 1
jmp timer_ghost.move
; direction_right
add r5, r5, 1
jmp timer_ghost.move
; direction_down
add r6, r6, 1
jmp timer_ghost.move
; direction_left
sub r5, r5, 1
;jmp timer_ghost.move

pub timer_ghost.move:
add r1, r1, r5
add r2, r2, r6
add r9, zr, ptr.state_ghost
store_8 [r9], r1
add r9, r9, 1
store_8 [r9], r2

; draw ghost on new position
add r3, r4, sprites.ghost
call drawing.draw_sprite_at_map_coord

/*
    Check ahead for direction change
*/
add r1, r1, r5
add r2, r2, r6
call game.get_tile_address_from_map_coord

load_8 r10, [r13]
cmp r10, map.tiles.wall
jne timer_ghost.end
; increment direction
add r9, zr, ptr.state_ghost
add r9, r9, 2
load_8 r4, [r9]
add r4, r4, 1
and r4, r4, 0b11 ; modulo 3
store_8 [r9], r4

pub timer_ghost.end:

jmp game_loop

/*  Add two unsigned 64 bit

    Input:
        r1, r2: A.high, A.low
        r3, r4: B.high, B.low

    Output:
        r5, r6: C.high, C.low
*/
pub u64.add:
    add r5, r1, r3
    add r6, r2, r4
    cmp r6, r2
    jae u64.add_no_low_overflow
    add r5, r5, 1 ; overflow

    pub u64.add_no_low_overflow:
    ret
/* Return the tile address from the given map coordinate

    Inputs:
        r1: x map coordinate
        r2: y map coordinate

    Outputs:
        r13: tile address
*/
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
/*  Draw the tile corresponding to the given coordinate with it's map content

    Inputs:
        r1, r2: Map coordinates x, y

    Locals:
        r3: tile value / sprite id / sprite address offset
        r9: pointer
        r13: screen address
*/
pub drawing.clear_tile:
    push r1
    push r2
    push r3
    push r9
    push r13

    add r9, r1, map
    push r2
    pub drawing.clear_tile_row_loop:
        cmp r2, 0
        je drawing.clear_tile_row_loop_end
        sub r2, r2, 1
        add r9, r9, map.width
        jmp drawing.clear_tile_row_loop
    pub drawing.clear_tile_row_loop_end:
    pop r2

    load_8 r3, [r9]
    cmp r3, map.tiles.coin
    add r9, zr, ptr.textures_addresses
    jne drawing.clear_tile_get_screen_address
    ; coin
    mov r3, sprites.coin
    lsl r3, r3, arch.instruction_increment_shift
    add r9, r9, r3

    pub drawing.clear_tile_get_screen_address:
    call get_tile_address

    mov r1, r13
    load_32 r2, [r9]
    mov r3, sprites.rotation_0
    call draw_sprite

    pop r13
    pop r9
    pop r3
    pop r2
    pop r1
    ret

/* Return the top-left pixel address of the tile at the given map coordinates

    Inputs:
        r1: map x coord
        r2: map y coord

    Locals:
        r3: counter
        r4: offset per tile row (screen width * tile height)

    Ouputs:
        r13: the pixel address
*/
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

    add r13, zr, screen

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


/* Get address of given sprite id

    Inputs:
        r1: sprite id

    Outputs:
        r13: address

    Locals:
        r2: pointer address
*/
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

/* Draw given sprite on the screen at given map coordinates

    Inputs:
        r1: map x coord
        r2: map y coord
        r3: sprite id

    Locals:
        r1: screen address
        r2: sprite address
        r13: value returned by call to `get_tile_address` and `get_sprite_address`
*/
pub drawing.draw_sprite_at_map_coord:
    push r1
    push r2
    push r3
    push r13

    call get_tile_address
    push r13
    
    mov r1, r3
    call get_sprite_address

    mov r2, r13
    pop r13
    mov r1, r13
    call draw_sprite

    pop r13
    pop r3
    pop r2
    pop r1
    ret

/* Draw given sprite (by address) at given screen position (by address) with given rotation
    Inputs:
        r1: screen address
        r2: sprite address

    Locals:
        r1: current screen pixel address
        r2: current sprite pixel address
        r3: x
        r4: color
        r5: sprite last pixel address + 1
*/
draw_sprite:
    push r1
    push r2
    push r3
    push r4
    push r5
    
    add r5, r2, sprites.size

    mov r3, 0
    draw_sprite_loop:
        load_8 r4, [r2]
        store_8 [r1], r4

        add r1, r1, 1
        add r2, r2, 1
        add r3, r3, 1
        cmp r3, sprites.width
        jne draw_sprite_loop
        mov r3, 0
        add r1, r1, screen.width
        sub r1, r1, sprites.width
        cmp r5, r2
        jne draw_sprite_loop
        
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    ret

sprite_empty:
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
sprite_empty_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_unimplemented:
U8 227
U8 0
U8 227
U8 0
U8 227
U8 0
U8 227
U8 227
U8 227
U8 0
U8 227
U8 227
U8 0
U8 227
U8 227
U8 0
U8 227
U8 227
U8 227
U8 0
U8 227
U8 0
U8 227
U8 0
U8 227
sprite_unimplemented_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_robot_up:
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 110
U8 110
U8 110
U8 0
U8 224
U8 110
U8 110
U8 110
U8 224
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 224
U8 0
U8 224
U8 0
sprite_robot_up_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_robot_right:
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 110
U8 110
U8 28
U8 0
U8 0
U8 110
U8 224
U8 110
U8 0
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 0
U8 224
U8 0
U8 0
sprite_robot_right_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_robot_down:
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 28
U8 110
U8 28
U8 0
U8 224
U8 110
U8 110
U8 110
U8 224
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 224
U8 0
U8 224
U8 0
sprite_robot_down_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_robot_left:
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 28
U8 110
U8 110
U8 0
U8 0
U8 110
U8 224
U8 110
U8 0
U8 0
U8 110
U8 110
U8 110
U8 0
U8 0
U8 0
U8 224
U8 0
U8 0
sprite_robot_left_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_ghost_up:
U8 0
U8 224
U8 224
U8 224
U8 0
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 0
U8 224
U8 0
U8 224
sprite_ghost_up_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_ghost_right:
U8 0
U8 224
U8 224
U8 224
U8 0
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 224
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 0
U8 224
U8 0
U8 224
sprite_ghost_right_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_ghost_down:
U8 0
U8 224
U8 224
U8 224
U8 0
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 224
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 0
U8 224
U8 0
U8 224
sprite_ghost_down_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_ghost_left:
U8 0
U8 224
U8 224
U8 224
U8 0
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 224
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 0
U8 224
U8 0
U8 224
sprite_ghost_left_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
sprite_coin:
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
sprite_coin_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment

map:
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 2
U8 2
U8 2
U8 1
U8 2
U8 2
U8 2
U8 2
U8 2
U8 1
U8 2
U8 2
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 2
U8 2
U8 2
U8 1
U8 2
U8 2
U8 2
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 1
U8 2
U8 1
U8 1
U8 2
U8 2
U8 2
U8 1
U8 2
U8 2
U8 2
U8 2
U8 2
U8 1
U8 2
U8 2
U8 2
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 1
U8 2
U8 1
U8 1
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 2
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
U8 1
map_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment

; Sprite addresses jump table
pub ptr.textures_addresses:
U32 0 ; empty
U32 0 ; placeholder
U32 0 ; robot up
U32 0 ; robot right
U32 0 ; robot down
U32 0 ; robot left
U32 0 ; ghost up
U32 0 ; ghost right
U32 0 ; ghost down
U32 0 ; ghost left
U32 0 ; coin

; 0.5 second = 500_000_000 nano second = 0x0000_0000_1DCD_6500
pub ptr.tick_duration_high: U32 0x0000_0000
pub ptr.tick_duration_low:  U32 0x1DCD_6500

; 1 second = 1_000_000_000 nano second = 0x0000_0000_3B9A_CA00
; pub ptr.tick_duration_high: U32 0x0000_0000
; pub ptr.tick_duration_low:  U32 0x3B9A_CA00

pub ptr.timer_robot_next_tick_high: U32 0x0000_0000
pub ptr.timer_robot_next_tick_low: U32 0x1DCD_6500

pub ptr.timer_ghost_next_tick_high: U32 0
pub ptr.timer_ghost_next_tick_low: U32 0x0EE6_B280

pub ptr.state_robot:
U8 0 ; x coord
U8 0 ; y coord
U8 0 ; direction
U8 0 ; [padding]

pub ptr.state_ghost:
U8 0 ; x coord
U8 0 ; y coord
U8 0 ; direction
U8 0 ; [padding]

screen:
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 0
U8 240
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 224
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 3
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
U8 0
screen_end:
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
U8 0 ; padding to preserve 32 bits alignment
