-- INIT

function init_world()
    widescreen = false
    start_anim = 0
    start_anim_active = true
end

-- UPDATE

function update_world()
    if (start_anim < 1) then
        start_anim = start_anim + (1 - start_anim) / 20
    end
    if elapsed_time == 60 then
        in_dialogue = true
        sfx(23)
    end

    scr_shake.x = (rnd(2)-1) * scr_shake.intensity
    scr_shake.y = (rnd(2)-1) * scr_shake.intensity

    update_player()
    update_torus()
end

-- DRAW

function draw_world()
    cls(4)

    parallax_bg(-elapsed_time + scr_shake.x, -360 + start_anim * 250 + scr_shake.y)

    draw_player()
    draw_torus()
    draw_dialogue()

    parallax_fg(-elapsed_time + scr_shake.x, -360 + start_anim * 250 + scr_shake.y)

    -- Widescreen barz
    if widescreen then
        rectfill(0, 0, 128, 16, 6)
        rectfill(0, 128 - 16, 128, 128, 6)
    end
end

function parallax_bg(x, y)
    -- Big clouds 1
    map(16, 0, (x / 16) % 128, y / 16, 16, 16)
    map(16, 0, (x / 16) % 128 - 128, y / 16, 16, 16)

    -- Mountains / trees
    map(48, 0, (x / 4) % 128, y / 8, 16, 16)
    map(48, 0, (x / 4) % 128 - 128, y / 8, 16, 16)

    -- Big clouds 2
    pal_all(1)
    map(16, 0, (x / 2) % 128, y / 4 + 50, 16, 16)
    map(16, 0, (x / 2) % 128 - 128, y / 4 + 50, 16, 16)
    custom_pal()
end

function parallax_fg(x, y)
    -- Big clouds 3
    pal_all(6)
    map(16, 0, (x * 2) % 128, y / 2 + 100, 16, 16)
    map(16, 0, (x * 2) % 128 - 128, y / 2 + 100, 16, 16)
    rectfill(0, y / 2 + 228, 128, y / 2 + 400)
    custom_pal()
end
