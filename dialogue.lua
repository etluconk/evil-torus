function init_dialogue()
    dialogue_targets = {
        BEN = 1,
        TORUS = 2,
    }
    dialogue_events = {
        TORUS_INTRO = 1,
    }
    in_dialogue = false

    dialogue_idx = 1
    dialogue_active_event = dialogue_events.TORUS_INTRO

    dialogue_txt = {}

    dialogue_txt[dialogue_events.TORUS_INTRO] = {
        {target = dialogue_targets.TORUS, txt = {"bleaagh!!!!"}},
        {target = dialogue_targets.TORUS, txt = {
            "who dares",
            "challenge i,",
            "the great and",
            "terrible...",
        }},
        {target = dialogue_targets.TORUS, txt = {"torus!!!",}},
        {target = dialogue_targets.BEN, txt = {
            "what the heck",
            "is a torus",
        }},
        {target = dialogue_targets.TORUS, txt = {"...",}},
        {target = dialogue_targets.TORUS, txt = {
            "it's another",
            "word for donut",
            "ok"
        }},
        {target = dialogue_targets.TORUS, txt = {
            "etluconk couldn't",
            "think of anything",
            "else that rhymes",
            "with norris",
        }},
        {target = dialogue_targets.BEN, txt = {"lol ok",}},
        {target = dialogue_targets.BEN, txt = {"anywaysss",}},
        {target = dialogue_targets.BEN, txt = {
            "iiii, ben norris,",
            "challenge you!!!"
        }},
        {target = dialogue_targets.TORUS, txt = {"so be it!",}},
        {target = dialogue_targets.TORUS, txt = {"prepare",}},
        {target = dialogue_targets.TORUS, txt = {"to",}},
        {target = dialogue_targets.TORUS, txt = {"die",}},
    }
end

function update_dialogue()

    if not in_dialogue then
        return
    end

    if btnp(🅾️) then
        if dialogue_idx == #dialogue_txt[dialogue_active_event] then
            in_dialogue = false
            handle_dialogue_ending()
        else
            dialogue_idx = dialogue_idx + 1
        end
        sfx(23)
    end
end

function handle_dialogue_ending()
    if dialogue_active_event == dialogue_events.TORUS_INTRO then
        t.state = t_states.BEGIN_FIGHT
        sfx(23)
    end
end

function draw_dialogue()

    if not in_dialogue then
        return
    end

    local current_speech_bubble = dialogue_txt[dialogue_active_event][dialogue_idx]
    if current_speech_bubble.target == dialogue_targets.BEN then
        draw_speech_bubble(
            current_speech_bubble.txt, 
            p.x + 12 + sin((elapsed_time + 60) / 100) * 2, 
            p.y - 12 + cos((elapsed_time + 60) / 90) * 2, 
            2, 
            false, true
        )
    elseif current_speech_bubble.target == dialogue_targets.TORUS then
        draw_speech_bubble(
            current_speech_bubble.txt, 
            t.x - 8 + sin((elapsed_time + 60) / 100) * 2, 
            t.y - 22 + cos((elapsed_time + 60) / 100) * 2,
             2, 
            true, true
        )
    end
end

function draw_speech_bubble(txt_lines, x, y, padding, is_right_anchor, is_bottom_anchor)
    local txt_height = #txt_lines * 6 - 1
    local txt_width = 0
    for i = 1, #txt_lines do -- Make sure the txt_width variable is set to the widest line
        if (#txt_lines[i] * 4) > txt_width then
            txt_width = #txt_lines[i] * 4
        end
    end
    txt_width = txt_width - 2

    local txt_x = x - tonum(is_right_anchor) * txt_width
    local txt_y = y - tonum(is_bottom_anchor) * txt_height

    rectfill(txt_x - padding, txt_y - padding, txt_x + txt_width + padding, txt_y + txt_height + padding, 4)
    line(txt_x - padding, txt_y + txt_height + padding, txt_x + txt_width + padding, txt_y + txt_height + padding, 3)
    rect(txt_x - padding - 1, txt_y - padding - 1, txt_x + txt_width + padding + 1, txt_y + txt_height + padding + 1, 1) -- Outline

    if is_right_anchor and is_bottom_anchor then
        spr(79, txt_x + txt_width + padding - 6, txt_y + txt_height + padding - 1)
    elseif is_right_anchor and (not is_bottom_anchor) then
        spr(78, txt_x + txt_width + padding - 6, txt_y - padding - 6, 1, 1, false, true)
    elseif (not is_right_anchor) and is_bottom_anchor then
        spr(79, txt_x - padding - 1, txt_y + txt_height + padding - 1, 1, 1, true, false)
    else
        spr(78, txt_x - padding - 1, txt_y - padding - 6, 1, 1, true, true)
    end

    for i = 1, #txt_lines do -- Draw text
        print(txt_lines[i], txt_x, txt_y + (i - 1) * 6, 1)
    end
end
