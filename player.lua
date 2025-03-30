-- INIT

function init_player()
    p = {
        x = 28,
        y = 64,
        s_x = 0,
        s_y = 0,

        MAX_S_X = 3,
        MAX_S_Y = 3,
        ACC_X = 0.5,
        ACC_Y = 0.5,
    }

    pencil_line_heights = {}
end

-- UPDATE

function update_player()
    if btn(⬆️) then
        p.s_y = p.s_y - p.ACC_Y
    end
    if btn(⬇️) then
        p.s_y = p.s_y + p.ACC_Y
    end
    if not (btn(⬆️) or btn(⬇️)) then
        if not (sgn(p.s_y) == sgn(p.s_y + p.ACC_Y * -sgn(p.s_y))) then
            p.s_y = 0
        else
            p.s_y = p.s_y + p.ACC_Y * -sgn(p.s_y)
        end
    end

    p.s_y = mid(-p.MAX_S_Y, p.s_y, p.MAX_S_Y)
    p.s_x = mid(-p.MAX_S_X, p.s_x, p.MAX_S_X)
    
    p.x = p.x + p.s_x
    p.y = p.y + p.s_y

    update_pencil_pts()
end

function update_pencil_pts()
    add(pencil_line_heights, p.y)
    if #pencil_line_heights >= 40 then 
        deli(pencil_line_heights, 1)
    end
end

-- DRAW

function draw_player()
    local pencil_x = p.x - 10
    local pencil_y = p.y + 8
    spr_ol(32, 3, 1, pencil_x + scr_shake.x, pencil_y + scr_shake.y, false, false, false, 1) -- Draw pencil
    pset(pencil_x + 2 + scr_shake.x, pencil_y + 2 + scr_shake.y, 1)

    spr_ol(
        16 + (elapsed_time / 8) % 4, 
        1, 1, 
        p.x + scr_shake.x, p.y + scr_shake.y, 
        false, false, false, 1
    )

    draw_pencil_pts()
end

function draw_pencil_pts()
    for i = 2, #pencil_line_heights do
        line(
            p.x - 9 + i - #pencil_line_heights + scr_shake.x, 
            pencil_line_heights[i - 1] + 10 + scr_shake.y, 
            p.x - 8 + i - #pencil_line_heights + scr_shake.x, 
            pencil_line_heights[i] + 10 + scr_shake.y, 
            1
        )
    end
end
