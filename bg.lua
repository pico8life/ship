function init_stars()
	starx = {}
	stary = {}
	for i=1,100 do
		add(starx, flr(rnd(128)))
		add(stary, flr(rnd(128)))
	end
end

function draw_stars()
	for i=1,#starx do
		pset(starx[i], stary[i], 7)
	end
end