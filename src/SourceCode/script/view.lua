--[[
	JCR6
	View settings
	
	
	
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
Version: 18.05.12
]]
local wd = love.filesystem.getSaveDirectory( ).."/SwapView/"
print("Working dir: ",wd)

local function bat(f)
   -- $IF $LINUX
      throw("Sorry due to the many differences in distros for Linux there is no support for this.")
      if true then return end -- This will fool parse checkers as they did not like my preprocessor.
   -- $FI
   local i=-1
   local sw,swif,swsh
   repeat
     i=i+1
     sw  =wd..("%x"):format(i)
     swif=sw.."_data."..ExtractExt(f):lower()   
     swsh=sw.."_pview.sh" 
     -- $IF $WINDOWS
        swsh=sw.."pview.bat"
     -- $FI   
   until (not love.filesystem.getInfo( swif )) and (not love.filesystem.getInfo( swsh )) 
   --JCR_Extract(wjcr,f,swif)
   local bnk=JCR_B(wjcr,f)
   local bt=io.open(swif,"wb")
   if not bt then
         print("FAIL: "..swif)
         throw("Couldn't create work file: "..swif)
         return
   end      
   bt:write(bnk)
   bt:close()
   bnk=nil
   if JCR_Error and JCR_Error~="" then 
      throw("JCR6 error\n\n"..JCR_Error)
   end   
   -- For Windows
   -- $IF $WINDOWS
   print("Preparing view for Windows")
   -- $FI
   -- For Mac and Linux
   -- $IF $DARWIN
   print("Preparing view for Darwin")
   local shout=[[
       exists()
       {
          command -v "%s" >/dev/null 2>&1
       }
       
       if exists bat; then
          bat --color always "%s" | less -R
       else
          less -R "%s"
       fi
   ]]
   if not love.filesystem.getInfo( swsh ) then      
      bt = io.open(swsh,'wb')
      if not bt then
      print("FAIL: "..swif)
         throw("Couldn't create work file: "..swsh)
         return
      end   
      bt:write(shout:format(swif,swif,swif))
      bt:close()
   end   
   local s='chmod +x "%s";open -a Terminal "%s"'
   print("Unix> "..s:format(swsh,swsh))
   os.execute(s:format(swsh,swsh))
   -- $FI   
end

local dov={
       unknown = function(f) warn("Unfortunately, I don't know how to view this file!") end,
       ['lua script'] = bat,
       ['markdown document'] = bat,
}











local function viewfunction(f)
    -- $USE libs/nothing
    dov[FileType(f):lower()](f)
end
return viewfunction
