class SB_NOT_IMPLEMENTED

feature

   	not_implemented
      	do
         	excepts.raise("Not yet implemented");
      	end	

   	not_implemented_warn(msg: STRING)
      	do
        	print("%"" + msg + "%" " + "is not implemented yet%N");
		end

	excepts: EXCEPTIONS
    	once
        	create Result
      	end

end
