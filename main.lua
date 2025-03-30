-- Init --

function _init()
    custom_pal()
    -- disable button repeat
    poke(0x5f5c, 255)
    -- disable resetting of pallete when entering editor
    -- poke(0x5f2e, 1)
    -- enable devkit mouse
    poke(0x5f2d, 0x1)

    -- Debug --

    -- Globals --

    elapsed_time = 0
    scene = "main_menu"
    music_activated = true
    scr_shake = {
        intensity = 0,
        x = 0,
        y = 0,
    }

    -- Init

    if (music_activated) then
        music(24)
    end
    init_menus()
    init_world()
    init_player()
    init_torus()
    init_dialogue()
end

function switch_to_scene(scn)
    scene = scn
    elapsed_time = 0
end

-- Update --

function _update60()
    -- Globals --

    elapsed_time = elapsed_time + 1

    -- Scenes

    if scene == "main_menu" then
        update_main_menu()
    elseif scene == "pre_world" then
        update_pre_world()
    elseif scene == "world" then
        update_world()
    end

    -- Menus

    update_menus()
    
    -- Dialogue

    update_dialogue()
end

function update_main_menu()

end

function update_pre_world()
    if elapsed_time > 180 then
        switch_to_scene("world")
        if (music_activated) then
            music(31)
        end
    end
    if elapsed_time == 60 then
        sfx(26)
    end
    if elapsed_time == 120 then
        sfx(27)
    end
end

-- Draw --

function _draw()
    cls(0)

    -- Scenes

    if scene == "main_menu" then
        draw_main_menu()
    elseif scene == "pre_world" then
        draw_pre_world()
    elseif scene == "world" then
        draw_world()
    end

    -- Dialogue

    -- Debug --
end

function draw_main_menu()
    for y = -2, 17 do
        for x = -2, 17 do
            spr(224 + ((x + y) % 2) * 16, x * 8 + (elapsed_time / 5) % 16, y * 8 + (elapsed_time / 10) % 16, 1, 1)
        end
    end
    if focus_menu_idx == 1 then
        map(0, 0, sin(elapsed_time / 240) * 3, -3 + cos(elapsed_time / 300) * 3, 16, 16)
    elseif focus_menu_idx == 2 then
        c_print_ol("wow so many settings", 64 + sin(elapsed_time / 240) * 3, 48 + cos(elapsed_time / 300) * 3, 4, false,
            1)
    elseif focus_menu_idx == 3 then
        c_print_ol("made by etluconk for", 64 + sin(elapsed_time / 240) * 3, 32 + cos(elapsed_time / 300) * 3, 4, false,
            1)
        c_print_ol("ben's birthday", 64 + sin(elapsed_time / 240) * 3, 40 + cos(elapsed_time / 300) * 3, 4, false, 1)
        c_print_ol("enjoy :)", 64 + sin(elapsed_time / 240) * 3, 56 + cos(elapsed_time / 300) * 3, 4, false, 1)
    end

    draw_menu(64, 96, focus_menu_idx, 7)
    draw_controls(116)
end

function draw_pre_world()
    if elapsed_time > 60 and elapsed_time < 120 then
        c_print_ol("are you ready?", 64, 64, 2, false, 1)
    end
end
