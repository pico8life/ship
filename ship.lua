function init_ship()
	ship = {sp=6, x=60, y=60, state=0}
	bullets = {}
	missiles = {}
end

function update_ship()
	local left_p = false
	local right_p = false
	local any_p = false
	local newx = ship.x
	local newy = ship.y
	local bnd = {0, screen}

	if btn(0) then
		if not outbound(bnd, newx-2) then
			newx -= 2
		end
		left_p = true
		any_p = true
	end
	if btn(1) then
		if not outbound(bnd, newx+2) then
			newx +=2
		end
		right_p = true
		any_p = true
	end
	if btn(2) then
		if not outbound(bnd, newy-2) then
			newy -=2
		end
		any_p = true
	end
	if btn(3) then
		if not outbound(bnd, newy+2) then
			newy +=2
		end
		any_p = true
	end
	if btnp(4) then fire() end

	if left_p then
		ship.sp = 5
	elseif right_p then
		ship.sp = 7
	else
		ship.sp = 6
	end

	-- Add particles!
	--flame_fx(ship.x+4, ship.y+7, 3, {10,8}, 1)
	for i=1,2 do
		add_new_dust(ship.x+4,ship.y+9,rnd(0.5)-0.25,1+rnd(2),rnd(10)+5,rnd(2)+1,0,0.9,{9,9,9,10,10})
	end

	-- Throw out a missile every 30 frames
	if t % 30 == 0 then add_new_missile(ship.x, ship.y) end

	ship.x = newx
	ship.y = newy
end


function fire()
	local b = {sp = 4, x = ship.x, y=(ship.y-1), dx=0, dy=-8}
	add(bullets, b)	
	-- add_new_missile(ship.x, ship.y)
	sfx(0)
end

function update_bullets()
	for b in all(bullets) do
		b.y += b.dy
		trail(b.x+4, b.y+2, 2, {5, 12, 12, 12}, 1)
		if is_bullet_offscreen(b) then
			del(bullets, b)
		end
		bullet_coll(b)
	end
end

function is_bullet_offscreen(b)
	if b.y < 0 or b.y > 128 then
		return true
	end
	return false
end

function draw_bullets()
	for b in all(bullets) do
		spr(b.sp, b.x, b.y)
	end
end