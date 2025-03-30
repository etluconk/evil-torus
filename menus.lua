function init_menus()
    focus_btn_idx = 1  -- First button
    focus_menu_idx = 1 -- Main menu
    in_menus = true

    -- Main menu buttons
    menus = {
        { -- Main menu
            "start",
            "settings",
            "credits",
        },
        { -- Settings
            "♪ on ",
            "♪ off ",
            "okey dokey",
        },
        { -- Credits
            "okey dokey"
        }
    }

    menu_backs = {
        { nil, nil }, -- Main menu
        { 1,   2 },   -- Settings -> Main menu button 2
        { 1,   3 },   -- Credits -> Main menu button 3
    }

    for i = 1, #menus do -- Set up all menu buttons to be tables with an anim value
        for j = 1, #menus[i] do
            menus[i][j] = { menus[i][j], 0 }
        end
    end
end

function update_menus()
    -- Move focus around
    if in_menus then
        if btnp(➡️) or btnp(⬇️) then
            focus_btn_idx = focus_btn_idx + 1
            sfx(24)
        elseif btnp(⬅️) or btnp(⬆️) then
            focus_btn_idx = focus_btn_idx - 1
            sfx(24)
        end
    end
    -- Loop around focus
    focus_btn_idx = ((focus_btn_idx - 1) % #menus[focus_menu_idx]) + 1

    handle_button_selection()

    -- Update animation values
    for i = 1, #menus do
        for j = 1, #menus[i] do
            if focus_btn_idx == j and focus_menu_idx == i and in_menus then
                menus[i][j][2] = menus[i][j][2] + 0.1 -- Progress animation this button is focused
            else
                menus[i][j][2] = menus[i][j][2] - 0.1 -- Vice versa
            end
            -- Clamp all menu anim values
            menus[i][j][2] = mid(0, menus[i][j][2], 1)
        end
    end
end

function handle_button_selection()
    if in_menus then
        if btnp(🅾️) then
            sfx(23)

            local p_label = menus[focus_menu_idx][focus_btn_idx][1]
            label_to_action(p_label)
        end
        if btnp(❎) then
            if menu_backs[focus_menu_idx][1] ~= nil then -- Only allow going "back" a menu if you are in a submenu according to menu_backs
                sfx(22)
                go_back_a_menu()
            end
        end
    end
end

function draw_menu(x, y, menu, seperation, padding)
    local full_menu_width = 0
    for j = 1, #menus[menu] do   -- Get the whole menu group's half width
        full_menu_width = full_menu_width + (#menus[menu][j][1] * 4)
        if j < #menus[menu] then -- Add seperation between buttons, but keep it centered too
            full_menu_width = full_menu_width + seperation
        end
    end
    local half_menu_width = full_menu_width / 2

    local button_x = x - half_menu_width
    for j = 1, #menus[focus_menu_idx] do
        if j > 1 then
            -- button_x = button_x + (#menus[menu][j][1] * 4) + seperation
        end
        draw_button(button_x, y, menus[menu][j][1], 2, menus[menu][j][2],
            focus_btn_idx == j and focus_menu_idx == menu and in_menus)
        button_x = button_x + (#menus[menu][j][1] * 4) + seperation
    end
end

function draw_button(x, y, label, padding, anim, focused)
    local txt_width = #label * 4
    local total_padding = padding + (anim * 3)
    local col = 2
    local txt_col = 3
    if focused then
        col = 4
        txt_col = 1
    end

    rectfill(x - total_padding, y - total_padding + 1, x + txt_width + total_padding - 4, y + 3 + total_padding, col) -- Fill
    rect(x - total_padding - 1, y - total_padding, x + txt_width + total_padding - 3, y + 4 + total_padding, 1)       -- Outline
    if focused then
        line(x - total_padding, y + 3 + total_padding, x + txt_width + total_padding - 4, y + 3 + total_padding, 3)   -- Shadow
    end

    print(label, x - padding / 2, y, txt_col)
end

function draw_controls(y)
    if menu_backs[focus_menu_idx][1] ~= nil then -- Only show going "back" a menu if you are in a submenu according to menu_backs
        c_print_ol("🅾️ select    ❎ back", 58, y, 2, false, 1)
    else
        c_print_ol("🅾️ select", 62, y, 2, false, 1)
    end
end

function label_to_action(label)
    if label == "settings" then -- SETTINGS 
        switch_to_menu(2)
    elseif label == "♪ on " then
        if not music_activated then
            music(24)
        end
        music_activated = true
    elseif label == "♪ off " then
        music(-1)
        music_activated = false
    elseif label == "credits" then -- CREDITS
        switch_to_menu(3)
    elseif label == "okey dokey" then
        go_back_a_menu()
    elseif label == "start" then -- START GAME
        switch_to_scene("pre_world")
        music(-1)
        in_menus = false
    end
end

function switch_to_menu(menu)
    focus_menu_idx = menu
    focus_btn_idx = 1
end

function go_back_a_menu()
    focus_btn_idx = menu_backs[focus_menu_idx][2]
    focus_menu_idx = menu_backs[focus_menu_idx][1]
end
