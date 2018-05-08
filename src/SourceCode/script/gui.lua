--[[
	GJCR6
	GUI initiation
	
	
	
	(c) Jeroen P. Broks, 2018, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 18.05.08
]]
local gui = {

      kind='quad',
      x=0,
      y=0,
      w="100%",
      h="100%",
      texture="metal.png",
      dbgid="metal background",
      kids = {
          logo={
             kind='quad',x=0,y=0,
             xwrap='clampzero',ywrap='clampzero',
             texture='jcr.png',
             -- 188x84
             w="23.5%",h="10.5%",
             kids={}
          },
          screens={
             kind='pivot',
             x="23.5%%",y=0,
             w="76.5%%",
             h="100%",
             dbgid='screens',
             kids={
                dragonme = {
                   kind='image',
                   x='50%',y='50%',
                   w="100%",h="100%",
                   xwrap='clampzero',ywrap='clampzero',
                   image='DragOnMe.png',
                   hoth="c",hotv="c",
                   dbgid="DragOnMe"
                }
             }             
          }
      }
      
}
guiscreens=gui.kids.screens.kids -- These are the "real" work screens


function GoScreen(screen)
   assert(guiscreens[screen],"Unknown screen: "..sval(screen))
   for k,s in pairs(guiscreens) do
       s.Visible=k==screen
   end
end
GoScreen('dragonme')   


CreateGadget(gui)
