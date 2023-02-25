function init_enemies()
	enemies = {}
	enemy_wave = 1
	enemy_wave_dat = {}

	-- first wave
	for i=1,3 do
		local wave = {}
		for j=1,3 do
			add(wave, {
				sp=9,
				x=j*32,
				y=0,
				originx=0,
				originy=0,
				dx=0,
				dy=.25,
				bound_x={0,screen},
				bound_y={0,screen/2},
				ptrn_func=circle_update,
				ptrn_init=rnd(50,screen/4),
				ptrn_phase=0,
				ptrn_radius=0,
				ptrn_radius_rate=.2,
				ptrn_radius_max=10,
				ptrn_angle=0
			})
		end
		add(enemy_wave_dat, wave)
	end
end