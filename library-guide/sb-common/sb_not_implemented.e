class SB_NOT_IMPLEMENTED

feature

   	not_implemented is
      	do
         	excepts.raise("Not yet implemented");
      	end	

   	not_implemented_warn(msg: STRING) is
      	do
        	print("%"" + msg + "%" " + "is not implemented yet%N");
		end

	excepts: EXCEPTIONS is
    	once
        	create Result
      	end

end
