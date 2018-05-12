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
Version: 18.05.10
]]

local function onefileonly(self)
      return #(boxes.files:selecteditems() or 'onetwothreefour')==1
end

local function needsselections(self)      
     return #(boxes.files:selecteditems() or '')>=1
end

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
                },
                fileviewer = {
                   kind='pivot',x=0,y=0,w="100%",h="100%",dbgid="File Viewer",
                   kids = {
                      -- The content is defined below
                   }
                }
             }             
          }
      }
      
}
guiscreens=gui.kids.screens.kids -- These are the "real" work screens
boxes=guiscreens.fileviewer.kids
boxes.files    = { id='filelist', x=0,y="5%",h="80%",w="95%",kind="listbox",bg=0.05,br=0.05,bb=0.05,alpha=.5,dbgid='Files of a JCR6 file',allowicons=true,multiselect=true,Select=function(self) print(string.char(27).."[32msomething is selected in: "..self.dbgid..string.char(27).."[0m") end}
boxes.fbuttons = { id='filebuttons', x="-22%", y="10.5%", kind='pivot',w="20%%",h=25, kids = {
     {id='fileinfo'   ,kind='button',x=0,y=0,w='100%',h=23,caption='Info',autoenable=onefileonly},
     {id='fileview'   ,kind='button',x=0,y=25,w='100%',h=23,caption='View',autoenable=onefileonly},
     {id='fileextract',kind='button',x=0,y=50,w='100%',h=23,caption='Extract',autoenable=needsselections}
}}


function GoScreen(screen)
   assert(guiscreens[screen],"Unknown screen: "..sval(screen))
   for k,s in pairs(guiscreens) do
       s.Visible=k==screen
   end
end
GoScreen('dragonme')   


CreateGadget(gui)
print(maneschijn_core.Tree()) -- I gotta know how things are going here. 
