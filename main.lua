function _init()
	t = 0
	screen = 120
	ship = {sp=6, x=60, y=60, state=0}
	bullets = {}
	init_enemies()
	init_stars()

	--particles
	dust = {}
end


function _update()
	t = t+1


	if ship.state == 0 then
		move_ship()
		update_enemies()
	elseif ship.state == 1 then -- ship should explode
		--explode_fx(ship.x, ship.y, 4, {9,5}, 100)
		ship.state = 2
	end

	update_bullets()
	update_dust()
end

function _draw()
	cls()
	print(#enemies, 9)
	draw_dust()
	draw_enemies()
	for b in all(bullets) do
		spr(b.sp, b.x, b.y)
	end

	if ship.state == 0 then -- ship is alive
		spr(ship.sp, ship.x, ship.y)
	end
	draw_stars()
end