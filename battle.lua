function update_battle()

end

function draw_battle()
    scr_shake.x = (rnd(2)-1) * scr_shake.intensity
    scr_shake.y = (rnd(2)-1) * scr_shake.intensity

    update_player()
    update_torus()
end