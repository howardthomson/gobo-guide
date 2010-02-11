class SB_SERVER_RESOURCE_POINTER

feature

    resource_id : POINTER;

    is_attached: BOOLEAN is  
        do
            Result := resource_id /= default_pointer
        end
      
   detach_resource is
         -- Detach resource
        do
            reset_resource_id;
        ensure
            not is_attached
        end
	
	frozen reset_resource_id is
		do
            resource_id := default_pointer;
		end

	default_resource: like resource_id is
	   do
	   end

end
