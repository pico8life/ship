function add_new_missile(x,y)
	-- find lock-on enemy
	local closest_x = 256
	local e_index = 0
	local i=1
	local initial_dest={x=0,y=0}
	for e in all(enemies) do
		local dist=abs(e.x-x)
		if dist<closest_x then
			e_index=i
			closest_x=dist
		end
		i += 1
	end
	if e_index==0 then
		initial_dest.x=x
		initial_dest.y=-100
	else
		initial_dest.x=enemies[e_index].x
		initial_dest.y=enemies[e_index].y
	end

	add(missiles, {
		x=x,
		y=y,
		dx=1,
		dy=1,
		accelx=0,
		accely=0.2,
		vel=-2,
		flare=0,
		target=e_index,
		target_dead=false,
		target_coords={x=initial_dest.x,y=initial_dest.y},
		update=function(self)

			function target_missile()
				local x_dist=self.target_coords.x-self.x
				local y_dist=self.target_coords.y-self.y
				local vec_dist=sqrt(x_dist*x_dist+y_dist*y_dist)
				local dir_x=x_dist/vec_dist
				local dir_y=y_dist/vec_dist
				if t % 5 == 0 then
					self.vel+=1
				end
				self.x+=dir_x*self.vel
				self.y+=dir_y*self.vel
			end
			-- particle fx here
			-- add_new_dust(self.x+4,self.y+8,rnd(0.5)-0.25,1+rnd(2), -- positions and velocity
			-- 	rnd(1)+1,rnd(1)+1,0,0.9,10) -- lifespan, radius, gravity, percent shrink, color
			for i=1,3 do
				add_new_dust(self.x+4,self.y+6,rnd(0.5)-0.25,1+rnd(2),
					rnd(2)+2,rnd(2),0,0.9,{9,9,10,10,10})
			end
			-- self.flare += 1
			-- if self.flare == 5 then self.flare = 0 end
			-- out-of-bounds check
			if outbound({-16,128}, self.y) then del(missiles, self) end

			-- target the missile towards the enemy
			target_missile()
			if bullet_coll(self) then
				del(missiles, self)
			end
			if not self.target_dead then
				if enemies[self.target].hp <= 0 then
					self.target_dead = true
				end
				self.target_coords.x=enemies[self.target].x
				self.target_coords.y=enemies[self.target].y
			end
		end,
		draw=function(self)
			spr(17, self.x, self.y)
			-- draw flare
			-- spr(self.flare+18, self.x,self.y+8)
			-- print(my_target.x, 9)
			-- print(my_target.y, 10)
		end
	})
end

function draw_missiles()
	for m in all(missiles) do
		m:draw()
	end
end

function update_missiles()
	for m in all(missiles) do
		m:update()
	end
end