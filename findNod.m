function [y] = findNod(pos,d,p,po,i)	

	x = binSrch(pos(1),d,po(1,:)); 

	[Po,l] = sort(p(2,i(1,x)));

	idx = binSrch(pos(2),d,Po);

	y = i(1,x(l(idx)));

endfunction
