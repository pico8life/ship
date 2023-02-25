function init_stars()
	near_field = {}
	mid_field = {}
	far_field = {}
	function sub_init_stars(field, c, s)
		add(field, {x=flr(rnd(128)), y=flr(rnd(128)), c=c, s=s})
	end

	for i=1,100 do
		local speed = rnd(1.5)+.5
		local color = 6
		if speed < 1 then
			color = 1
		elseif speed < 1.5 then
			color = 13
		end
		sub_init_stars(near_field, color, speed)
	end
	-- for i=1,40 do
	-- 	sub_init_stars(mid_field, 13, rnd(1,1.5))
	-- end
	-- for i=1,40 do
	-- 	sub_init_stars(far_field, 5, rnd(.5,1))
	-- end
end

function draw_stars()
	function sub_draw_stars(t)
		pset(t.x, t.y, t.c)
	end
	for i=1,#near_field do
		sub_draw_stars(near_field[i])
	end
	-- for i=1,#mid_field do
	-- 	sub_draw_stars(mid_field[i])
	-- end
	-- for i=1,#far_field do
	-- 	sub_draw_stars(far_field[i])
	-- end
end

function update_stars()
	function sub_update_stars(t)
		t.y += t.s
		if t.y > 128 then
			t.y = 0
			t.x = flr(rnd(128))
		end
	end
	for i=1,#near_field do
		sub_update_stars(near_field[i])
	end
	-- for i=1,#mid_field do
	-- 	sub_update_stars(mid_field[i])
	-- end
	-- for i=1,#far_field do
	-- 	sub_update_stars(far_field[i])
	-- end
end