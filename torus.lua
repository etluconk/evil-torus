function init_torus()
    t_states = {
        INTRO = 1,
        BEGIN_FIGHT = 2,
    }

    t = {
        x = 100,
        y = 72,
        s_x = 0,
        s_y = 0,
        w = 16,
        h = 16,
        state = t_states.INTRO,
        bob_about_size = 5,
    }
end

function update_torus()
    t.w = 20 + sin(elapsed_time / 70) * 3
    t.h = 20 + cos(elapsed_time / 63) * 3

    if t.state == t_states.INTRO then
        t.x = 90 + sin((elapsed_time + 60) / 120) * t.bob_about_size
        t.y = 64 + cos((elapsed_time + 60) / 120) * t.bob_about_size + 5
    elseif t.state == t_states.BEGIN_FIGHT then
        t.x = 90 + sin((elapsed_time + 60) / 120) * t.bob_about_size
        t.y = 64 + cos((elapsed_time + 60) / 120) * t.bob_about_size + 5
        scr_shake.intensity += 0.1
        if scr_shake.intensity > 25 then
            switch_to_scene("battle")
        end
    end
end

function draw_torus()
    sspr_ol(
        (flr(elapsed_time / 8) % 8) * 16, 64, 
        16, 16, 
        t.x - (t.w / 2) + scr_shake.x, 
        t.y - (t.h / 2) + scr_shake.y, 
        t.w, t.h, 
        false, false, false, 1
    )
end
