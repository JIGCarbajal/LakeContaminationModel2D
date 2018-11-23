function [x] = binSrch(elem, tol, p)

        n = length(p);
        low = 1;
        high = n;
	mid=[];

        while(low <= high)
                mid = floor((low+high)/2);
                val = p(mid);
                if(val <= elem+tol && val >= elem-tol)
                        break;
                end
                if(val > elem+tol)
                        high = mid -1;
                else
                        low = mid +1;
                end
        end

        j = 0;
        k = 0;

	if(tol)
        	while(mid-j > 1 && p(mid-j)>elem-tol)
                	j = j + 1;
        	end

       		while(mid+k < n && p(mid+k)<elem+tol)
                	k = k + 1;
        	end
		
		x=[mid-j:mid+k];

        else
		while(mid-j > 1 && p(mid-j)==p(mid))
			j = j + 1;
		end

		while(mid+k < n && p(mid+k)==p(mid))
			k = k + 1;
		end

		x = [mid-j+1:mid+k-1];

	end
	


endfunction
