
function update_enemies()
	if #enemies == 0 then
		load_enemy_wave()
	else
		for e in all(enemies) do
			-- out-of-bounds detection
			if outbound(e.bound_x, e.x + e.dx) then
				e.dx = -e.dx
			end
			if outbound(e.bound_y, e.y + e.dy) then
				e.dy = -e.dy
			end

			-- ship collision detection
			if check_coll({e.x, e.y}, {ship.x, ship.y}) then
				sfx(1)
				ship.state = 1
			end

			-- Detect when to enter into ptrn phase
			if e.y >= e.ptrn_init and e.ptrn_phase == 0 then
				e.ptrn_phase=1
				e.originx=e.x
				e.originy=e.y
			end

			-- Move the ship, either in initial phase or ptrn phase
			if e.ptrn_phase == 0 then
				e.x += e.dx
				e.y += e.dy
			elseif e.ptrn_phase == 1 then
				e.ptrn_func(e)
			end

		end
	end
end

function bullet_coll(b)
	for e in all(enemies) do
		if check_coll({b.x, b.y}, {e.x, e.y}) then
			sfx(1)
			spark_fx(e.x,e.y,2)
			del(enemies, e)
		end
	end
end

function draw_enemies()
	for e in all(enemies) do
		spr(e.sp, e.x, e.y)
	end
end

function load_enemy_wave()
	for _, e in pairs(enemy_wave_dat[enemy_wave]) do
		add(enemies, e)
	end
	enemy_wave += 1
end

function circle_update(e)
	if e.ptrn_radius < e.ptrn_radius_max then e.ptrn_radius += e.ptrn_radius_rate end
	e.ptrn_angle += 2.5
	if e.ptrn_angle > 360 then e.ptrn_angle = 0 end
	e.x = e.originx+e.ptrn_radius*cos(e.ptrn_angle/360)
	e.y = e.originy+e.ptrn_radius*sin(e.ptrn_angle/360)
end