expanded class HSPLIT_MASK

feature

   width: INTEGER is 32
   height: INTEGER is 32
   x_hot: INTEGER is 11
   y_hot: INTEGER is 11
   bits: STRING is
   "%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/224/%/247/%/003/%/000/%/240/%/247/%/007/%/000/%
   %%/248/%/247/%/015/%/000/%/252/%/247/%/031/%/000/%/254/%/247/%/063/%/000/%
   %%/252/%/247/%/031/%/000/%/248/%/247/%/015/%/000/%/240/%/247/%/007/%/000/%
   %%/224/%/247/%/003/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/008/%/000/%/000/%/000/%/028/%/000/%/000/%
   %%/000/%/062/%/000/%/000/%/000/%/127/%/000/%/000/%/000/%/028/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/032/%/028/%/002/%/000/%/048/%/028/%/006/%/000/%
   %%/248/%/255/%/015/%/000/%/252/%/255/%/031/%/000/%/248/%/255/%/015/%/000/%
   %%/048/%/028/%/006/%/000/%/032/%/028/%/002/%/000/%/000/%/028/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/000/%/127/%/000/%/000/%/000/%/062/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/000/%/008/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/008/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/000/%/062/%/000/%/000/%/000/%/127/%/000/%/000/%
   %%/128/%/255/%/000/%/000/%/128/%/255/%/000/%/000/%/096/%/062/%/003/%/000/%
   %%/112/%/062/%/007/%/000/%/248/%/255/%/015/%/000/%/252/%/255/%/031/%/000/%
   %%/254/%/255/%/063/%/000/%/252/%/255/%/031/%/000/%/248/%/255/%/015/%/000/%
   %%/112/%/062/%/007/%/000/%/096/%/062/%/003/%/000/%/128/%/255/%/000/%/000/%
   %%/128/%/255/%/000/%/000/%/000/%/127/%/000/%/000/%/000/%/062/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/000/%/008/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/252/%/000/%/000/%/000/%
   %%/060/%/000/%/000/%/000/%/092/%/000/%/000/%/000/%/140/%/000/%/000/%/000/%
   %%/020/%/001/%/000/%/000/%/036/%/002/%/000/%/000/%/064/%/004/%/000/%/000/%
   %%/128/%/008/%/000/%/000/%/000/%/017/%/000/%/000/%/000/%/034/%/001/%/000/%
   %%/000/%/068/%/001/%/000/%/000/%/136/%/001/%/000/%/000/%/208/%/001/%/000/%
   %%/000/%/224/%/001/%/000/%/000/%/248/%/001/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/254/%/001/%/000/%/000/%/254/%/001/%/000/%/000/%/254/%/001/%/000/%/000/%
   %%/254/%/000/%/000/%/000/%/254/%/001/%/000/%/000/%/254/%/003/%/000/%/000/%
   %%/254/%/007/%/000/%/000/%/238/%/015/%/000/%/000/%/192/%/031/%/000/%/000/%
   %%/128/%/191/%/003/%/000/%/000/%/255/%/003/%/000/%/000/%/254/%/003/%/000/%
   %%/000/%/252/%/003/%/000/%/000/%/248/%/003/%/000/%/000/%/252/%/003/%/000/%
   %%/000/%/252/%/003/%/000/%/000/%/252/%/003/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/128/%/000/%/002/%/000/%/192/%/000/%/006/%/000/%/160/%/255/%/011/%/000/%
   %%/016/%/000/%/016/%/000/%/008/%/000/%/032/%/000/%/016/%/000/%/016/%/000/%
   %%/160/%/255/%/011/%/000/%/192/%/000/%/006/%/000/%/128/%/000/%/002/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/128/%/001/%/003/%/000/%/192/%/001/%/007/%/000/%
   %%/224/%/255/%/015/%/000/%/240/%/255/%/031/%/000/%/248/%/255/%/063/%/000/%
   %%/252/%/255/%/127/%/000/%/248/%/255/%/063/%/000/%/240/%/255/%/031/%/000/%
   %%/224/%/255/%/015/%/000/%/192/%/001/%/007/%/000/%/128/%/001/%/003/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/016/%/000/%/000/%/000/%/040/%/000/%/000/%
   %%/000/%/068/%/000/%/000/%/000/%/130/%/000/%/000/%/000/%/199/%/001/%/000/%
   %%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%
   %%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%
   %%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%/000/%/068/%/000/%/000/%
   %%/000/%/199/%/001/%/000/%/000/%/130/%/000/%/000/%/000/%/068/%/000/%/000/%
   %%/000/%/040/%/000/%/000/%/000/%/016/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/";
end
