VALIDITY VHPR

ETL2 p.79 and ETR p.23:
----------------------------------------------------------------------
Parent Rule

The Inheritance clause of a class D is valid if and only if it meets
the following two conditions:
1. In every Parent clause for a class B, B is not a descendant of D.
2. If two or more Parent clauses are for classes which have a common
   ancestor A, D meets the conditions of the Repeated Inheritance
   Consistency constraint for A.
----------------------------------------------------------------------

ISE Eiffel:
----------------------------------------------------------------------
3. All types appearing in the Parent clauses are either class names
   or names of formal generic parameters of the class D.
----------------------------------------------------------------------


TEST DESCRIPTION:
----------------------------------------------------------------------
Class BB inherits from CC [DD [BIT name]], where `name' is a constant
attribute declared of value 32 in class BB. But 'BIT name' is not
only made up of class names nor names of formal generic parameters.
Validity VHPR-3 is violated.
----------------------------------------------------------------------


TEST RESULTS:
----------------------------------------------------------------------
ISE Eiffel 5.0.016:    FAILED     Does not report VHPR-3, but erroneously
                                  interprets 'BIT name' as 'BIT -1' and
                                  hence reports a VJAR in feature `f' of
                                  class BB where 'BIT name' has correctly
                                  been intrepreted as 'BIT 32'.
SmallEiffel -0.76:     PASSED     Does not report VHPR-3 and interprets
                                  'BIT name' as 'BIT 32'.
Halstenbach 3.2:       FAILED     Compiler crash in Degree 3.
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
			print (b.item.item.generating_type)
		end

end -- class AA
----------------------------------------------------------------------
class BB

inherit

	CC [DD [BIT name]]

feature

	name: INTEGER is 32

	f is
		local
			d: DD [BIT name]
		do
			!! d
			item := d
		end

end -- class BB
----------------------------------------------------------------------
class CC [G]

feature -- Access

	item: G

end -- class CC
----------------------------------------------------------------------
class DD [G]

feature 

	item: G

end -- class DD
----------------------------------------------------------------------
