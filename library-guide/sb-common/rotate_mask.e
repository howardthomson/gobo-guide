expanded class ROTATE_MASK

feature

   width: INTEGER is 32
   height: INTEGER is 32
   x_hot: INTEGER is 9
   y_hot: INTEGER is 9
   bits: STRING is
   "%/248/%/031/%/000/%/000/%/248/%/031/%/000/%/000/%/240/%/079/%/000/%/000/%
   %%/248/%/231/%/000/%/000/%/252/%/243/%/001/%/000/%/254/%/225/%/003/%/000/%
   %%/254/%/192/%/003/%/000/%/095/%/192/%/007/%/000/%/015/%/128/%/007/%/000/%
   %%/015/%/128/%/007/%/000/%/015/%/128/%/007/%/000/%/031/%/208/%/007/%/000/%
   %%/030/%/248/%/003/%/000/%/062/%/252/%/003/%/000/%/124/%/254/%/001/%/000/%
   %%/056/%/255/%/000/%/000/%/144/%/127/%/000/%/000/%/192/%/255/%/000/%/000/%
   %%/192/%/255/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/254/%/007/%/000/%/000/%/254/%/007/%/000/%/000/%/254/%/007/%/000/%/000/%
   %%/142/%/007/%/000/%/000/%/046/%/007/%/000/%/000/%/110/%/006/%/000/%/000/%
   %%/238/%/004/%/000/%/000/%/238/%/001/%/000/%/000/%/238/%/003/%/000/%/000/%
   %%/238/%/007/%/000/%/000/%/224/%/015/%/000/%/000/%/224/%/031/%/000/%/000/%
   %%/224/%/003/%/000/%/000/%/096/%/003/%/000/%/000/%/032/%/006/%/000/%/000/%
   %%/000/%/006/%/000/%/000/%/000/%/012/%/000/%/000/%/000/%/012/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/255/%/015/%/000/%/000/%/255/%/015/%/000/%/000/%
   %%/255/%/015/%/000/%/000/%/255/%/015/%/000/%/000/%/255/%/015/%/000/%/000/%
   %%/255/%/015/%/000/%/000/%/255/%/015/%/000/%/000/%/255/%/015/%/000/%/000/%
   %%/255/%/015/%/000/%/000/%/255/%/007/%/000/%/000/%/255/%/015/%/000/%/000/%
   %%/255/%/031/%/000/%/000/%/240/%/063/%/000/%/000/%/240/%/063/%/000/%/000/%
   %%/240/%/007/%/000/%/000/%/112/%/015/%/000/%/000/%/048/%/015/%/000/%/000/%
   %%/000/%/030/%/000/%/000/%/000/%/030/%/000/%/000/%/000/%/030/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/008/%/000/%/000/%
   %%/000/%/028/%/000/%/000/%/000/%/062/%/000/%/000/%/000/%/127/%/000/%/000/%
   %%/000/%/008/%/000/%/000/%/000/%/008/%/000/%/000/%/254/%/255/%/063/%/000/%
   %%/254/%/255/%/063/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/254/%/255/%/063/%/000/%/254/%/255/%/063/%/000/%
   %%/000/%/008/%/000/%/000/%/000/%/008/%/000/%/000/%/000/%/127/%/000/%/000/%
   %%/000/%/062/%/000/%/000/%/000/%/028/%/000/%/000/%/000/%/008/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/008/%/000/%/000/%/000/%/028/%/000/%/000/%/000/%/062/%/000/%/000/%
   %%/000/%/127/%/000/%/000/%/128/%/255/%/000/%/000/%/128/%/255/%/000/%/000/%
   %%/255/%/255/%/127/%/000/%/255/%/255/%/127/%/000/%/255/%/255/%/127/%/000/%
   %%/255/%/255/%/127/%/000/%/000/%/000/%/000/%/000/%/255/%/255/%/127/%/000/%
   %%/255/%/255/%/127/%/000/%/255/%/255/%/127/%/000/%/255/%/255/%/127/%/000/%
   %%/128/%/255/%/000/%/000/%/128/%/255/%/000/%/000/%/000/%/127/%/000/%/000/%
   %%/000/%/062/%/000/%/000/%/000/%/028/%/000/%/000/%/000/%/008/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/099/%/000/%/000/%
   %%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%
   %%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%
   %%/254/%/227/%/063/%/000/%/254/%/227/%/063/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/254/%/227/%/063/%/000/%
   %%/254/%/227/%/063/%/000/%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%
   %%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%
   %%/000/%/099/%/000/%/000/%/000/%/099/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/255/%/247/%/127/%/000/%/255/%/247/%/127/%/000/%
   %%/255/%/247/%/127/%/000/%/255/%/247/%/127/%/000/%/000/%/000/%/000/%/000/%
   %%/255/%/247/%/127/%/000/%/255/%/247/%/127/%/000/%/255/%/247/%/127/%/000/%
   %%/255/%/247/%/127/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%
   %%/128/%/247/%/000/%/000/%/128/%/247/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%
   %%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/000/%/254/%/127/%
   %%/000/%/064/%/000/%/064/%/000/%/064/%/248/%/071/%/000/%/070/%/000/%/069/%
   %%/128/%/068/%/064/%/068/%/032/%/068/%/016/%/068/%/008/%/068/%/000/%/064/%
   %%/000/%/064/%/000/%/000/%/255/%/255/%/255/%/255/%/255/%/255/%/000/%/224/%
   %%/252/%/239/%/252/%/239/%/252/%/239/%/128/%/239/%/192/%/239/%/224/%/238/%
   %%/112/%/238/%/056/%/238/%/028/%/238/%/012/%/238/%/000/%/224/%/000/%/224/%
   %%/000/%/000/%/000/%/064/%/000/%/064/%/008/%/068/%/016/%/068/%/032/%/068/%
   %%/064/%/068/%/128/%/068/%/000/%/069/%/000/%/070/%/248/%/071/%/000/%/064/%
   %%/000/%/064/%/000/%/064/%/254/%/127/%/000/%/000/%/000/%/224/%/000/%/224/%
   %%/012/%/238/%/028/%/238/%/056/%/238/%/112/%/238/%/224/%/238/%/192/%/239/%
   %%/128/%/239/%/252/%/239/%/252/%/239/%/252/%/239/%/000/%/224/%/255/%/255/%
   %%/255/%/255/%/255/";
end
