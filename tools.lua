function spr_ol(n, w, h, x, y, flip_x, flip_y, ol_circ, ol_col)
    pal_all(ol_col)
    for i = 0, 8 do
        local on_corner_idx = (i % 2 == 0)
        if ol_circ then
            if not on_corner_idx then
                spr(n, x + (i % 3) - 1, y + flr(i / 3) - 1, w, h, flip_x, flip_y)
            end
        else
            spr(n, x + (i % 3) - 1, y + flr(i / 3) - 1, w, h, flip_x, flip_y)
        end
    end
    custom_pal()
    spr(n, x, y, w, h, flip_x, flip_y)
end

function sspr_ol(s_x, s_y, s_w, s_h, x, y, w, h, flip_x, flip_y, ol_circ, ol_col)
    pal_all(ol_col)
    for i = 0, 8 do
        local on_corner_idx = (i % 2 == 0)
        if ol_circ then
            if not on_corner_idx then
                sspr(s_x, s_y, s_w, s_h, x + (i % 3) - 1, y + flr(i / 3) - 1, w, h, flip_x, flip_y)
            end
        else
            sspr(s_x, s_y, s_w, s_h, x + (i % 3) - 1, y + flr(i / 3) - 1, w, h, flip_x, flip_y)
        end
    end
    custom_pal()
    sspr(s_x, s_y, s_w, s_h, x, y, w, h, flip_x, flip_y)
end

function pal_all(col)
    custom_pal()
    for i = 1, 16 do
        pal(i, col)
    end
end

function custom_pal()
    pal()
    -- custom pallete generated by pallete-maker
    pal({[0]=0,130,136,143,135,131, 0},1)
end

function c_print(text, x, y, color)
    print(text, x - #text*2, y, color)
end

function c_print_ol(text, x, y, color, ol_circ, ol_col)
    for i = 0, 8 do
        local on_corner_idx = (i % 2 == 0)
        if ol_circ then
            if not on_corner_idx then
                print(text, x - #text*2 + (i % 3) - 1, y + flr(i / 3) - 1, ol_col)
            end
        else
            print(text, x - #text*2 + (i % 3) - 1, y + flr(i / 3) - 1, ol_col)
        end
    end
    print(text, x - #text*2, y, color)
end

function print_ol(text, x, y, color, ol_circ, ol_col)
    for i = 0, 8 do
        local on_corner_idx = (i % 2 == 0)
        if ol_circ then
            if not on_corner_idx then
                print(text, x + (i % 3) - 1, y + flr(i / 3) - 1, ol_col)
            end
        else
            print(text, x + (i % 3) - 1, y + flr(i / 3) - 1, ol_col)
        end
    end
    print(text, x, y, color)
end
