function _init()
	t = 0
	screen = 120
	init_ship()
	init_enemies()
	init_stars()

	--particles
	dust = {}
end


function _update()
	t = t+1


	update_missiles()
	if ship.state == 0 then
		update_ship()
		update_enemies()
	elseif ship.state == 1 then -- ship should explode
		--explode_fx(ship.x, ship.y, 4, {9,5}, 100)
		ship.state = 2
	end

	update_bullets()
	update_dust()
	update_stars()
end

function _draw()
	cls()
	print(#missiles, 9)
	draw_stars()
	draw_dust()
	draw_enemies()
	draw_bullets()
	draw_missiles()

	if ship.state == 0 then -- ship is alive
		spr(ship.sp, ship.x, ship.y)
	end
end