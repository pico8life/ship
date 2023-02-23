function outbound(bnd, x_or_y)
	if x_or_y < bnd[1] or x_or_y > bnd[2] then
		return true
	end
	return false
end

function check_coll(obja, objb)
	if (abs(obja[1]-objb[1])) <= 8 and (abs(obja[2]-objb[2]) <= 8) then
		return true
	end
	return false
end