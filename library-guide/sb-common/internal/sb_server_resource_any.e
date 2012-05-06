class SB_SERVER_RESOURCE_ANY

feature

    resource_id: ANY

    is_attached: BOOLEAN  
        do
            Result := resource_id /= Void
        end
      
   detach_resource
         -- Detach resource
        do
            reset_resource_id
        ensure
            not is_attached
        end
	
	frozen reset_resource_id
		do
            resource_id := Void
		end

	default_resource: like resource_id
	   do
	   end

end
