VALIDITY VDRD

ETL2 p.163, ETR p.39:
----------------------------------------------------------------------
Redeclaration rule

Let C be a class and g a feature of C. It is valid for g to be a
redeclaration of a feature f inherited from a parent B of C if and
only if the following conditions are satisfied:
1. No effective feature of C other than f and g has the same final
   name.
2. The signature of g conforms to the signature of f.
3. If g is a routine, its Precondition, if any, begins with require
   else (not just require), and its Postcondition, if any, begins
   with ensure then (not just ensure).
4. If the redeclaration is a redefinition (rather than an effecting)
   the Redefine subclause of the Parent part for B lists the final
   name of f in its Feature_list.
5. If f is inherited as effective, then g is also effective.
6. If f is an attribute, g is an attribute, f and g are both variable,
   and their types are either both expanded or both non-expanded.
7. If either one of f and g is an External routine, so is the other.
----------------------------------------------------------------------


TEST DESCRIPTION:
----------------------------------------------------------------------
Class BB inherits the effective CC.f and redeclares it. But the
feature is not listed in the Redefine subclause. Validity VDRD-4
is violated.
----------------------------------------------------------------------


TEST RESULTS:
----------------------------------------------------------------------
ISE Eiffel 5.0.016:    PASSED    Does not report VDRD-4 but reports
                                 VMFN instead.
SmallEiffel -0.76:     OK
Halstenbach 3.2:       PASSED    Does not report VDRD-4 but reports
                                 VMFN instead.
gelint:                OK
----------------------------------------------------------------------


TEST CLASSES:
----------------------------------------------------------------------
class AA

create

	make

feature

	make is
		local
			b: BB
		do
			!! b
			b.f
			print ("AA%N")
		end

end -- class AA
----------------------------------------------------------------------
class BB

inherit

	CC

feature

	f is
		do
			print ("BB%N")
		end

end -- class BB
----------------------------------------------------------------------
class CC

feature

	f is
		do
			print ("CC%N")
		end

end -- class CC
----------------------------------------------------------------------
