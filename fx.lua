function add_new_dust(_x,_y,_dx,_dy,_l,_s,_g,_p,_f)
	add(dust, {
		fade=_f,
		x=_x,
		y=_y,
		dx=_dx,
		dy=_dy,
		life=_l,
		orig_life=_l,
		rad=_s,
		p=_p,
		col=0, --set to color
		grav=_g,
		draw=function(self)
			--this function takes care
			--of drawing the particle
		
			--clear the palette
			pal()
		
			--draw the particle
			circfill(self.x,self.y,self.rad,self.col)
		end,
		update=function(self)
			--this is the update function
		
			--move the particle based on
			--the speed
			self.x+=self.dx
			self.y+=self.dy
			--and gravity
			self.dy+=self.grav
		
			--reduce the radius
			--this is set to 90%, but
			--could be altered
			self.rad*=self.p
		
			--reduce the life
			self.life-=1
		
			--set the color
			if type(self.fade)=="table" then
				--assign color from fade
				--this code works out how
				--far through the lifespan
				--the particle is and then
				--selects the color from the
				--table
				self.col=self.fade[flr(#self.fade*(self.life/self.orig_life))+1]
			else
				--just use a fixed color
				self.col=self.fade            
			end
			
			--if the dust has exceeded
			--its lifespan, delete it
			--from the table
			if self.life<0 then
				del(dust,self)
			end
		end
	})
end


function draw_dust()
	--draw dust
	for d in all(dust) do
		d:draw()
	end
end

function update_dust()
	for d in all(dust) do
		d:update()
	end
end

function trail(x,y,w,c_table,num)
	for i=0, num do
		add_new_dust(
			x+rnd(w)-w/2,  -- x
			y+rnd(w)-w/2,  -- y
			0,             -- dx
			flr(rnd(3))-1, -- dy
			15+rnd(5),      -- lifespan
			1,             -- starting radius
			0,             -- gravity
			0,             -- percent shrink
			c_table    -- color_table
		)
	end
end


function explode_fx(x,y,w,c_table,num)
	for i=0, num do
		add_new_dust(
			x,  -- x
			y,  -- y
			0,             -- dx
			flr(rnd(3))-1, -- dy
			5+rnd(5),      -- lifespan
			1,             -- starting radius
			0,             -- gravity
			0,             -- percent shrink
			c_table    -- color_table
		)
	end
end

function spark_fx(x,y,num)
	for i=0, num do
		add_new_dust(x+4,y+4,rnd(2)-1,rnd(2)-1,15,2,0,0.9,{9,10,10,8,8})
	end
end